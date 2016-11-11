From: mzoran@crowfest.net (Michael Zoran)
Date: Thu, 10 Nov 2016 22:15:31 -0800
Subject: [PATCH v2] staging: vc04_services: rework ioctl code path
Message-ID: <20161111061531.23507-1-mzoran@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VCHIQ/vc04_services has a userland device interface
that includes ioctls. The current ioctl implementation
is a single monolithic function over 1,000+ lines
that handles 17 different ioctls through a complex
maze of switch and if statements.

The change reimplements that code path by breaking
up the code into smaller, easier to maintain functions
and uses a dispatch table to invoke the correct function.

Testing:

1. vchiq_test -f 10 and vchiq_test -p 1 were run from a native
64-bit OS(debian sid).

2. vchiq_test -f 10 and vchiq_test -p 1 where run from a 32-bit
chroot install from the same OS.

Both test cases pass.

This is V2 of this patch.  Changes include:

1. More code has been moved to the dispatch routine.
The dispatch routine is now responsible for copying the top-level
data into and out of kernel space by using the data encoded in
the ioctl command number.

2. The number of parameters have been reduced for the handling
functions by giving a different prototype to ioctls that pass
no arguments.

3. Macros in linux/compat.h are now used for compatibility data
structures.

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 1733 +++++++++++++-------
 .../interface/vchiq_arm/vchiq_ioctl.h              |   96 ++
 2 files changed, 1200 insertions(+), 629 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 8fcd940..4eb5d73 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -503,709 +503,1181 @@ vchiq_ioc_queue_message(VCHIQ_SERVICE_HANDLE_T handle,
 				   &context, total_size);
 }
 
-/****************************************************************************
-*
-*   vchiq_ioctl
-*
-***************************************************************************/
+struct vchiq_ioctl_entry;
+
+struct vchiq_ioctl_call_context {
+	VCHIQ_INSTANCE_T instance;
+	unsigned int cmd;
+	unsigned long arg;
+	const struct vchiq_ioctl_entry *ioctl_entry;
+	VCHIQ_SERVICE_T *service;
+	void *prev_kmalloc;
+	bool stackmem_used;
+	unsigned long stackmem[32 / sizeof(unsigned long)];
+};
+
+static void
+vchiq_init_ioctl_call_context(struct vchiq_ioctl_call_context *ctxt)
+{
+	ctxt->service = NULL;
+	ctxt->prev_kmalloc = NULL;
+	ctxt->stackmem_used = false;
+}
+
+static void vchiq_destroy_ioctl_call_context(struct vchiq_ioctl_call_context *ctxt)
+{
+	void *prev_kmalloc = ctxt->prev_kmalloc;
+
+	while (prev_kmalloc) {
+		void *tmp = prev_kmalloc;
+
+		prev_kmalloc = *(void **)prev_kmalloc;
+		kfree(tmp);
+	}
+
+	if (ctxt->service)
+		unlock_service(ctxt->service);
+}
+
+static void *
+vchiq_ioctl_kmalloc(struct vchiq_ioctl_call_context *ctxt, size_t size)
+{
+	void *mem;
+
+	if (!ctxt->stackmem_used && size < sizeof(ctxt->stackmem)) {
+		ctxt->stackmem_used = true;
+		return ctxt->stackmem;
+	}
+
+	mem = kmalloc(size + sizeof(void *), GFP_KERNEL);
+	if (!mem)
+		return NULL;
+
+	*(void **)mem = ctxt->prev_kmalloc;
+	ctxt->prev_kmalloc = mem;
+
+	return mem + sizeof(void *);
+}
+
+typedef long (*vchiq_ioctl_no_arg_func_t)(struct vchiq_ioctl_call_context *);
+
+typedef long (*vchiq_ioctl_ptr_arg_func_t)(struct vchiq_ioctl_call_context*,
+					   void *arg);
+
+struct vchiq_ioctl_entry {
+	void *func;
+	unsigned int ioctl;
+	void *aux_data;
+};
+
+static long
+vchiq_ioctl_dispatch(const struct vchiq_ioctl_entry *ioctl_entry,
+		     struct file *file, unsigned int cmd, unsigned long arg)
+{
+	long ret = 0;
+	unsigned int ioctl_dir;
+	unsigned int ioctl_size;
+	struct vchiq_ioctl_call_context ctxt;
+
+	if (ioctl_entry->ioctl != cmd)
+		return -ENOTTY;
+
+	ioctl_dir  = _IOC_DIR(cmd);
+	ioctl_size = _IOC_SIZE(cmd);
+
+	vchiq_init_ioctl_call_context(&ctxt);
+
+	ctxt.instance = file->private_data;
+	ctxt.cmd = cmd;
+	ctxt.arg = arg;
+	ctxt.ioctl_entry = ioctl_entry;
+
+	if (ioctl_dir == _IOC_NONE) {
+		vchiq_ioctl_no_arg_func_t func;
+
+		func = (vchiq_ioctl_no_arg_func_t)ioctl_entry->func;
+		ret = func(&ctxt);
+	} else {
+		vchiq_ioctl_ptr_arg_func_t func;
+		void *kptr;
+
+		kptr = vchiq_ioctl_kmalloc(&ctxt, ioctl_size);
+
+		if (!kptr) {
+			vchiq_destroy_ioctl_call_context(&ctxt);
+			return -ENOMEM;
+		}
+
+		if (ioctl_dir & _IOC_WRITE) {
+			if (copy_from_user(kptr, (void __user *)arg,
+					   ioctl_size)) {
+				vchiq_destroy_ioctl_call_context(&ctxt);
+				return -EFAULT;
+			}
+		}
+
+		func = (vchiq_ioctl_ptr_arg_func_t)ioctl_entry->func;
+		ret = func(&ctxt, kptr);
+
+		if (ret < 0) {
+			vchiq_destroy_ioctl_call_context(&ctxt);
+			return ret;
+		}
+
+		if (ioctl_dir & _IOC_READ) {
+			if (copy_to_user((void __user *)arg, kptr,
+					 ioctl_size)) {
+				vchiq_destroy_ioctl_call_context(&ctxt);
+				return -EFAULT;
+			}
+		}
+	}
+
+	vchiq_destroy_ioctl_call_context(&ctxt);
+	return ret;
+}
+
+static long vchiq_map_status(VCHIQ_STATUS_T status)
+{
+	if (status == VCHIQ_ERROR)
+		return -EIO;
+
+	if (status == VCHIQ_RETRY)
+		return -EINTR;
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_shutdown(VCHIQ_INSTANCE_T instance) {
+	VCHIQ_SERVICE_T *service = NULL;
+	int i;
+
+	if (!instance->connected)
+		return 0;
+
+	/* Remove all services */
+	i = 0;
+	while ((service = next_service_by_instance(instance->state,
+						   instance, &i)) != NULL) {
+		VCHIQ_STATUS_T status;
+
+		status = vchiq_remove_service(service->handle);
+		unlock_service(service);
+
+		if (status != VCHIQ_SUCCESS)
+			return vchiq_map_status(status);
+	}
+
+	/* Wake the completion thread and ask it to exit */
+	instance->closing = 1;
+	up(&instance->insert_event);
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_connect(VCHIQ_INSTANCE_T instance)
+{
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	int rc;
+
+	if (instance->connected)
+		return -EINVAL;
+
+	rc = mutex_lock_interruptible(&instance->state->mutex);
+	if (rc) {
+		vchiq_log_error(vchiq_arm_log_level,
+			"vchiq: connect: could not lock mutex for state %d: %d",
+			instance->state->id, rc);
+		return -EINTR;
+	}
+
+	status = vchiq_connect_internal(instance->state, instance);
+	mutex_unlock(&instance->state->mutex);
+
+	if (status != VCHIQ_SUCCESS) {
+		vchiq_log_error(vchiq_arm_log_level,
+				"vchiq: could not connect: %d", status);
+		return vchiq_map_status(status);
+	}
+
+	instance->connected = 1;
+	return 0;
+}
+
+static long
+vchiq_ioctl_instance_adapter(struct vchiq_ioctl_call_context *ctxt)
+{
+	long (*func)(VCHIQ_INSTANCE_T) = ctxt->ioctl_entry->aux_data;
+
+	return func(ctxt->instance);
+}
+
+static long
+vchiq_ioctl_create_service(struct vchiq_ioctl_call_context *ctxt,
+			   VCHIQ_CREATE_SERVICE_T *args)
+{
+	VCHIQ_INSTANCE_T instance = ctxt->instance;
+	VCHIQ_SERVICE_T *service = NULL;
+	USER_SERVICE_T *user_service = NULL;
+	void *userdata;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	int srvstate;
+
+	user_service = kmalloc(sizeof(USER_SERVICE_T), GFP_KERNEL);
+	if (!user_service)
+		return -ENOMEM;
+
+	if (args->is_open) {
+		if (!instance->connected) {
+			kfree(user_service);
+			return -ENOTCONN;
+		}
+		srvstate = VCHIQ_SRVSTATE_OPENING;
+	} else {
+		srvstate =
+			instance->connected ?
+			VCHIQ_SRVSTATE_LISTENING :
+			VCHIQ_SRVSTATE_HIDDEN;
+	}
+
+	userdata = args->params.userdata;
+	args->params.callback = service_callback;
+	args->params.userdata = user_service;
+	service = vchiq_add_service_internal(
+		instance->state,
+		&args->params, srvstate,
+		instance, user_service_free);
+
+	if (!service) {
+		kfree(user_service);
+		return -EEXIST;
+	}
+
+	user_service->service = service;
+	user_service->userdata = userdata;
+	user_service->instance = instance;
+	user_service->is_vchi = (args->is_vchi != 0);
+	user_service->dequeue_pending = 0;
+	user_service->close_pending = 0;
+	user_service->message_available_pos = instance->completion_remove - 1;
+	user_service->msg_insert = 0;
+	user_service->msg_remove = 0;
+	sema_init(&user_service->insert_event, 0);
+	sema_init(&user_service->remove_event, 0);
+	sema_init(&user_service->close_event, 0);
+
+	if (args->is_open) {
+		status = vchiq_open_service_internal
+			(service, instance->pid);
+		if (status != VCHIQ_SUCCESS) {
+			vchiq_remove_service(service->handle);
+			return vchiq_map_status(status);
+		}
+	}
+
+	args->handle = service->handle;
+	return 0;
+}
+
+static long
+vchiq_ioctl_close_service(VCHIQ_SERVICE_T *service)
+{
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	USER_SERVICE_T *user_service;
+
+	user_service =	(USER_SERVICE_T *)service->base.userdata;
+
+	/*
+	 * close_pending is false on first entry, and when the
+	 * wait in vchiq_close_service has been interrupted.
+	 */
+	if (!user_service->close_pending) {
+		status = vchiq_close_service(service->handle);
+		if (status != VCHIQ_SUCCESS)
+			return vchiq_map_status(status);
+	}
+
+	/*
+	 * close_pending is true once the underlying service
+	 * has been closed until the client library calls the
+	 * CLOSE_DELIVERED ioctl, signalling close_event.
+	 */
+	if (user_service->close_pending &&
+	    down_interruptible(&user_service->close_event))
+			return vchiq_map_status(VCHIQ_RETRY);
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_remove_service(VCHIQ_SERVICE_T *service) {
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	USER_SERVICE_T *user_service;
+
+	user_service =	(USER_SERVICE_T *)service->base.userdata;
+
+	/*
+	 * close_pending is false on first entry, and when the
+	 * wait in vchiq_close_service has been interrupted.
+	 */
+	if (!user_service->close_pending) {
+		status = vchiq_remove_service(service->handle);
+		if (status != VCHIQ_SUCCESS)
+			return vchiq_map_status(status);
+	}
+
+	/*
+	 * close_pending is true once the underlying service
+	 * has been closed until the client library calls the
+	 * CLOSE_DELIVERED ioctl, signaling close_event.
+	 */
+	if (user_service->close_pending &&
+	    down_interruptible(&user_service->close_event))
+			return vchiq_map_status(VCHIQ_RETRY);
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_use_service(VCHIQ_SERVICE_T *service) {
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+
+	status = vchiq_use_service_internal(service);
+
+	if (status != VCHIQ_SUCCESS) {
+		vchiq_log_error(vchiq_susp_log_level,
+			"vchiq_ioctl: cmd VCHIQ_IOC_USE_SERVICE returned error %d for service %c%c%c%c:%03d",
+			status,
+			VCHIQ_FOURCC_AS_4CHARS(
+			service->base.fourcc),
+			service->client_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_release_service(VCHIQ_SERVICE_T *service) {
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+
+	status = vchiq_release_service_internal(service);
+
+	if (status != VCHIQ_SUCCESS) {
+		vchiq_log_error(vchiq_susp_log_level,
+			"vchiq_ioctl: cmd VCHIQ_IOC_RELEASE_SERVICE returned error %d for service %c%c%c%c:%03d",
+			status,
+			VCHIQ_FOURCC_AS_4CHARS(
+			service->base.fourcc),
+			service->client_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_service_adapter(struct vchiq_ioctl_call_context *ctxt)
+{
+	long (*func)(VCHIQ_SERVICE_T *) = ctxt->ioctl_entry->aux_data;
+	VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)ctxt->arg;
+	long ret;
+
+	ctxt->service = find_service_for_instance(ctxt->instance, handle);
+
+	if (!ctxt->service)
+		return -EINVAL;
+
+	ret = func(ctxt->service);
+
+	return ret;
+}
+
+static long
+vchiq_ioctl_queue_message(struct vchiq_ioctl_call_context *ctxt,
+			  VCHIQ_QUEUE_MESSAGE_T *args) {
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	VCHIQ_ELEMENT_T *elements;
+
+	ctxt->service = find_service_for_instance(ctxt->instance, args->handle);
+
+	if (!ctxt->service)
+		return -EINVAL;
+
+	elements = vchiq_ioctl_kmalloc(ctxt,
+				       args->count * sizeof(VCHIQ_ELEMENT_T));
+
+	if (!elements)
+		return -ENOMEM;
+
+	if (copy_from_user(elements, args->elements,
+			   args->count * sizeof(VCHIQ_ELEMENT_T)))
+		return -EINVAL;
+
+	status = vchiq_ioc_queue_message(args->handle,
+					 elements, args->count);
+
+	return vchiq_map_status(status);
+}
+
+static long
+vchiq_ioctl_bulk_transfer(struct vchiq_ioctl_call_context *ctxt,
+			  VCHIQ_QUEUE_BULK_TRANSFER_T *args,
+			  VCHIQ_BULK_DIR_T dir)
+{
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	struct bulk_waiter_node *waiter = NULL;
+	void *userdata = args->userdata;
+
+	ctxt->service = find_service_for_instance(ctxt->instance, args->handle);
+	if (!ctxt->service)
+		return -EINVAL;
+
+	if (args->mode == VCHIQ_BULK_MODE_BLOCKING) {
+		waiter = kzalloc(sizeof(struct bulk_waiter_node), GFP_KERNEL);
+		if (!waiter)
+			return -ENOMEM;
+
+		userdata = &waiter->bulk_waiter;
+	} else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
+		struct list_head *pos;
+
+		mutex_lock(&ctxt->instance->bulk_waiter_list_mutex);
+
+		list_for_each(pos, &ctxt->instance->bulk_waiter_list)
+		{
+			if (list_entry(pos, struct bulk_waiter_node,
+				       list)->pid == current->pid) {
+				waiter = list_entry(pos,
+						    struct bulk_waiter_node,
+					list);
+				list_del(pos);
+				break;
+			}
+		}
+		mutex_unlock(&ctxt->instance->bulk_waiter_list_mutex);
+		if (!waiter) {
+			vchiq_log_error(vchiq_arm_log_level,
+					"no bulk_waiter found for pid %d",
+				current->pid);
+			return -ESRCH;
+		}
+		vchiq_log_info(vchiq_arm_log_level,
+			       "found bulk_waiter %pK for pid %d", waiter,
+			current->pid);
+		userdata = &waiter->bulk_waiter;
+	}
+
+	status = vchiq_bulk_transfer(args->handle,
+				     VCHI_MEM_HANDLE_INVALID,
+				     args->data,
+				     args->size,
+				     userdata,
+				     args->mode,
+				     dir);
+
+	if (!waiter)
+		return vchiq_map_status(status);
+
+	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
+	    !waiter->bulk_waiter.bulk) {
+		if (waiter->bulk_waiter.bulk) {
+			/*
+			 * Cancel the signal when the transfer
+			 * completes.
+			 */
+			spin_lock(&bulk_waiter_spinlock);
+			waiter->bulk_waiter.bulk->userdata = NULL;
+			spin_unlock(&bulk_waiter_spinlock);
+		}
+		kfree(waiter);
+	} else {
+		waiter->pid = current->pid;
+		mutex_lock(&ctxt->instance->bulk_waiter_list_mutex);
+		list_add(&waiter->list, &ctxt->instance->bulk_waiter_list);
+		mutex_unlock(&ctxt->instance->bulk_waiter_list_mutex);
+		vchiq_log_info(vchiq_arm_log_level,
+			       "saved bulk_waiter %pK for pid %d",
+			waiter, current->pid);
+
+		args->mode = VCHIQ_BULK_MODE_WAITING;
+	}
+
+	return vchiq_map_status(status);
+}
+
+static long
+vchiq_ioctl_bulk_transmit(struct vchiq_ioctl_call_context *ctxt,
+			  VCHIQ_QUEUE_BULK_TRANSFER_T *args) {
+	return vchiq_ioctl_bulk_transfer(ctxt, args, VCHIQ_BULK_TRANSMIT);
+};
+
+static long
+vchiq_ioctl_bulk_receive(struct vchiq_ioctl_call_context *ctxt,
+			 VCHIQ_QUEUE_BULK_TRANSFER_T *args) {
+	return vchiq_ioctl_bulk_transfer(ctxt, args, VCHIQ_BULK_RECEIVE);
+};
+
+typedef bool (*vchiq_get_msgbuf_ptr_callback_t)(void *context,
+						unsigned int msgbufcount,
+						void __user **msgbuf);
+
+typedef bool (*vchiq_put_completion_callback_t)(void *context,
+						unsigned int num,
+						VCHIQ_COMPLETION_DATA_T *completion);
+
+static long
+vchiq_ioctl_await_completion_internal(VCHIQ_INSTANCE_T instance,
+				      unsigned int count,
+				      unsigned int msgbufsize,
+				      unsigned int *argmsgbufcount,
+				      void *context,
+				      vchiq_get_msgbuf_ptr_callback_t get_msgbuf,
+				      vchiq_put_completion_callback_t put_completion)
+{
+	long ret = 0;
+	int msgbufcount;
+
+	DEBUG_INITIALISE(g_state.local);
+
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+
+	if (!instance->connected)
+		return -ENOTCONN;
+
+	mutex_lock(&instance->completion_mutex);
+
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+	while ((instance->completion_remove == instance->completion_insert)
+		&& !instance->closing) {
+		int rc;
+
+		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+		mutex_unlock(&instance->completion_mutex);
+		rc = down_interruptible(&instance->insert_event);
+		mutex_lock(&instance->completion_mutex);
+		if (rc != 0) {
+			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+			vchiq_log_info(vchiq_arm_log_level,
+				       "AWAIT_COMPLETION interrupted");
+			mutex_unlock(&instance->completion_mutex);
+			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+			return -EINTR;
+		}
+	}
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+
+	/*
+	 * A read memory barrier is needed to stop prefetch of a stale
+	 * completion record.
+	 */
+	rmb();
+
+	msgbufcount = *argmsgbufcount;
+	for (ret = 0; ret < count; ret++) {
+		VCHIQ_COMPLETION_DATA_T *completion;
+		VCHIQ_SERVICE_T *service;
+		USER_SERVICE_T *user_service;
+		VCHIQ_HEADER_T *header;
+
+		if (instance->completion_remove == instance->completion_insert)
+			break;
+		completion = &instance->completions[
+			instance->completion_remove &
+			(MAX_COMPLETIONS - 1)];
+
+		service = completion->service_userdata;
+		user_service = service->base.userdata;
+		completion->service_userdata = user_service->userdata;
+
+		header = completion->header;
+		if (header) {
+			void __user *msgbuf;
+			int msglen;
+
+			msglen = header->size + sizeof(VCHIQ_HEADER_T);
+			/* This must be a VCHIQ-style service */
+			if (msgbufsize < msglen) {
+				vchiq_log_error(
+					vchiq_arm_log_level,
+					"header %pK: msgbufsize %x < msglen %x",
+					header, msgbufsize,
+					msglen);
+				WARN(1, "invalid message size\n");
+				if (ret == 0)
+					ret = -EMSGSIZE;
+				break;
+			}
+			if (msgbufcount <= 0)
+				/*
+				 * Stall here for lack of a
+				 * buffer for the message.
+				 */
+				break;
+			/* Get the pointer from user space */
+			msgbufcount--;
+
+			if (get_msgbuf(context, msgbufcount, &msgbuf)) {
+				if (ret == 0)
+					ret = -EFAULT;
+				break;
+			}
+
+			/* Copy the message to user space */
+			if (copy_to_user(msgbuf, header,
+					 msglen) != 0) {
+				if (ret == 0)
+					ret = -EFAULT;
+				break;
+			}
+
+			/*
+			 * Now it has been copied, the message
+			 * can be released.
+			 */
+			vchiq_release_message(service->handle,
+					      header);
+
+			/*
+			 * The completion must point to the
+			 * msgbuf.
+			 */
+			completion->header = msgbuf;
+		}
+
+		if ((completion->reason ==
+			VCHIQ_SERVICE_CLOSED) &&
+			!instance->use_close_delivered)
+			unlock_service(service);
+
+		if (put_completion(context, (unsigned int)ret, completion)) {
+			if (ret == 0)
+				ret = -EFAULT;
+		}
+
+		instance->completion_remove++;
+	}
+
+	*argmsgbufcount = msgbufcount;
+
+	if (ret != 0)
+		up(&instance->remove_event);
+	mutex_unlock(&instance->completion_mutex);
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+
+	return ret;
+}
+
+static bool
+vchiq_ioctl_get_msgbuf(void *context,
+		       unsigned int msgbufcount,
+		       void __user **msgbuf)
+{
+	VCHIQ_AWAIT_COMPLETION_T *args = (VCHIQ_AWAIT_COMPLETION_T *)context;
+
+	return !!copy_from_user(msgbuf,
+				(const void __user *)
+				&args->msgbufs[msgbufcount],
+				sizeof(*msgbuf));
+}
+
+static bool
+vchiq_ioctl_put_completion(void *context,
+			   unsigned int num,
+			   VCHIQ_COMPLETION_DATA_T *completion)
+{
+	VCHIQ_AWAIT_COMPLETION_T *args = (VCHIQ_AWAIT_COMPLETION_T *)context;
+
+	return !!copy_to_user((void __user *)(
+			      (size_t)args->buf +
+			      num * sizeof(VCHIQ_COMPLETION_DATA_T)),
+			      completion,
+			      sizeof(VCHIQ_COMPLETION_DATA_T));
+}
+
+static long
+vchiq_ioctl_await_completion(struct vchiq_ioctl_call_context *ctxt,
+			     VCHIQ_AWAIT_COMPLETION_T *args)
+{
+	return vchiq_ioctl_await_completion_internal(ctxt->instance,
+						     args->count,
+						     args->msgbufsize,
+						     &args->msgbufcount,
+						     args,
+						     vchiq_ioctl_get_msgbuf,
+						     vchiq_ioctl_put_completion);
+}
+
+static long
+vchiq_ioctl_dequeue_message(struct vchiq_ioctl_call_context *ctxt,
+			    VCHIQ_DEQUEUE_MESSAGE_T *args)
+{
+	USER_SERVICE_T *user_service;
+	VCHIQ_HEADER_T *header;
+	long ret;
+
+	DEBUG_INITIALISE(g_state.local);
+
+	ctxt->service = find_service_for_instance(ctxt->instance,
+					    args->handle);
+	if (!ctxt->service)
+		return -EINVAL;
+
+	user_service = (USER_SERVICE_T *)ctxt->service->base.userdata;
+	if (user_service->is_vchi == 0)
+		return -EINVAL;
+
+	spin_lock(&msg_queue_spinlock);
+	if (user_service->msg_remove == user_service->msg_insert) {
+		if (!args->blocking) {
+			spin_unlock(&msg_queue_spinlock);
+			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+			return -EWOULDBLOCK;
+		}
+		user_service->dequeue_pending = 1;
+		do {
+			spin_unlock(&msg_queue_spinlock);
+			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+			if (down_interruptible(
+				&user_service->insert_event) != 0) {
+				vchiq_log_info(vchiq_arm_log_level,
+					       "DEQUEUE_MESSAGE interrupted");
+				return -EINTR;
+			}
+			spin_lock(&msg_queue_spinlock);
+		} while (user_service->msg_remove == user_service->msg_insert);
+	}
+
+	BUG_ON((int)(user_service->msg_insert - user_service->msg_remove) < 0);
+
+	header = user_service->msg_queue[user_service->msg_remove &
+		(MSG_QUEUE_SIZE - 1)];
+	user_service->msg_remove++;
+	spin_unlock(&msg_queue_spinlock);
+
+	up(&user_service->remove_event);
+	if (!header)
+		return -ENOTCONN;
+
+	if (header->size > args->bufsize) {
+		vchiq_log_error(vchiq_arm_log_level,
+				"header %pK: bufsize %x < size %x",
+			header, args->bufsize, header->size);
+		WARN(1, "invalid size\n");
+		return -EMSGSIZE;
+	}
+
+	if (!args->buf)
+		return -EMSGSIZE;
+
+	if (copy_to_user(args->buf,
+			 header->data,
+			 header->size))
+		return -EFAULT;
+
+	ret = header->size;
+	vchiq_release_message(ctxt->service->handle, header);
+
+	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+	return ret;
+}
+
 static long
-vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+vchiq_ioctl_get_client_handle(struct vchiq_ioctl_call_context *ctxt)
 {
-	VCHIQ_INSTANCE_T instance = file->private_data;
+	VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)ctxt->arg;
+
+	return vchiq_get_client_id(handle);
+}
+
+static long
+vchiq_ioctl_get_config(struct vchiq_ioctl_call_context *ctxt,
+		       VCHIQ_GET_CONFIG_T *args)
+{
+	VCHIQ_CONFIG_T config;
 	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
-	VCHIQ_SERVICE_T *service = NULL;
-	long ret = 0;
-	int i, rc;
-	DEBUG_INITIALISE(g_state.local)
 
-	vchiq_log_trace(vchiq_arm_log_level,
-		"vchiq_ioctl - instance %pK, cmd %s, arg %lx",
-		instance,
-		((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) &&
-		(_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
-		ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
-
-	switch (cmd) {
-	case VCHIQ_IOC_SHUTDOWN:
-		if (!instance->connected)
-			break;
+	if (args->config_size > sizeof(config))
+		return -EFAULT;
 
-		/* Remove all services */
-		i = 0;
-		while ((service = next_service_by_instance(instance->state,
-			instance, &i)) != NULL) {
-			status = vchiq_remove_service(service->handle);
-			unlock_service(service);
-			if (status != VCHIQ_SUCCESS)
-				break;
-		}
-		service = NULL;
+	status = vchiq_get_config(ctxt->instance, args->config_size, &config);
 
-		if (status == VCHIQ_SUCCESS) {
-			/* Wake the completion thread and ask it to exit */
-			instance->closing = 1;
-			up(&instance->insert_event);
-		}
+	if (status != VCHIQ_SUCCESS)
+		return vchiq_map_status(status);
 
-		break;
+	if (copy_to_user((void __user *)args->pconfig,
+			 &config, args->config_size))
+		return -EFAULT;
 
-	case VCHIQ_IOC_CONNECT:
-		if (instance->connected) {
-			ret = -EINVAL;
-			break;
-		}
-		rc = mutex_lock_interruptible(&instance->state->mutex);
-		if (rc != 0) {
-			vchiq_log_error(vchiq_arm_log_level,
-				"vchiq: connect: could not lock mutex for "
-				"state %d: %d",
-				instance->state->id, rc);
-			ret = -EINTR;
-			break;
-		}
-		status = vchiq_connect_internal(instance->state, instance);
-		mutex_unlock(&instance->state->mutex);
+	return 0;
+}
 
-		if (status == VCHIQ_SUCCESS)
-			instance->connected = 1;
-		else
-			vchiq_log_error(vchiq_arm_log_level,
-				"vchiq: could not connect: %d", status);
-		break;
+static long
+vchiq_ioctl_set_service_option(struct vchiq_ioctl_call_context *ctxt,
+			       VCHIQ_SET_SERVICE_OPTION_T *args)
+{
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
 
-	case VCHIQ_IOC_CREATE_SERVICE: {
-		VCHIQ_CREATE_SERVICE_T args;
-		USER_SERVICE_T *user_service = NULL;
-		void *userdata;
-		int srvstate;
+	ctxt->service = find_service_for_instance(ctxt->instance, args->handle);
+	if (!ctxt->service)
+		return -EINVAL;
 
-		if (copy_from_user
-			 (&args, (const void __user *)arg,
-			  sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
+	status = vchiq_set_service_option(
+		args->handle, args->option, args->value);
 
-		user_service = kmalloc(sizeof(USER_SERVICE_T), GFP_KERNEL);
-		if (!user_service) {
-			ret = -ENOMEM;
-			break;
-		}
+	return vchiq_map_status(status);
+}
 
-		if (args.is_open) {
-			if (!instance->connected) {
-				ret = -ENOTCONN;
-				kfree(user_service);
-				break;
-			}
-			srvstate = VCHIQ_SRVSTATE_OPENING;
-		} else {
-			srvstate =
-				 instance->connected ?
-				 VCHIQ_SRVSTATE_LISTENING :
-				 VCHIQ_SRVSTATE_HIDDEN;
-		}
+static long
+vchiq_ioctl_dump_phys_mem(struct vchiq_ioctl_call_context *ctxt,
+			  VCHIQ_DUMP_MEM_T *args)
+{
+	dump_phys_mem(args->virt_addr, args->num_bytes);
 
-		userdata = args.params.userdata;
-		args.params.callback = service_callback;
-		args.params.userdata = user_service;
-		service = vchiq_add_service_internal(
-				instance->state,
-				&args.params, srvstate,
-				instance, user_service_free);
-
-		if (service != NULL) {
-			user_service->service = service;
-			user_service->userdata = userdata;
-			user_service->instance = instance;
-			user_service->is_vchi = (args.is_vchi != 0);
-			user_service->dequeue_pending = 0;
-			user_service->close_pending = 0;
-			user_service->message_available_pos =
-				instance->completion_remove - 1;
-			user_service->msg_insert = 0;
-			user_service->msg_remove = 0;
-			sema_init(&user_service->insert_event, 0);
-			sema_init(&user_service->remove_event, 0);
-			sema_init(&user_service->close_event, 0);
-
-			if (args.is_open) {
-				status = vchiq_open_service_internal
-					(service, instance->pid);
-				if (status != VCHIQ_SUCCESS) {
-					vchiq_remove_service(service->handle);
-					service = NULL;
-					ret = (status == VCHIQ_RETRY) ?
-						-EINTR : -EIO;
-					break;
-				}
-			}
+	return 0;
+}
 
-			if (copy_to_user((void __user *)
-				&(((VCHIQ_CREATE_SERVICE_T __user *)
-					arg)->handle),
-				(const void *)&service->handle,
-				sizeof(service->handle)) != 0) {
-				ret = -EFAULT;
-				vchiq_remove_service(service->handle);
-			}
+static long
+vchiq_ioctl_lib_version(struct vchiq_ioctl_call_context *ctxt)
+{
+	unsigned int lib_version = (unsigned int)ctxt->arg;
 
-			service = NULL;
-		} else {
-			ret = -EEXIST;
-			kfree(user_service);
-		}
-	} break;
+	if (lib_version < VCHIQ_VERSION_MIN)
+		return -EINVAL;
 
-	case VCHIQ_IOC_CLOSE_SERVICE: {
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
-
-		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
-			USER_SERVICE_T *user_service =
-				(USER_SERVICE_T *)service->base.userdata;
-			/* close_pending is false on first entry, and when the
-                           wait in vchiq_close_service has been interrupted. */
-			if (!user_service->close_pending) {
-				status = vchiq_close_service(service->handle);
-				if (status != VCHIQ_SUCCESS)
-					break;
-			}
+	if (lib_version >= VCHIQ_VERSION_CLOSE_DELIVERED)
+		ctxt->instance->use_close_delivered = 1;
 
-			/* close_pending is true once the underlying service
-			   has been closed until the client library calls the
-			   CLOSE_DELIVERED ioctl, signalling close_event. */
-			if (user_service->close_pending &&
-				down_interruptible(&user_service->close_event))
-				status = VCHIQ_RETRY;
-		}
-		else
-			ret = -EINVAL;
-	} break;
+	return 0;
+}
 
-	case VCHIQ_IOC_REMOVE_SERVICE: {
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
-
-		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
-			USER_SERVICE_T *user_service =
-				(USER_SERVICE_T *)service->base.userdata;
-			/* close_pending is false on first entry, and when the
-                           wait in vchiq_close_service has been interrupted. */
-			if (!user_service->close_pending) {
-				status = vchiq_remove_service(service->handle);
-				if (status != VCHIQ_SUCCESS)
-					break;
-			}
+static long
+vchiq_ioctl_close_delivered(struct vchiq_ioctl_call_context *ctxt)
+{
+	VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)ctxt->arg;
 
-			/* close_pending is true once the underlying service
-			   has been closed until the client library calls the
-			   CLOSE_DELIVERED ioctl, signalling close_event. */
-			if (user_service->close_pending &&
-				down_interruptible(&user_service->close_event))
-				status = VCHIQ_RETRY;
-		}
-		else
-			ret = -EINVAL;
-	} break;
+	ctxt->service = find_closed_service_for_instance(ctxt->instance, handle);
+	if (!ctxt->service)
+		return -EINVAL;
 
-	case VCHIQ_IOC_USE_SERVICE:
-	case VCHIQ_IOC_RELEASE_SERVICE:	{
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	close_delivered((USER_SERVICE_T *)ctxt->service->base.userdata);
+	return 0;
+}
 
-		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
-			status = (cmd == VCHIQ_IOC_USE_SERVICE)	?
-				vchiq_use_service_internal(service) :
-				vchiq_release_service_internal(service);
-			if (status != VCHIQ_SUCCESS) {
-				vchiq_log_error(vchiq_susp_log_level,
-					"%s: cmd %s returned error %d for "
-					"service %c%c%c%c:%03d",
-					__func__,
-					(cmd == VCHIQ_IOC_USE_SERVICE) ?
-						"VCHIQ_IOC_USE_SERVICE" :
-						"VCHIQ_IOC_RELEASE_SERVICE",
-					status,
-					VCHIQ_FOURCC_AS_4CHARS(
-						service->base.fourcc),
-					service->client_id);
-				ret = -EINVAL;
-			}
-		} else
-			ret = -EINVAL;
-	} break;
+#define VCHIQ_MK_IOCTL(__ioctl, __func, __aux_data)	\
+	[_IOC_NR(__ioctl)] = {.func = __func, .ioctl = __ioctl, .aux_data = __aux_data}
+
+static const struct vchiq_ioctl_entry vchiq_ioctl_table[] = {
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CONNECT, vchiq_ioctl_instance_adapter, vchiq_ioctl_connect),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_SHUTDOWN, vchiq_ioctl_instance_adapter, vchiq_ioctl_shutdown),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CREATE_SERVICE, vchiq_ioctl_create_service, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CLOSE_SERVICE, vchiq_ioctl_service_adapter, vchiq_ioctl_close_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_REMOVE_SERVICE, vchiq_ioctl_service_adapter, vchiq_ioctl_remove_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_USE_SERVICE, vchiq_ioctl_service_adapter, vchiq_ioctl_use_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_RELEASE_SERVICE, vchiq_ioctl_service_adapter, vchiq_ioctl_release_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_MESSAGE, vchiq_ioctl_queue_message, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_BULK_TRANSMIT, vchiq_ioctl_bulk_transmit, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_BULK_RECEIVE, vchiq_ioctl_bulk_receive, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_AWAIT_COMPLETION, vchiq_ioctl_await_completion, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_DEQUEUE_MESSAGE, vchiq_ioctl_dequeue_message, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_GET_CLIENT_ID, vchiq_ioctl_get_client_handle, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_GET_CONFIG, vchiq_ioctl_get_config, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_SET_SERVICE_OPTION, vchiq_ioctl_set_service_option, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_DUMP_PHYS_MEM, vchiq_ioctl_dump_phys_mem, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_LIB_VERSION, vchiq_ioctl_lib_version, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CLOSE_DELIVERED, vchiq_ioctl_close_delivered, NULL),
+};
 
-	case VCHIQ_IOC_QUEUE_MESSAGE: {
-		VCHIQ_QUEUE_MESSAGE_T args;
-		if (copy_from_user
-			 (&args, (const void __user *)arg,
-			  sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
+/**************************************************************************
+ *
+ * vchiq_ioctl
+ *
+ **************************************************************************/
+static long
+vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	VCHIQ_INSTANCE_T instance = file->private_data;
+	long ret = 0;
+	unsigned int ioctl_nr;
 
-		service = find_service_for_instance(instance, args.handle);
+	ioctl_nr = _IOC_NR(cmd);
 
-		if ((service != NULL) && (args.count <= MAX_ELEMENTS)) {
-			/* Copy elements into kernel space */
-			VCHIQ_ELEMENT_T elements[MAX_ELEMENTS];
-			if (copy_from_user(elements, args.elements,
-				args.count * sizeof(VCHIQ_ELEMENT_T)) == 0)
-				status = vchiq_ioc_queue_message
-					(args.handle,
-					elements, args.count);
-			else
-				ret = -EFAULT;
-		} else {
-			ret = -EINVAL;
-		}
-	} break;
+	vchiq_log_trace(vchiq_arm_log_level,
+			"vchiq_ioctl - instance %pK, cmd %s, arg %lx",
+			instance,
+			((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) &&
+			(ioctl_nr <= VCHIQ_IOC_MAX)) ?
+			ioctl_names[ioctl_nr] : "<invalid>", arg);
 
-	case VCHIQ_IOC_QUEUE_BULK_TRANSMIT:
-	case VCHIQ_IOC_QUEUE_BULK_RECEIVE: {
-		VCHIQ_QUEUE_BULK_TRANSFER_T args;
-		struct bulk_waiter_node *waiter = NULL;
-		VCHIQ_BULK_DIR_T dir =
-			(cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT) ?
-			VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;
-
-		if (copy_from_user
-			(&args, (const void __user *)arg,
-			sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
+	if (ioctl_nr > VCHIQ_IOC_MAX) {
+		ret = -ENOTTY;
+	} else {
+		ret = vchiq_ioctl_dispatch(&vchiq_ioctl_table[ioctl_nr],
+					   file, cmd, arg);
+	}
 
-		service = find_service_for_instance(instance, args.handle);
-		if (!service) {
-			ret = -EINVAL;
-			break;
-		}
+	if ((ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
+		vchiq_log_info(vchiq_arm_log_level,
+			       "  ioctl instance %lx, cmd %s, %ld",
+			       (unsigned long)instance,
+			       (ioctl_nr <= VCHIQ_IOC_MAX) ?
+			       ioctl_names[ioctl_nr] :
+			       "<invalid>",
+			       ret);
+	else
+		vchiq_log_trace(vchiq_arm_log_level,
+				"  ioctl instance %lx, cmd %s, %ld",
+				(unsigned long)instance,
+				(ioctl_nr <= VCHIQ_IOC_MAX) ?
+				ioctl_names[ioctl_nr] :
+				"<invalid>",
+				ret);
 
-		if (args.mode == VCHIQ_BULK_MODE_BLOCKING) {
-			waiter = kzalloc(sizeof(struct bulk_waiter_node),
-				GFP_KERNEL);
-			if (!waiter) {
-				ret = -ENOMEM;
-				break;
-			}
-			args.userdata = &waiter->bulk_waiter;
-		} else if (args.mode == VCHIQ_BULK_MODE_WAITING) {
-			struct list_head *pos;
-			mutex_lock(&instance->bulk_waiter_list_mutex);
-			list_for_each(pos, &instance->bulk_waiter_list) {
-				if (list_entry(pos, struct bulk_waiter_node,
-					list)->pid == current->pid) {
-					waiter = list_entry(pos,
-						struct bulk_waiter_node,
-						list);
-					list_del(pos);
-					break;
-				}
 
-			}
-			mutex_unlock(&instance->bulk_waiter_list_mutex);
-			if (!waiter) {
-				vchiq_log_error(vchiq_arm_log_level,
-					"no bulk_waiter found for pid %d",
-					current->pid);
-				ret = -ESRCH;
-				break;
-			}
-			vchiq_log_info(vchiq_arm_log_level,
-				"found bulk_waiter %pK for pid %d", waiter,
-				current->pid);
-			args.userdata = &waiter->bulk_waiter;
-		}
-		status = vchiq_bulk_transfer
-			(args.handle,
-			 VCHI_MEM_HANDLE_INVALID,
-			 args.data, args.size,
-			 args.userdata, args.mode,
-			 dir);
-		if (!waiter)
-			break;
-		if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
-			!waiter->bulk_waiter.bulk) {
-			if (waiter->bulk_waiter.bulk) {
-				/* Cancel the signal when the transfer
-				** completes. */
-				spin_lock(&bulk_waiter_spinlock);
-				waiter->bulk_waiter.bulk->userdata = NULL;
-				spin_unlock(&bulk_waiter_spinlock);
-			}
-			kfree(waiter);
-		} else {
-			const VCHIQ_BULK_MODE_T mode_waiting =
-				VCHIQ_BULK_MODE_WAITING;
-			waiter->pid = current->pid;
-			mutex_lock(&instance->bulk_waiter_list_mutex);
-			list_add(&waiter->list, &instance->bulk_waiter_list);
-			mutex_unlock(&instance->bulk_waiter_list_mutex);
-			vchiq_log_info(vchiq_arm_log_level,
-				"saved bulk_waiter %pK for pid %d",
-				waiter, current->pid);
-
-			if (copy_to_user((void __user *)
-				&(((VCHIQ_QUEUE_BULK_TRANSFER_T __user *)
-					arg)->mode),
-				(const void *)&mode_waiting,
-				sizeof(mode_waiting)) != 0)
-				ret = -EFAULT;
-		}
-	} break;
+	return ret;
+}
 
-	case VCHIQ_IOC_AWAIT_COMPLETION: {
-		VCHIQ_AWAIT_COMPLETION_T args;
+#if defined(CONFIG_COMPAT)
 
-		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-		if (!instance->connected) {
-			ret = -ENOTCONN;
-			break;
-		}
+static long
+vchiq_ioctl_compat_create_service(struct vchiq_ioctl_call_context *ctxt,
+				  struct vchiq_create_service32 *args32)
+{
+	VCHIQ_CREATE_SERVICE_T args;
+	long ret;
 
-		if (copy_from_user(&args, (const void __user *)arg,
-			sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
+	args.params.fourcc   = args32->params.fourcc;
+	args.params.callback = NULL;
+	args.params.userdata = compat_ptr(args32->params.userdata);
+	args.params.version = args32->params.version;
+	args.params.version_min = args32->params.version_min;
+	args.is_open = args32->is_open;
+	args.is_vchi = args32->is_vchi;
+	args.handle  = args32->handle;
 
-		mutex_lock(&instance->completion_mutex);
+	ret = vchiq_ioctl_create_service(ctxt, &args);
 
-		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-		while ((instance->completion_remove ==
-			instance->completion_insert)
-			&& !instance->closing) {
-			int rc;
-			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-			mutex_unlock(&instance->completion_mutex);
-			rc = down_interruptible(&instance->insert_event);
-			mutex_lock(&instance->completion_mutex);
-			if (rc != 0) {
-				DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-				vchiq_log_info(vchiq_arm_log_level,
-					"AWAIT_COMPLETION interrupted");
-				ret = -EINTR;
-				break;
-			}
-		}
-		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+	if (ret >= 0)
+		args32->handle = args.handle;
 
-		/* A read memory barrier is needed to stop prefetch of a stale
-		** completion record
-		*/
-		rmb();
-
-		if (ret == 0) {
-			int msgbufcount = args.msgbufcount;
-			for (ret = 0; ret < args.count; ret++) {
-				VCHIQ_COMPLETION_DATA_T *completion;
-				VCHIQ_SERVICE_T *service;
-				USER_SERVICE_T *user_service;
-				VCHIQ_HEADER_T *header;
-				if (instance->completion_remove ==
-					instance->completion_insert)
-					break;
-				completion = &instance->completions[
-					instance->completion_remove &
-					(MAX_COMPLETIONS - 1)];
-
-				service = completion->service_userdata;
-				user_service = service->base.userdata;
-				completion->service_userdata =
-					user_service->userdata;
-
-				header = completion->header;
-				if (header) {
-					void __user *msgbuf;
-					int msglen;
-
-					msglen = header->size +
-						sizeof(VCHIQ_HEADER_T);
-					/* This must be a VCHIQ-style service */
-					if (args.msgbufsize < msglen) {
-						vchiq_log_error(
-							vchiq_arm_log_level,
-							"header %pK: msgbufsize %x < msglen %x",
-							header, args.msgbufsize,
-							msglen);
-						WARN(1, "invalid message "
-							"size\n");
-						if (ret == 0)
-							ret = -EMSGSIZE;
-						break;
-					}
-					if (msgbufcount <= 0)
-						/* Stall here for lack of a
-						** buffer for the message. */
-						break;
-					/* Get the pointer from user space */
-					msgbufcount--;
-					if (copy_from_user(&msgbuf,
-						(const void __user *)
-						&args.msgbufs[msgbufcount],
-						sizeof(msgbuf)) != 0) {
-						if (ret == 0)
-							ret = -EFAULT;
-						break;
-					}
-
-					/* Copy the message to user space */
-					if (copy_to_user(msgbuf, header,
-						msglen) != 0) {
-						if (ret == 0)
-							ret = -EFAULT;
-						break;
-					}
-
-					/* Now it has been copied, the message
-					** can be released. */
-					vchiq_release_message(service->handle,
-						header);
+	return ret;
+}
 
-					/* The completion must point to the
-					** msgbuf. */
-					completion->header = msgbuf;
-				}
+static long
+vchiq_ioctl_compat_queue_message(struct vchiq_ioctl_call_context *ctxt,
+				 struct vchiq_queue_message32 *args32) {
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	VCHIQ_ELEMENT_T *elements;
+	struct vchiq_element32 *elements32;
+	unsigned int i;
 
-				if ((completion->reason ==
-					VCHIQ_SERVICE_CLOSED) &&
-					!instance->use_close_delivered)
-					unlock_service(service);
-
-				if (copy_to_user((void __user *)(
-					(size_t)args.buf +
-					ret * sizeof(VCHIQ_COMPLETION_DATA_T)),
-					completion,
-					sizeof(VCHIQ_COMPLETION_DATA_T)) != 0) {
-						if (ret == 0)
-							ret = -EFAULT;
-					break;
-				}
+	ctxt->service = find_service_for_instance(ctxt->instance, args32->handle);
 
-				instance->completion_remove++;
-			}
+	if (!ctxt->service)
+		return -EINVAL;
 
-			if (msgbufcount != args.msgbufcount) {
-				if (copy_to_user((void __user *)
-					&((VCHIQ_AWAIT_COMPLETION_T *)arg)->
-						msgbufcount,
-					&msgbufcount,
-					sizeof(msgbufcount)) != 0) {
-					ret = -EFAULT;
-				}
-			}
-		}
+	elements = vchiq_ioctl_kmalloc(ctxt,
+				       args32->count * sizeof(VCHIQ_ELEMENT_T));
 
-		if (ret != 0)
-			up(&instance->remove_event);
-		mutex_unlock(&instance->completion_mutex);
-		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-	} break;
+	if (!elements)
+		return -ENOMEM;
 
-	case VCHIQ_IOC_DEQUEUE_MESSAGE: {
-		VCHIQ_DEQUEUE_MESSAGE_T args;
-		USER_SERVICE_T *user_service;
-		VCHIQ_HEADER_T *header;
+	elements32 =
+		vchiq_ioctl_kmalloc(ctxt,
+				    args32->count * sizeof(struct vchiq_element32));
 
-		DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-		if (copy_from_user
-			 (&args, (const void __user *)arg,
-			  sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
-		service = find_service_for_instance(instance, args.handle);
-		if (!service) {
-			ret = -EINVAL;
-			break;
-		}
-		user_service = (USER_SERVICE_T *)service->base.userdata;
-		if (user_service->is_vchi == 0) {
-			ret = -EINVAL;
-			break;
-		}
+	if (!elements32)
+		return -ENOMEM;
 
-		spin_lock(&msg_queue_spinlock);
-		if (user_service->msg_remove == user_service->msg_insert) {
-			if (!args.blocking) {
-				spin_unlock(&msg_queue_spinlock);
-				DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-				ret = -EWOULDBLOCK;
-				break;
-			}
-			user_service->dequeue_pending = 1;
-			do {
-				spin_unlock(&msg_queue_spinlock);
-				DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-				if (down_interruptible(
-					&user_service->insert_event) != 0) {
-					vchiq_log_info(vchiq_arm_log_level,
-						"DEQUEUE_MESSAGE interrupted");
-					ret = -EINTR;
-					break;
-				}
-				spin_lock(&msg_queue_spinlock);
-			} while (user_service->msg_remove ==
-				user_service->msg_insert);
+	if (copy_from_user(elements32, compat_ptr(args32->elements),
+			   args32->count * sizeof(struct vchiq_element32)))
+		return -EINVAL;
 
-			if (ret)
-				break;
-		}
+	for (i = 0; i < args32->count; i++) {
+		elements[i].data = compat_ptr(elements32[i].data);
+		elements[i].size = elements32[i].size;
+	}
 
-		BUG_ON((int)(user_service->msg_insert -
-			user_service->msg_remove) < 0);
+	status = vchiq_ioc_queue_message(args32->handle,
+					 elements, args32->count);
 
-		header = user_service->msg_queue[user_service->msg_remove &
-			(MSG_QUEUE_SIZE - 1)];
-		user_service->msg_remove++;
-		spin_unlock(&msg_queue_spinlock);
+	return vchiq_map_status(status);
+}
 
-		up(&user_service->remove_event);
-		if (header == NULL)
-			ret = -ENOTCONN;
-		else if (header->size <= args.bufsize) {
-			/* Copy to user space if msgbuf is not NULL */
-			if ((args.buf == NULL) ||
-				(copy_to_user((void __user *)args.buf,
-				header->data,
-				header->size) == 0)) {
-				ret = header->size;
-				vchiq_release_message(
-					service->handle,
-					header);
-			} else
-				ret = -EFAULT;
-		} else {
-			vchiq_log_error(vchiq_arm_log_level,
-				"header %pK: bufsize %x < size %x",
-				header, args.bufsize, header->size);
-			WARN(1, "invalid size\n");
-			ret = -EMSGSIZE;
-		}
-		DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-	} break;
+static long
+vchiq_ioctl_compat_bulk_transfer(struct vchiq_ioctl_call_context *ctxt,
+				 struct vchiq_queue_bulk_transfer32 *args32)
+{
+	VCHIQ_QUEUE_BULK_TRANSFER_T args;
+	long ret;
 
-	case VCHIQ_IOC_GET_CLIENT_ID: {
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	args.handle = args32->handle;
+	args.data   = compat_ptr(args32->data);
+	args.size   = args32->size;
+	args.userdata = compat_ptr(args32->userdata);
+	args.mode   = args32->mode;
 
-		ret = vchiq_get_client_id(handle);
-	} break;
+	if (ctxt->cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT32)
+		ret = vchiq_ioctl_bulk_transmit(ctxt, &args);
+	else
+		ret = vchiq_ioctl_bulk_receive(ctxt, &args);
 
-	case VCHIQ_IOC_GET_CONFIG: {
-		VCHIQ_GET_CONFIG_T args;
-		VCHIQ_CONFIG_T config;
+	args32->mode = args.mode;
 
-		if (copy_from_user(&args, (const void __user *)arg,
-			sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
-		if (args.config_size > sizeof(config)) {
-			ret = -EINVAL;
-			break;
-		}
-		status = vchiq_get_config(instance, args.config_size, &config);
-		if (status == VCHIQ_SUCCESS) {
-			if (copy_to_user((void __user *)args.pconfig,
-				    &config, args.config_size) != 0) {
-				ret = -EFAULT;
-				break;
-			}
-		}
-	} break;
+	return ret;
+}
 
-	case VCHIQ_IOC_SET_SERVICE_OPTION: {
-		VCHIQ_SET_SERVICE_OPTION_T args;
+static bool
+vchiq_ioctl_compat_get_msgbuf(void *context,
+			      unsigned int msgbufcount,
+			      void __user **msgbuf)
+{
+	struct vchiq_await_completion32 *args32 =
+		(struct vchiq_await_completion32 *)context;
+	u32 msgbuf32;
+
+	if (copy_from_user(&msgbuf32,
+			   compat_ptr(args32->msgbufs) +
+			   (sizeof(u32) * msgbufcount),
+			   sizeof(msgbuf32)))
+		return true;
+
+	*msgbuf = compat_ptr(msgbuf32);
+	return false;
+}
 
-		if (copy_from_user(
-			&args, (const void __user *)arg,
-			sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
+static bool
+vchiq_ioctl_compat_put_completion(void *context,
+				  unsigned int num,
+				  VCHIQ_COMPLETION_DATA_T *completion)
+{
+	struct vchiq_await_completion32 *args32 =
+		(struct vchiq_await_completion32 *)context;
+	struct vchiq_completion_data32 completion32;
+
+	completion32.reason = completion->reason;
+	completion32.header = ptr_to_compat(completion->header);
+	completion32.service_userdata =
+		ptr_to_compat(completion->service_userdata);
+	completion32.bulk_userdata =
+		ptr_to_compat(completion->bulk_userdata);
+
+	return !!copy_to_user(compat_ptr(args32->buf) +
+			      num * sizeof(struct vchiq_completion_data32),
+			      &completion32,
+			      sizeof(struct vchiq_completion_data32));
+}
 
-		service = find_service_for_instance(instance, args.handle);
-		if (!service) {
-			ret = -EINVAL;
-			break;
-		}
+static long
+vchiq_ioctl_compat_await_completion(struct vchiq_ioctl_call_context *ctxt,
+				    struct vchiq_await_completion32 *args32)
+{
+	return vchiq_ioctl_await_completion_internal(ctxt->instance,
+						     args32->count,
+						     args32->msgbufsize,
+						     &args32->msgbufcount,
+						     args32,
+						     vchiq_ioctl_compat_get_msgbuf,
+						     vchiq_ioctl_compat_put_completion);
+}
 
-		status = vchiq_set_service_option(
-				args.handle, args.option, args.value);
-	} break;
+static long
+vchiq_ioctl_compat_dequeue_message(struct vchiq_ioctl_call_context *ctxt,
+				   struct vchiq_dequeue_message32 *args32)
+{
+	VCHIQ_DEQUEUE_MESSAGE_T args;
 
-	case VCHIQ_IOC_DUMP_PHYS_MEM: {
-		VCHIQ_DUMP_MEM_T  args;
+	args.handle = args32->handle;
+	args.blocking = args32->blocking;
+	args.bufsize = args32->bufsize;
+	args.buf = compat_ptr(args32->buf);
 
-		if (copy_from_user
-			 (&args, (const void __user *)arg,
-			  sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
-		dump_phys_mem(args.virt_addr, args.num_bytes);
-	} break;
+	return vchiq_ioctl_dequeue_message(ctxt, &args);
+}
 
-	case VCHIQ_IOC_LIB_VERSION: {
-		unsigned int lib_version = (unsigned int)arg;
+static long
+vchiq_ioctl_compat_get_config(struct vchiq_ioctl_call_context *ctxt,
+			      struct vchiq_get_config32 *args32)
+{
+	VCHIQ_GET_CONFIG_T args;
 
-		if (lib_version < VCHIQ_VERSION_MIN)
-			ret = -EINVAL;
-		else if (lib_version >= VCHIQ_VERSION_CLOSE_DELIVERED)
-			instance->use_close_delivered = 1;
-	} break;
+	args.pconfig = compat_ptr(args32->pconfig);
+	args.config_size = args32->config_size;
 
-	case VCHIQ_IOC_CLOSE_DELIVERED: {
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	return vchiq_ioctl_get_config(ctxt, &args);
+}
 
-		service = find_closed_service_for_instance(instance, handle);
-		if (service != NULL) {
-			USER_SERVICE_T *user_service =
-				(USER_SERVICE_T *)service->base.userdata;
-			close_delivered(user_service);
-		}
-		else
-			ret = -EINVAL;
-	} break;
+static long
+vchiq_ioctl_compat_dump_phys_mem(struct vchiq_ioctl_call_context *ctxt,
+				 struct vchiq_dump_mem32 *args32)
+{
+	dump_phys_mem(compat_ptr(args32->virt_addr), args32->num_bytes);
+	return 0;
+}
 
-	default:
-		ret = -ENOTTY;
-		break;
-	}
+static const struct vchiq_ioctl_entry vchiq_ioctl_compat_table[] = {
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CREATE_SERVICE32, vchiq_ioctl_compat_create_service, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_MESSAGE32, vchiq_ioctl_compat_queue_message, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_BULK_TRANSMIT32, vchiq_ioctl_compat_bulk_transfer, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_BULK_RECEIVE32, vchiq_ioctl_compat_bulk_transfer, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_AWAIT_COMPLETION32, vchiq_ioctl_compat_await_completion, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_DEQUEUE_MESSAGE32, vchiq_ioctl_compat_dequeue_message, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_GET_CONFIG32, vchiq_ioctl_compat_get_config, NULL),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_DUMP_PHYS_MEM32, vchiq_ioctl_compat_dump_phys_mem, NULL),
+};
 
-	if (service)
-		unlock_service(service);
+static long
+vchiq_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	VCHIQ_INSTANCE_T instance = file->private_data;
+	long ret = 0;
+	unsigned int ioctl_nr;
 
-	if (ret == 0) {
-		if (status == VCHIQ_ERROR)
-			ret = -EIO;
-		else if (status == VCHIQ_RETRY)
-			ret = -EINTR;
+	ioctl_nr = _IOC_NR(cmd);
+
+	vchiq_log_trace(vchiq_arm_log_level,
+			"vchiq_ioctl(compat) - instance %pK, cmd %s, arg %lx",
+			instance,
+			((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) &&
+			(ioctl_nr <= VCHIQ_IOC_MAX)) ?
+			ioctl_names[ioctl_nr] : "<invalid>", arg);
+
+	if (ioctl_nr > VCHIQ_IOC_MAX) {
+		ret = -ENOTTY;
+	} else if (ioctl_nr < ARRAY_SIZE(vchiq_ioctl_compat_table) &&
+		   vchiq_ioctl_compat_table[ioctl_nr].func) {
+		ret = vchiq_ioctl_dispatch(&vchiq_ioctl_compat_table[ioctl_nr],
+					   file, cmd, arg);
+
+	} else {
+		ret = vchiq_ioctl_dispatch(&vchiq_ioctl_table[ioctl_nr],
+					   file, cmd, arg);
 	}
 
-	if ((status == VCHIQ_SUCCESS) && (ret < 0) && (ret != -EINTR) &&
-		(ret != -EWOULDBLOCK))
+	if ((ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
 		vchiq_log_info(vchiq_arm_log_level,
-			"  ioctl instance %lx, cmd %s -> status %d, %ld",
-			(unsigned long)instance,
-			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-				ioctl_names[_IOC_NR(cmd)] :
-				"<invalid>",
-			status, ret);
+			       "  ioctl(compat) instance %lx, cmd %s, %ld",
+			       (unsigned long)instance,
+			       (ioctl_nr <= VCHIQ_IOC_MAX) ?
+			       ioctl_names[ioctl_nr] :
+			       "<invalid>",
+			       ret);
 	else
 		vchiq_log_trace(vchiq_arm_log_level,
-			"  ioctl instance %lx, cmd %s -> status %d, %ld",
-			(unsigned long)instance,
-			(_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
-				ioctl_names[_IOC_NR(cmd)] :
+				"  ioctl(compat) instance %lx, cmd %s, %ld",
+				(unsigned long)instance,
+				(ioctl_nr <= VCHIQ_IOC_MAX) ?
+				ioctl_names[ioctl_nr] :
 				"<invalid>",
-			status, ret);
+				ret);
 
 	return ret;
 }
 
+#endif
+
 /****************************************************************************
 *
 *   vchiq_open
@@ -1660,6 +2132,9 @@ static const struct file_operations
 vchiq_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = vchiq_ioctl,
+#if defined(CONFIG_COMPAT)
+	.compat_ioctl = vchiq_ioctl_compat,
+#endif
 	.open = vchiq_open,
 	.release = vchiq_release,
 	.read = vchiq_read
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 6137ae9..1681b77 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -35,6 +35,9 @@
 #define VCHIQ_IOCTLS_H
 
 #include <linux/ioctl.h>
+#if defined(CONFIG_COMPAT)
+#include <linux/compat.h>
+#endif
 #include "vchiq_if.h"
 
 #define VCHIQ_IOC_MAGIC 0xc4
@@ -128,4 +131,97 @@ typedef struct {
 #define VCHIQ_IOC_CLOSE_DELIVERED      _IO(VCHIQ_IOC_MAGIC,   17)
 #define VCHIQ_IOC_MAX                  17
 
+#if defined(CONFIG_COMPAT)
+
+struct vchiq_element32 {
+	compat_uptr_t data;
+	unsigned int size;
+};
+
+struct vchiq_service_base32 {
+	int fourcc;
+	compat_uptr_t callback;
+	compat_uptr_t userdata;
+};
+
+struct vchiq_service_params32 {
+	int fourcc;
+	compat_uptr_t callback;
+	compat_uptr_t userdata;
+	short version;       /* Increment for non-trivial changes */
+	short version_min;   /* Update for incompatible changes */
+};
+
+struct vchiq_create_service32 {
+	struct vchiq_service_params32 params;
+	int is_open;
+	int is_vchi;
+	unsigned int handle;       /* OUT */
+};
+
+struct vchiq_queue_message32 {
+	unsigned int handle;
+	unsigned int count;
+	compat_uptr_t elements;
+};
+
+struct vchiq_queue_bulk_transfer32 {
+	unsigned int handle;
+	compat_uptr_t data;
+	unsigned int size;
+	compat_uptr_t userdata;
+	VCHIQ_BULK_MODE_T mode;
+};
+
+struct vchiq_completion_data32 {
+	VCHIQ_REASON_T reason;
+	compat_uptr_t header;
+	compat_uptr_t service_userdata;
+	compat_uptr_t bulk_userdata;
+};
+
+struct vchiq_await_completion32 {
+	unsigned int count;
+	compat_uptr_t buf;
+	unsigned int msgbufsize;
+	unsigned int msgbufcount; /* IN/OUT */
+	compat_uptr_t msgbufs;
+};
+
+struct vchiq_dequeue_message32 {
+	unsigned int handle;
+	int blocking;
+	unsigned int bufsize;
+	compat_uptr_t buf;
+};
+
+struct vchiq_get_config32 {
+	unsigned int config_size;
+	compat_uptr_t pconfig;
+};
+
+struct vchiq_dump_mem32 {
+	compat_uptr_t virt_addr;
+	u32 num_bytes;
+};
+
+#define VCHIQ_IOC_CREATE_SERVICE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 2, struct vchiq_create_service32)
+#define VCHIQ_IOC_QUEUE_MESSAGE32 \
+	_IOW(VCHIQ_IOC_MAGIC,  4, struct vchiq_queue_message32)
+#define VCHIQ_IOC_QUEUE_BULK_TRANSMIT32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 5, struct vchiq_queue_bulk_transfer32)
+#define VCHIQ_IOC_QUEUE_BULK_RECEIVE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 6, struct vchiq_queue_bulk_transfer32)
+#define VCHIQ_IOC_AWAIT_COMPLETION32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 7, struct vchiq_await_completion32)
+#define VCHIQ_IOC_DEQUEUE_MESSAGE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 8, struct vchiq_dequeue_message32)
+#define VCHIQ_IOC_GET_CONFIG32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 10, struct vchiq_get_config32)
+#define VCHIQ_IOC_DUMP_PHYS_MEM32 \
+	_IOW(VCHIQ_IOC_MAGIC,  15, struct vchiq_dump_mem32)
+
+#endif
+
 #endif
-- 
2.10.2
