From: mzoran@crowfest.net (Michael Zoran)
Date: Wed,  9 Nov 2016 12:37:27 -0800
Subject: [PATCH] staging: vc04_services: rework ioctl code path
Message-ID: <20161109203727.28333-1-mzoran@crowfest.net>
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

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 1914 +++++++++++++-------
 .../vc04_services/interface/vchiq_arm/vchiq_if.h   |   19 +
 .../interface/vchiq_arm/vchiq_ioctl.h              |   69 +
 3 files changed, 1389 insertions(+), 613 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 8fcd940..e52a06b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -503,709 +503,1394 @@ vchiq_ioc_queue_message(VCHIQ_SERVICE_HANDLE_T handle,
 				   &context, total_size);
 }
 
-/****************************************************************************
-*
-*   vchiq_ioctl
-*
-***************************************************************************/
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
 static long
-vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+vchiq_ioctl_shutdown(VCHIQ_INSTANCE_T instance,
+		     unsigned int cmd,
+		     unsigned long arg) {
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
+vchiq_ioctl_connect(VCHIQ_INSTANCE_T instance,
+		    unsigned int cmd,
+		    unsigned long arg)
 {
-	VCHIQ_INSTANCE_T instance = file->private_data;
 	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
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
+vchiq_ioctl_create_service_internal(VCHIQ_INSTANCE_T instance,
+				    VCHIQ_CREATE_SERVICE_T *args)
+{
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
+vchiq_ioctl_create_service(VCHIQ_INSTANCE_T instance,
+			   unsigned int cmd,
+			  unsigned long arg)
+{
+	VCHIQ_CREATE_SERVICE_T args;
+	long ret;
+
+	if (copy_from_user
+		(&args, (const void __user *)arg,
+		sizeof(args)) != 0)
+		return -EFAULT;
+
+	args.params.callback = NULL;
+
+	ret = vchiq_ioctl_create_service_internal(instance, &args);
+
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user((void __user *)
+		&(((VCHIQ_CREATE_SERVICE_T __user *)
+		arg)->handle),
+		(const void *)&args.handle,
+		sizeof(args.handle)) != 0) {
+		vchiq_remove_service(args.handle);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_close_service(VCHIQ_INSTANCE_T instance,
+			  unsigned int cmd,
+			  unsigned long arg)
+{
+	VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T) arg;
 	VCHIQ_SERVICE_T *service = NULL;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	USER_SERVICE_T *user_service;
+
+	service = find_service_for_instance(instance, handle);
+
+	if (!service)
+		return -EINVAL;
+
+	user_service =	(USER_SERVICE_T *)service->base.userdata;
+
+	/*
+	 * close_pending is false on first entry, and when the
+	 * wait in vchiq_close_service has been interrupted.
+	 */
+	if (!user_service->close_pending) {
+		status = vchiq_close_service(service->handle);
+		if (status != VCHIQ_SUCCESS) {
+			unlock_service(service);
+			return vchiq_map_status(status);
+		}
+	}
+
+	/*
+	 * close_pending is true once the underlying service
+	 * has been closed until the client library calls the
+	 * CLOSE_DELIVERED ioctl, signalling close_event.
+	 */
+	if (user_service->close_pending &&
+	    down_interruptible(&user_service->close_event)) {
+			unlock_service(service);
+			return vchiq_map_status(VCHIQ_RETRY);
+	}
+
+	unlock_service(service);
+	return 0;
+}
+
+static long
+vchiq_ioctl_remove_service(VCHIQ_INSTANCE_T instance,
+			   unsigned int cmd,
+			   unsigned long arg) {
+	VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	VCHIQ_SERVICE_T *service = NULL;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	USER_SERVICE_T *user_service;
+
+	service = find_service_for_instance(instance, handle);
+
+	if (!service)
+		return -EINVAL;
+
+	user_service =	(USER_SERVICE_T *)service->base.userdata;
+
+	/*
+	 * close_pending is false on first entry, and when the
+	 * wait in vchiq_close_service has been interrupted.
+	 */
+	if (!user_service->close_pending) {
+		status = vchiq_remove_service(service->handle);
+		if (status != VCHIQ_SUCCESS) {
+			unlock_service(service);
+			return vchiq_map_status(status);
+		}
+	}
+
+	/*
+	 * close_pending is true once the underlying service
+	 * has been closed until the client library calls the
+	 * CLOSE_DELIVERED ioctl, signaling close_event.
+	 */
+	if (user_service->close_pending &&
+	    down_interruptible(&user_service->close_event)) {
+			unlock_service(service);
+			return vchiq_map_status(VCHIQ_RETRY);
+	}
+
+	unlock_service(service);
+	return 0;
+}
+
+static long
+vchiq_ioctl_use_service(VCHIQ_INSTANCE_T instance,
+			unsigned int cmd,
+			unsigned long arg) {
+	VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	VCHIQ_SERVICE_T *service = NULL;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+
+	service = find_service_for_instance(instance, handle);
+
+	if (!service)
+		return -EINVAL;
+
+	status = vchiq_use_service_internal(service);
+
+	if (status != VCHIQ_SUCCESS) {
+		vchiq_log_error(vchiq_susp_log_level,
+			"%s: cmd VCHIQ_IOC_USE_SERVICE returned error %d for service %c%c%c%c:%03d",
+			__func__,
+			status,
+			VCHIQ_FOURCC_AS_4CHARS(
+			service->base.fourcc),
+			service->client_id);
+		unlock_service(service);
+		return -EINVAL;
+	}
+
+	unlock_service(service);
+	return 0;
+}
+
+static long
+vchiq_ioctl_release_service(VCHIQ_INSTANCE_T instance,
+			    unsigned int cmd,
+			    unsigned long arg) {
+	VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	VCHIQ_SERVICE_T *service = NULL;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+
+	service = find_service_for_instance(instance, handle);
+
+	if (!service)
+		return -EINVAL;
+
+	status = vchiq_release_service_internal(service);
+
+	if (status != VCHIQ_SUCCESS) {
+		vchiq_log_error(vchiq_susp_log_level,
+			"%s: cmd VCHIQ_IOC_RELEASE_SERVICE returned error %d for service %c%c%c%c:%03d",
+			__func__,
+			status,
+			VCHIQ_FOURCC_AS_4CHARS(
+			service->base.fourcc),
+			service->client_id);
+		unlock_service(service);
+		return -EINVAL;
+	}
+
+	unlock_service(service);
+	return 0;
+}
+
+static long
+vchiq_ioctl_queue_message(VCHIQ_INSTANCE_T instance,
+			  unsigned int cmd,
+			  unsigned long arg) {
+	VCHIQ_QUEUE_MESSAGE_T args;
+	VCHIQ_SERVICE_T *service = NULL;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	VCHIQ_ELEMENT_T elements[MAX_ELEMENTS];
+
+	if (copy_from_user(&args,
+			   (const void __user *)arg,
+			   sizeof(args)) != 0)
+		return -EFAULT;
+
+	service = find_service_for_instance(instance, args.handle);
+
+	if (!service) {
+		unlock_service(service);
+		return -EINVAL;
+	}
+
+	if (copy_from_user(elements, args.elements,
+			   args.count * sizeof(VCHIQ_ELEMENT_T)) != 0) {
+		unlock_service(service);
+		return -EINVAL;
+	}
+
+	status = vchiq_ioc_queue_message(args.handle,
+					 elements, args.count);
+
+	unlock_service(service);
+	return vchiq_map_status(status);
+}
+
+static long
+vchiq_ioctl_bulk_transfer_internal(VCHIQ_INSTANCE_T instance,
+				   unsigned int handle,
+				   void __user *data,
+				   unsigned int size,
+				   void *userdata,
+				   VCHIQ_BULK_MODE_T mode,
+				   VCHIQ_BULK_DIR_T dir,
+				   VCHIQ_BULK_MODE_T *ret_mode_waiting)
+{
+	VCHIQ_SERVICE_T *service = NULL;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	struct bulk_waiter_node *waiter = NULL;
+
+	*ret_mode_waiting = mode;
+
+	service = find_service_for_instance(instance, handle);
+	if (!service)
+		return -EINVAL;
+
+	if (mode == VCHIQ_BULK_MODE_BLOCKING) {
+		waiter = kzalloc(sizeof(struct bulk_waiter_node), GFP_KERNEL);
+		if (!waiter) {
+			unlock_service(service);
+			return -ENOMEM;
+		}
+		userdata = &waiter->bulk_waiter;
+	} else if (mode == VCHIQ_BULK_MODE_WAITING) {
+		struct list_head *pos;
+
+		mutex_lock(&instance->bulk_waiter_list_mutex);
+
+		list_for_each(pos, &instance->bulk_waiter_list)
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
+		mutex_unlock(&instance->bulk_waiter_list_mutex);
+		if (!waiter) {
+			vchiq_log_error(vchiq_arm_log_level,
+					"no bulk_waiter found for pid %d",
+				current->pid);
+			unlock_service(service);
+			return -ESRCH;
+		}
+		vchiq_log_info(vchiq_arm_log_level,
+			       "found bulk_waiter %pK for pid %d", waiter,
+			current->pid);
+		userdata = &waiter->bulk_waiter;
+	}
+
+	status = vchiq_bulk_transfer(handle,
+				     VCHI_MEM_HANDLE_INVALID,
+				     data,
+				     size,
+				     userdata,
+				     mode,
+				     dir);
+
+	if (!waiter) {
+		unlock_service(service);
+		return vchiq_map_status(status);
+	}
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
+		mutex_lock(&instance->bulk_waiter_list_mutex);
+		list_add(&waiter->list, &instance->bulk_waiter_list);
+		mutex_unlock(&instance->bulk_waiter_list_mutex);
+		vchiq_log_info(vchiq_arm_log_level,
+			       "saved bulk_waiter %pK for pid %d",
+			waiter, current->pid);
+
+		*ret_mode_waiting = VCHIQ_BULK_MODE_WAITING;
+	}
+
+	unlock_service(service);
+	return vchiq_map_status(status);
+}
+
+static long
+vchiq_ioctl_bulk_transfer(VCHIQ_INSTANCE_T instance,
+			  unsigned int cmd,
+			  unsigned long arg)
+{
+	VCHIQ_QUEUE_BULK_TRANSFER_T args;
+	VCHIQ_BULK_MODE_T mode_waiting;
+	long ret;
+	VCHIQ_BULK_DIR_T dir =
+		(cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT) ?
+		VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;
+
+	if (copy_from_user(&args,
+			   (const void __user *)arg,
+			   sizeof(args)) != 0)
+		return -EFAULT;
+
+	ret = vchiq_ioctl_bulk_transfer_internal(instance,
+						 args.handle,
+						 args.data,
+						 args.size,
+						 args.userdata,
+						 args.mode,
+						 dir,
+						 &mode_waiting);
+
+	if (mode_waiting != args.mode) {
+		if (copy_to_user((void __user *)
+				 &(((VCHIQ_QUEUE_BULK_TRANSFER_T __user *)
+				 arg)->mode),
+				(const void *)&mode_waiting,
+				sizeof(mode_waiting)) != 0)
+					return -EFAULT;
+	}
+
+	return ret;
+}
+
+static long
+vchiq_ioctl_await_completion(VCHIQ_INSTANCE_T instance,
+			     unsigned int cmd,
+			     unsigned long arg)
+{
+	VCHIQ_AWAIT_COMPLETION_T args;
 	long ret = 0;
-	int i, rc;
-	DEBUG_INITIALISE(g_state.local)
+	int msgbufcount;
 
-	vchiq_log_trace(vchiq_arm_log_level,
-		"vchiq_ioctl - instance %pK, cmd %s, arg %lx",
-		instance,
-		((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) &&
-		(_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
-		ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
+	DEBUG_INITIALISE(g_state.local);
 
-	switch (cmd) {
-	case VCHIQ_IOC_SHUTDOWN:
-		if (!instance->connected)
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+
+	if (!instance->connected)
+		return -ENOTCONN;
+
+	if (copy_from_user(&args, (const void __user *)arg,
+			   sizeof(args)) != 0)
+		return -EFAULT;
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
+	msgbufcount = args.msgbufcount;
+	for (ret = 0; ret < args.count; ret++) {
+		VCHIQ_COMPLETION_DATA_T *completion;
+		VCHIQ_SERVICE_T *service;
+		USER_SERVICE_T *user_service;
+		VCHIQ_HEADER_T *header;
+
+		if (instance->completion_remove == instance->completion_insert)
 			break;
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
+			if (args.msgbufsize < msglen) {
+				vchiq_log_error(
+					vchiq_arm_log_level,
+					"header %pK: msgbufsize %x < msglen %x",
+					header, args.msgbufsize,
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
+			if (copy_from_user(&msgbuf,
+					   (const void __user *)
+					   &args.msgbufs[msgbufcount],
+					   sizeof(msgbuf)) != 0) {
+				if (ret == 0)
+					ret = -EFAULT;
+				break;
+			}
 
-		/* Remove all services */
-		i = 0;
-		while ((service = next_service_by_instance(instance->state,
-			instance, &i)) != NULL) {
-			status = vchiq_remove_service(service->handle);
-			unlock_service(service);
-			if (status != VCHIQ_SUCCESS)
+			/* Copy the message to user space */
+			if (copy_to_user(msgbuf, header,
+					 msglen) != 0) {
+				if (ret == 0)
+					ret = -EFAULT;
 				break;
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
 		}
-		service = NULL;
 
-		if (status == VCHIQ_SUCCESS) {
-			/* Wake the completion thread and ask it to exit */
-			instance->closing = 1;
-			up(&instance->insert_event);
+		if ((completion->reason ==
+			VCHIQ_SERVICE_CLOSED) &&
+			!instance->use_close_delivered)
+			unlock_service(service);
+
+		if (copy_to_user((void __user *)(
+				 (size_t)args.buf +
+				 ret * sizeof(VCHIQ_COMPLETION_DATA_T)),
+				 completion,
+				 sizeof(VCHIQ_COMPLETION_DATA_T)) != 0) {
+			if (ret == 0)
+				ret = -EFAULT;
+			break;
 		}
 
-		break;
+		instance->completion_remove++;
+	}
+
+	if (msgbufcount != args.msgbufcount) {
+		if (copy_to_user((void __user *)
+				 &((VCHIQ_AWAIT_COMPLETION_T *)arg)->
+				 msgbufcount,
+				 &msgbufcount,
+				 sizeof(msgbufcount)) != 0)
+			ret = -EFAULT;
+	}
+
+	if (ret != 0)
+		up(&instance->remove_event);
+	mutex_unlock(&instance->completion_mutex);
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+
+	return ret;
+}
+
+static long
+vchiq_ioctl_dequeue_message_internal(VCHIQ_INSTANCE_T instance,
+				     unsigned int handle,
+				    bool blocking,
+				    unsigned int bufsize,
+				    void __user *buf)
+{
+	VCHIQ_SERVICE_T *service = NULL;
+	USER_SERVICE_T *user_service;
+	VCHIQ_HEADER_T *header;
+	long ret;
+
+	DEBUG_INITIALISE(g_state.local);
+
+	service = find_service_for_instance(instance, handle);
+	if (!service)
+		return -EINVAL;
+
+	user_service = (USER_SERVICE_T *)service->base.userdata;
+	if (user_service->is_vchi == 0) {
+		unlock_service(service);
+		return -EINVAL;
+	}
+
+	spin_lock(&msg_queue_spinlock);
+	if (user_service->msg_remove == user_service->msg_insert) {
+		if (!blocking) {
+			spin_unlock(&msg_queue_spinlock);
+			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+			unlock_service(service);
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
+				unlock_service(service);
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
+	if (!header) {
+		unlock_service(service);
+		return -ENOTCONN;
+	}
+
+	if (header->size > bufsize) {
+		vchiq_log_error(vchiq_arm_log_level,
+				"header %pK: bufsize %x < size %x",
+			header, bufsize, header->size);
+		WARN(1, "invalid size\n");
+		unlock_service(service);
+		return -EMSGSIZE;
+	}
+
+	if (!buf) {
+		unlock_service(service);
+		return -EMSGSIZE;
+	}
+
+	if (copy_to_user(buf,
+			 header->data,
+			 header->size) != 0) {
+		unlock_service(service);
+		return -EFAULT;
+	}
+
+	ret = header->size;
+	vchiq_release_message(service->handle, header);
+
+	unlock_service(service);
+	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+
+	return ret;
+}
+
+static long
+vchiq_ioctl_dequeue_message(VCHIQ_INSTANCE_T instance,
+			    unsigned int cmd,
+			    unsigned long arg)
+{
+	VCHIQ_DEQUEUE_MESSAGE_T args;
+
+	if (copy_from_user(&args, (const void __user *)arg,
+			   sizeof(args)) != 0)
+		return -EFAULT;
+
+	return vchiq_ioctl_dequeue_message_internal(instance,
+						    args.handle,
+						    args.blocking,
+						    args.bufsize,
+						    args.buf);
+}
+
+static long
+vchiq_ioctl_get_client_handle(VCHIQ_INSTANCE_T instance,
+			      unsigned int cmd,
+			      unsigned long arg)
+{
+	VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+
+	return vchiq_get_client_id(handle);
+}
+
+static long
+vchiq_ioctl_get_config(VCHIQ_INSTANCE_T instance,
+		       unsigned int cmd,
+		       unsigned long arg)
+{
+	VCHIQ_GET_CONFIG_T args;
+	VCHIQ_CONFIG_T config;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+
+	if (copy_from_user(&args, (const void __user *)arg,
+			   sizeof(args)) != 0)
+		return -EFAULT;
+
+	if (args.config_size > sizeof(config))
+		return -EFAULT;
+
+	status = vchiq_get_config(instance, args.config_size, &config);
+
+	if (status != VCHIQ_SUCCESS)
+		return vchiq_map_status(status);
+
+	if (copy_to_user((void __user *)args.pconfig,
+			 &config, args.config_size) != 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_set_service_option(VCHIQ_INSTANCE_T instance,
+			       unsigned int cmd,
+			       unsigned long arg)
+{
+	VCHIQ_SERVICE_T *service = NULL;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	VCHIQ_SET_SERVICE_OPTION_T args;
+
+	if (copy_from_user(
+		&args, (const void __user *)arg,
+		sizeof(args)) != 0)
+		return -EFAULT;
+
+	service = find_service_for_instance(instance, args.handle);
+	if (!service)
+		return -EINVAL;
+
+	status = vchiq_set_service_option(
+		args.handle, args.option, args.value);
+
+	unlock_service(service);
+	return vchiq_map_status(status);
+}
+
+static long
+vchiq_ioctl_dump_phys_mem(VCHIQ_INSTANCE_T instance,
+			  unsigned int cmd,
+	unsigned long arg)
+{
+	VCHIQ_DUMP_MEM_T args;
+
+	if (copy_from_user
+		(&args, (const void __user *)arg,
+		sizeof(args)) != 0)
+		return -EFAULT;
+
+	dump_phys_mem(args.virt_addr, args.num_bytes);
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_lib_version(VCHIQ_INSTANCE_T instance,
+			unsigned int cmd,
+			unsigned long arg)
+{
+	unsigned int lib_version = (unsigned int)arg;
+
+	if (lib_version < VCHIQ_VERSION_MIN)
+		return -EINVAL;
+
+	if (lib_version >= VCHIQ_VERSION_CLOSE_DELIVERED)
+		instance->use_close_delivered = 1;
+
+	return 0;
+}
+
+static long
+vchiq_ioctl_close_delivered(VCHIQ_INSTANCE_T instance,
+			    unsigned int cmd,
+			    unsigned long arg)
+{
+	VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	VCHIQ_SERVICE_T *service = NULL;
+
+	service = find_closed_service_for_instance(instance, handle);
+
+	if (!service)
+		return -EINVAL;
+
+	close_delivered((USER_SERVICE_T *)service->base.userdata);
+
+	unlock_service(service);
+	return 0;
+}
+
+typedef long (*vchiq_ioctl_func_t)(VCHIQ_INSTANCE_T, unsigned int, unsigned long);
+
+struct vchiq_ioctl_entry {
+	vchiq_ioctl_func_t func;
+	unsigned int ioctl;
+};
+
+#define VCHIQ_MK_IOCTL(__ioctl, __func)	\
+	[_IOC_NR(__ioctl)] = {.func = __func, .ioctl = __ioctl}
+
+static const struct vchiq_ioctl_entry vchiq_ioctl_table[] = {
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CONNECT, vchiq_ioctl_connect),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_SHUTDOWN, vchiq_ioctl_shutdown),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CREATE_SERVICE, vchiq_ioctl_create_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CLOSE_SERVICE, vchiq_ioctl_close_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_REMOVE_SERVICE, vchiq_ioctl_remove_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_USE_SERVICE, vchiq_ioctl_use_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_RELEASE_SERVICE, vchiq_ioctl_release_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_MESSAGE, vchiq_ioctl_queue_message),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_BULK_TRANSMIT, vchiq_ioctl_bulk_transfer),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_BULK_RECEIVE, vchiq_ioctl_bulk_transfer),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_AWAIT_COMPLETION, vchiq_ioctl_await_completion),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_DEQUEUE_MESSAGE, vchiq_ioctl_dequeue_message),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_GET_CLIENT_ID, vchiq_ioctl_get_client_handle),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_GET_CONFIG, vchiq_ioctl_get_config),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_SET_SERVICE_OPTION, vchiq_ioctl_set_service_option),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_DUMP_PHYS_MEM, vchiq_ioctl_dump_phys_mem),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_LIB_VERSION, vchiq_ioctl_lib_version),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CLOSE_DELIVERED, vchiq_ioctl_close_delivered)
+};
+
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
+
+	ioctl_nr = _IOC_NR(cmd);
+
+	vchiq_log_trace(vchiq_arm_log_level,
+			"vchiq_ioctl - instance %pK, cmd %s, arg %lx",
+		instance,
+		((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) &&
+		(ioctl_nr <= VCHIQ_IOC_MAX)) ?
+		ioctl_names[ioctl_nr] : "<invalid>", arg);
 
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
+	if ((ioctl_nr > VCHIQ_IOC_MAX) ||
+	    (vchiq_ioctl_table[ioctl_nr].ioctl != cmd)) {
+		ret = -ENOTTY;
+	} else {
+		ret = vchiq_ioctl_table[ioctl_nr].func(instance, cmd, arg);
+	}
 
-		if (status == VCHIQ_SUCCESS)
-			instance->connected = 1;
-		else
-			vchiq_log_error(vchiq_arm_log_level,
-				"vchiq: could not connect: %d", status);
-		break;
+	if ((ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
+		vchiq_log_info(vchiq_arm_log_level,
+			       "  ioctl instance %lx, cmd %s, %ld",
+			(unsigned long)instance,
+			(ioctl_nr <= VCHIQ_IOC_MAX) ?
+				ioctl_names[ioctl_nr] :
+				"<invalid>",
+			ret);
+	else
+		vchiq_log_trace(vchiq_arm_log_level,
+				"  ioctl instance %lx, cmd %s -> %ld",
+			(unsigned long)instance,
+			(ioctl_nr <= VCHIQ_IOC_MAX) ?
+				ioctl_names[ioctl_nr] :
+				"<invalid>",
+			ret);
 
-	case VCHIQ_IOC_CREATE_SERVICE: {
-		VCHIQ_CREATE_SERVICE_T args;
-		USER_SERVICE_T *user_service = NULL;
-		void *userdata;
-		int srvstate;
+	return ret;
+}
 
-		if (copy_from_user
-			 (&args, (const void __user *)arg,
-			  sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
+#if defined(CONFIG_COMPAT)
 
-		user_service = kmalloc(sizeof(USER_SERVICE_T), GFP_KERNEL);
-		if (!user_service) {
-			ret = -ENOMEM;
-			break;
-		}
+static long
+vchiq_ioctl_compat_create_service(VCHIQ_INSTANCE_T instance,
+				  unsigned int cmd,
+				  unsigned long arg)
+{
+	struct vchiq_create_service32 args32;
+	VCHIQ_CREATE_SERVICE_T args;
+	long ret;
 
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
+	if (copy_from_user
+		(&args32, (const void __user *)arg,
+		sizeof(args32)) != 0)
+		return -EFAULT;
 
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
+	args.params.fourcc   = args32.params.fourcc;
+	args.params.callback = NULL;
+	args.params.userdata = (void *)(unsigned long)args32.params.userdata;
+	args.params.version = args32.params.version;
+	args.params.version_min = args32.params.version_min;
+	args.is_open = args32.is_open;
+	args.is_vchi = args32.is_vchi;
+	args.handle  = args32.handle;
+
+	ret = vchiq_ioctl_create_service_internal(instance, &args);
+
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user((void __user *)
+		&(((struct vchiq_create_service32 __user *)
+		arg)->handle),
+		(const void *)&args.handle,
+		sizeof(args.handle)) != 0) {
+		vchiq_remove_service(args.handle);
+		return -EFAULT;
+	}
 
-			if (copy_to_user((void __user *)
-				&(((VCHIQ_CREATE_SERVICE_T __user *)
-					arg)->handle),
-				(const void *)&service->handle,
-				sizeof(service->handle)) != 0) {
-				ret = -EFAULT;
-				vchiq_remove_service(service->handle);
-			}
+	return 0;
+}
 
-			service = NULL;
-		} else {
-			ret = -EEXIST;
-			kfree(user_service);
-		}
-	} break;
+static long
+vchiq_ioctl_compat_queue_message(VCHIQ_INSTANCE_T instance,
+				 unsigned int cmd,
+				 unsigned long arg) {
+	unsigned int i;
+	struct vchiq_queue_message32 args32;
+	VCHIQ_SERVICE_T *service = NULL;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
+	VCHIQ_ELEMENT_T elements[MAX_ELEMENTS];
+	struct vchiq_element32 elements32[MAX_ELEMENTS];
 
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
+	if (copy_from_user(&args32,
+			   (const void __user *)arg,
+			   sizeof(args32)) != 0)
+		return -EFAULT;
 
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
+	service = find_service_for_instance(instance, args32.handle);
 
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
+	if (!service) {
+		unlock_service(service);
+		return -EINVAL;
+	}
 
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
+	if (copy_from_user(elements32,
+			   (void __user *)(unsigned long)args32.elements,
+			   args32.count * sizeof(struct vchiq_element32)) != 0) {
+		unlock_service(service);
+		return -EINVAL;
+	}
 
-	case VCHIQ_IOC_USE_SERVICE:
-	case VCHIQ_IOC_RELEASE_SERVICE:	{
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	for (i = 0; i < args32.count; i++) {
+		elements[i].data =
+			(const void *)(unsigned long)elements32[i].data;
+		elements[i].size = elements32[i].size;
+	}
 
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
+	status = vchiq_ioc_queue_message(args32.handle,
+					 elements, args32.count);
 
-	case VCHIQ_IOC_QUEUE_MESSAGE: {
-		VCHIQ_QUEUE_MESSAGE_T args;
-		if (copy_from_user
-			 (&args, (const void __user *)arg,
-			  sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
+	unlock_service(service);
+	return vchiq_map_status(status);
+}
 
-		service = find_service_for_instance(instance, args.handle);
+static long
+vchiq_ioctl_compat_bulk_transfer(VCHIQ_INSTANCE_T instance,
+				 unsigned int cmd,
+				 unsigned long arg)
+{
+	struct vchiq_queue_bulk_transfer32 args32;
+	VCHIQ_BULK_MODE_T mode_waiting;
+	long ret;
+	VCHIQ_BULK_DIR_T dir =
+		(cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT32) ?
+		VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;
+
+	if (copy_from_user(&args32,
+			   (const void __user *)arg,
+			   sizeof(args32)) != 0)
+		return -EFAULT;
 
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
+	ret = vchiq_ioctl_bulk_transfer_internal(instance,
+						 args32.handle,
+						 (void __user *)(unsigned long)
+							args32.data,
+						 args32.size,
+						 (void *)(unsigned long)
+							args32.userdata,
+						 args32.mode,
+						 dir,
+						 &mode_waiting);
+
+	if (mode_waiting != args32.mode) {
+		if (copy_to_user((void __user *)
+				 &(((struct vchiq_queue_bulk_transfer32 __user *)
+				 arg)->mode),
+				(const void *)&mode_waiting,
+				sizeof(mode_waiting)) != 0)
+					return -EFAULT;
+	}
 
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
+	return ret;
+}
 
-		service = find_service_for_instance(instance, args.handle);
-		if (!service) {
-			ret = -EINVAL;
-			break;
-		}
+static long
+vchiq_ioctl_compat_await_completion(VCHIQ_INSTANCE_T instance,
+				    unsigned int cmd,
+				    unsigned long arg)
+{
+	struct vchiq_await_completion32 args32;
+	VCHIQ_AWAIT_COMPLETION_T args;
+	long ret = 0;
+	int msgbufcount;
 
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
+	DEBUG_INITIALISE(g_state.local);
 
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
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
 
-			if (copy_to_user((void __user *)
-				&(((VCHIQ_QUEUE_BULK_TRANSFER_T __user *)
-					arg)->mode),
-				(const void *)&mode_waiting,
-				sizeof(mode_waiting)) != 0)
-				ret = -EFAULT;
-		}
-	} break;
+	if (!instance->connected)
+		return -ENOTCONN;
 
-	case VCHIQ_IOC_AWAIT_COMPLETION: {
-		VCHIQ_AWAIT_COMPLETION_T args;
+	if (copy_from_user(&args32, (const void __user *)arg,
+			   sizeof(args32)) != 0)
+		return -EFAULT;
 
-		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-		if (!instance->connected) {
-			ret = -ENOTCONN;
-			break;
-		}
+	args.count = args32.count;
+	args.buf = (VCHIQ_COMPLETION_DATA_T __user *)(unsigned long)args32.buf;
+	args.msgbufsize = args32.msgbufsize;
+	args.msgbufcount = args32.msgbufcount;
+	args.msgbufs = (void **)(unsigned long)args32.msgbufs;
 
-		if (copy_from_user(&args, (const void __user *)arg,
-			sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
+	mutex_lock(&instance->completion_mutex);
 
-		mutex_lock(&instance->completion_mutex);
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+	while ((instance->completion_remove ==
+		instance->completion_insert)
+		&& !instance->closing) {
+		int rc;
 
 		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-		while ((instance->completion_remove ==
-			instance->completion_insert)
-			&& !instance->closing) {
-			int rc;
+		mutex_unlock(&instance->completion_mutex);
+		rc = down_interruptible(&instance->insert_event);
+		mutex_lock(&instance->completion_mutex);
+		if (rc != 0) {
 			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+			vchiq_log_info(vchiq_arm_log_level,
+				       "AWAIT_COMPLETION interrupted");
 			mutex_unlock(&instance->completion_mutex);
-			rc = down_interruptible(&instance->insert_event);
-			mutex_lock(&instance->completion_mutex);
-			if (rc != 0) {
-				DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-				vchiq_log_info(vchiq_arm_log_level,
-					"AWAIT_COMPLETION interrupted");
-				ret = -EINTR;
-				break;
-			}
+			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
+			return -EINTR;
 		}
-		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-
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
+	}
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
 
-					/* The completion must point to the
-					** msgbuf. */
-					completion->header = msgbuf;
-				}
+	/*
+	 * A read memory barrier is needed to stop prefetch of a stale
+	 * completion record.
+	 */
+	rmb();
 
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
+	msgbufcount = args.msgbufcount;
+	for (ret = 0; ret < args.count; ret++) {
+		VCHIQ_COMPLETION_DATA_T *completion;
+		struct vchiq_completion_data32 completion32;
+		VCHIQ_SERVICE_T *service;
+		USER_SERVICE_T *user_service;
+		VCHIQ_HEADER_T *header;
 
-				instance->completion_remove++;
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
+			u32 msgbuf32;
+			int msglen;
+
+			msglen = header->size + sizeof(VCHIQ_HEADER_T);
+			/* This must be a VCHIQ-style service */
+			if (args.msgbufsize < msglen) {
+				vchiq_log_error(
+					vchiq_arm_log_level,
+					"header %pK: msgbufsize %x < msglen %x",
+					header, args.msgbufsize,
+					msglen);
+				WARN(1, "invalid message size\n");
+				if (ret == 0)
+					ret = -EMSGSIZE;
+				break;
 			}
-
-			if (msgbufcount != args.msgbufcount) {
-				if (copy_to_user((void __user *)
-					&((VCHIQ_AWAIT_COMPLETION_T *)arg)->
-						msgbufcount,
-					&msgbufcount,
-					sizeof(msgbufcount)) != 0) {
+			if (msgbufcount <= 0)
+				/* Stall here for lack of a
+				 ** buffer for the message. */
+				break;
+			/* Get the pointer from user space */
+			msgbufcount--;
+
+			if (copy_from_user(&msgbuf32,
+					   (const void __user *)
+						(void *)(args.msgbufs) +
+						(sizeof(u32) * msgbufcount),
+					    sizeof(msgbuf32)) != 0) {
+				if (ret == 0)
 					ret = -EFAULT;
-				}
+				break;
 			}
-		}
 
-		if (ret != 0)
-			up(&instance->remove_event);
-		mutex_unlock(&instance->completion_mutex);
-		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-	} break;
+			msgbuf = (void *)(unsigned long)msgbuf32;
 
-	case VCHIQ_IOC_DEQUEUE_MESSAGE: {
-		VCHIQ_DEQUEUE_MESSAGE_T args;
-		USER_SERVICE_T *user_service;
-		VCHIQ_HEADER_T *header;
+			/* Copy the message to user space */
+			if (copy_to_user(msgbuf, header,
+					 msglen) != 0) {
+				if (ret == 0)
+					ret = -EFAULT;
+				break;
+			}
 
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
 		}
-		user_service = (USER_SERVICE_T *)service->base.userdata;
-		if (user_service->is_vchi == 0) {
-			ret = -EINVAL;
+
+		if ((completion->reason ==
+			VCHIQ_SERVICE_CLOSED) &&
+			!instance->use_close_delivered)
+			unlock_service(service);
+
+		completion32.reason = completion->reason;
+		completion32.header = (u32)(unsigned long)completion->header;
+		completion32.service_userdata =
+			(u32)(unsigned long)completion->service_userdata;
+		completion32.bulk_userdata =
+			(u32)(unsigned long)completion->bulk_userdata;
+
+		if (copy_to_user((void __user *)(
+			(void *)args.buf +
+			ret * sizeof(struct vchiq_completion_data32)),
+			&completion32,
+			sizeof(struct vchiq_completion_data32)) != 0) {
+			if (ret == 0)
+				ret = -EFAULT;
 			break;
 		}
 
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
+		instance->completion_remove++;
+	}
 
-			if (ret)
-				break;
-		}
+	if (msgbufcount != args.msgbufcount) {
+		if (copy_to_user((void __user *)
+				 &((struct vchiq_await_completion32 *)arg)->
+				 msgbufcount,
+				 &msgbufcount,
+				 sizeof(msgbufcount)) != 0)
+			ret = -EFAULT;
+	}
 
-		BUG_ON((int)(user_service->msg_insert -
-			user_service->msg_remove) < 0);
+	if (ret != 0)
+		up(&instance->remove_event);
+	mutex_unlock(&instance->completion_mutex);
+	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
 
-		header = user_service->msg_queue[user_service->msg_remove &
-			(MSG_QUEUE_SIZE - 1)];
-		user_service->msg_remove++;
-		spin_unlock(&msg_queue_spinlock);
+	return ret;
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
+vchiq_ioctl_compat_dequeue_message(VCHIQ_INSTANCE_T instance,
+				   unsigned int cmd,
+				   unsigned long arg)
+{
+	struct vchiq_dequeue_message32 args32;
 
-	case VCHIQ_IOC_GET_CLIENT_ID: {
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	if (copy_from_user(&args32, (const void __user *)arg,
+			   sizeof(args32)) != 0)
+		return -EFAULT;
 
-		ret = vchiq_get_client_id(handle);
-	} break;
+	return vchiq_ioctl_dequeue_message_internal(instance,
+						    args32.handle,
+						    args32.blocking,
+						    args32.bufsize,
+						    (void __user *)
+						    (unsigned long)args32.buf);
+}
 
-	case VCHIQ_IOC_GET_CONFIG: {
-		VCHIQ_GET_CONFIG_T args;
-		VCHIQ_CONFIG_T config;
+static long
+vchiq_ioctl_compat_get_config(VCHIQ_INSTANCE_T instance,
+			      unsigned int cmd,
+			      unsigned long arg)
+{
+	struct vchiq_get_config32 args32;
+	VCHIQ_CONFIG_T config;
+	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
 
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
+	if (copy_from_user(&args32, (const void __user *)arg,
+			   sizeof(args32)) != 0)
+		return -EFAULT;
 
-	case VCHIQ_IOC_SET_SERVICE_OPTION: {
-		VCHIQ_SET_SERVICE_OPTION_T args;
+	if (args32.config_size > sizeof(config))
+		return -EFAULT;
 
-		if (copy_from_user(
-			&args, (const void __user *)arg,
-			sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
+	status = vchiq_get_config(instance, args32.config_size, &config);
 
-		service = find_service_for_instance(instance, args.handle);
-		if (!service) {
-			ret = -EINVAL;
-			break;
-		}
+	if (status != VCHIQ_SUCCESS)
+		return vchiq_map_status(status);
 
-		status = vchiq_set_service_option(
-				args.handle, args.option, args.value);
-	} break;
+	if (copy_to_user((void __user *)(unsigned long)args32.pconfig,
+			 &config, args32.config_size) != 0)
+		return -EFAULT;
 
-	case VCHIQ_IOC_DUMP_PHYS_MEM: {
-		VCHIQ_DUMP_MEM_T  args;
+	return 0;
+}
 
-		if (copy_from_user
-			 (&args, (const void __user *)arg,
-			  sizeof(args)) != 0) {
-			ret = -EFAULT;
-			break;
-		}
-		dump_phys_mem(args.virt_addr, args.num_bytes);
-	} break;
+static long
+vchiq_ioctl_compat_dump_phys_mem(VCHIQ_INSTANCE_T instance,
+				 unsigned int cmd,
+				 unsigned long arg)
+{
+	struct vchiq_dump_mem32 args32;
 
-	case VCHIQ_IOC_LIB_VERSION: {
-		unsigned int lib_version = (unsigned int)arg;
+	if (copy_from_user
+		(&args32, (const void __user *)arg,
+		sizeof(args32)) != 0)
+		return -EFAULT;
 
-		if (lib_version < VCHIQ_VERSION_MIN)
-			ret = -EINVAL;
-		else if (lib_version >= VCHIQ_VERSION_CLOSE_DELIVERED)
-			instance->use_close_delivered = 1;
-	} break;
+	dump_phys_mem((void *)(unsigned long)args32.virt_addr,
+		      args32.num_bytes);
 
-	case VCHIQ_IOC_CLOSE_DELIVERED: {
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+	return 0;
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
+static const struct vchiq_ioctl_entry vchiq_ioctl_compat_table[] = {
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CONNECT, vchiq_ioctl_connect),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_SHUTDOWN, vchiq_ioctl_shutdown),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CREATE_SERVICE32, vchiq_ioctl_compat_create_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CLOSE_SERVICE, vchiq_ioctl_close_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_REMOVE_SERVICE, vchiq_ioctl_remove_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_USE_SERVICE, vchiq_ioctl_use_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_RELEASE_SERVICE, vchiq_ioctl_release_service),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_MESSAGE32, vchiq_ioctl_compat_queue_message),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_BULK_TRANSMIT32, vchiq_ioctl_compat_bulk_transfer),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_QUEUE_BULK_RECEIVE32, vchiq_ioctl_compat_bulk_transfer),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_AWAIT_COMPLETION32, vchiq_ioctl_compat_await_completion),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_DEQUEUE_MESSAGE32, vchiq_ioctl_compat_dequeue_message),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_GET_CLIENT_ID, vchiq_ioctl_get_client_handle),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_GET_CONFIG32, vchiq_ioctl_compat_get_config),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_SET_SERVICE_OPTION, vchiq_ioctl_set_service_option),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_DUMP_PHYS_MEM32, vchiq_ioctl_compat_dump_phys_mem),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_LIB_VERSION, vchiq_ioctl_lib_version),
+	VCHIQ_MK_IOCTL(VCHIQ_IOC_CLOSE_DELIVERED, vchiq_ioctl_close_delivered)
+};
 
-	default:
-		ret = -ENOTTY;
-		break;
-	}
 
-	if (service)
-		unlock_service(service);
+/****************************************************************************
+*
+*   vchiq_ioctl
+*
+***************************************************************************/
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
+	if ((ioctl_nr > VCHIQ_IOC_MAX) ||
+	    (vchiq_ioctl_compat_table[ioctl_nr].ioctl != cmd)) {
+		ret = -ENOTTY;
+	} else {
+		ret = vchiq_ioctl_compat_table[ioctl_nr].func(instance, cmd, arg);
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
+				"  ioctl(compat) instance %lx, cmd %s -> %ld",
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
@@ -1660,6 +2345,9 @@ static const struct file_operations
 vchiq_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = vchiq_ioctl,
+#if defined(CONFIG_COMPAT)
+	.compat_ioctl = vchiq_ioctl_compat,
+#endif
 	.open = vchiq_open,
 	.release = vchiq_release,
 	.read = vchiq_read
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 377e8e4..5bb9d12 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -93,6 +93,11 @@ typedef struct {
 	unsigned int size;
 } VCHIQ_ELEMENT_T;
 
+struct vchiq_element32 {
+	u32 data;
+	unsigned int size;
+};
+
 typedef unsigned int VCHIQ_SERVICE_HANDLE_T;
 
 typedef VCHIQ_STATUS_T (*VCHIQ_CALLBACK_T)(VCHIQ_REASON_T, VCHIQ_HEADER_T *,
@@ -104,6 +109,12 @@ typedef struct vchiq_service_base_struct {
 	void *userdata;
 } VCHIQ_SERVICE_BASE_T;
 
+struct vchiq_service_base32 {
+	int fourcc;
+	u32 callback;
+	u32 userdata;
+};
+
 typedef struct vchiq_service_params_struct {
 	int fourcc;
 	VCHIQ_CALLBACK_T callback;
@@ -112,6 +123,14 @@ typedef struct vchiq_service_params_struct {
 	short version_min;   /* Update for incompatible changes */
 } VCHIQ_SERVICE_PARAMS_T;
 
+struct vchiq_service_params32 {
+	int fourcc;
+	u32 callback;
+	u32 userdata;
+	short version;       /* Increment for non-trivial changes */
+	short version_min;   /* Update for incompatible changes */
+};
+
 typedef struct vchiq_config_struct {
 	unsigned int max_msg_size;
 	unsigned int bulk_threshold; /* The message size above which it
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 6137ae9..412ab0f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -47,12 +47,25 @@ typedef struct {
 	unsigned int handle;       /* OUT */
 } VCHIQ_CREATE_SERVICE_T;
 
+struct vchiq_create_service32 {
+	struct vchiq_service_params32 params;
+	int is_open;
+	int is_vchi;
+	unsigned int handle;       /* OUT */
+};
+
 typedef struct {
 	unsigned int handle;
 	unsigned int count;
 	const VCHIQ_ELEMENT_T *elements;
 } VCHIQ_QUEUE_MESSAGE_T;
 
+struct vchiq_queue_message32 {
+	unsigned int handle;
+	unsigned int count;
+	u32 elements;
+};
+
 typedef struct {
 	unsigned int handle;
 	void *data;
@@ -61,6 +74,14 @@ typedef struct {
 	VCHIQ_BULK_MODE_T mode;
 } VCHIQ_QUEUE_BULK_TRANSFER_T;
 
+struct vchiq_queue_bulk_transfer32 {
+	unsigned int handle;
+	u32 data;
+	unsigned int size;
+	u32 userdata;
+	VCHIQ_BULK_MODE_T mode;
+};
+
 typedef struct {
 	VCHIQ_REASON_T reason;
 	VCHIQ_HEADER_T *header;
@@ -68,6 +89,13 @@ typedef struct {
 	void *bulk_userdata;
 } VCHIQ_COMPLETION_DATA_T;
 
+struct vchiq_completion_data32 {
+	VCHIQ_REASON_T reason;
+	u32 header;
+	u32 service_userdata;
+	u32 bulk_userdata;
+};
+
 typedef struct {
 	unsigned int count;
 	VCHIQ_COMPLETION_DATA_T *buf;
@@ -76,6 +104,14 @@ typedef struct {
 	void **msgbufs;
 } VCHIQ_AWAIT_COMPLETION_T;
 
+struct vchiq_await_completion32 {
+	unsigned int count;
+	u32 buf;
+	unsigned int msgbufsize;
+	unsigned int msgbufcount; /* IN/OUT */
+	u32 msgbufs;
+};
+
 typedef struct {
 	unsigned int handle;
 	int blocking;
@@ -83,11 +119,23 @@ typedef struct {
 	void *buf;
 } VCHIQ_DEQUEUE_MESSAGE_T;
 
+struct vchiq_dequeue_message32 {
+	unsigned int handle;
+	int blocking;
+	unsigned int bufsize;
+	u32 buf;
+};
+
 typedef struct {
 	unsigned int config_size;
 	VCHIQ_CONFIG_T *pconfig;
 } VCHIQ_GET_CONFIG_T;
 
+struct vchiq_get_config32 {
+	unsigned int config_size;
+	u32 pconfig;
+};
+
 typedef struct {
 	unsigned int handle;
 	VCHIQ_SERVICE_OPTION_T option;
@@ -99,24 +147,43 @@ typedef struct {
 	size_t    num_bytes;
 } VCHIQ_DUMP_MEM_T;
 
+struct vchiq_dump_mem32 {
+	u32 virt_addr;
+	u32 num_bytes;
+};
+
 #define VCHIQ_IOC_CONNECT              _IO(VCHIQ_IOC_MAGIC,   0)
 #define VCHIQ_IOC_SHUTDOWN             _IO(VCHIQ_IOC_MAGIC,   1)
 #define VCHIQ_IOC_CREATE_SERVICE \
 	_IOWR(VCHIQ_IOC_MAGIC, 2, VCHIQ_CREATE_SERVICE_T)
+#define VCHIQ_IOC_CREATE_SERVICE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 2, struct vchiq_create_service32)
 #define VCHIQ_IOC_REMOVE_SERVICE       _IO(VCHIQ_IOC_MAGIC,   3)
 #define VCHIQ_IOC_QUEUE_MESSAGE \
 	_IOW(VCHIQ_IOC_MAGIC,  4, VCHIQ_QUEUE_MESSAGE_T)
+#define VCHIQ_IOC_QUEUE_MESSAGE32 \
+	_IOW(VCHIQ_IOC_MAGIC,  4, struct vchiq_queue_message32)
 #define VCHIQ_IOC_QUEUE_BULK_TRANSMIT \
 	_IOWR(VCHIQ_IOC_MAGIC, 5, VCHIQ_QUEUE_BULK_TRANSFER_T)
+#define VCHIQ_IOC_QUEUE_BULK_TRANSMIT32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 5, struct vchiq_queue_bulk_transfer32)
 #define VCHIQ_IOC_QUEUE_BULK_RECEIVE \
 	_IOWR(VCHIQ_IOC_MAGIC, 6, VCHIQ_QUEUE_BULK_TRANSFER_T)
+#define VCHIQ_IOC_QUEUE_BULK_RECEIVE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 6, struct vchiq_queue_bulk_transfer32)
 #define VCHIQ_IOC_AWAIT_COMPLETION \
 	_IOWR(VCHIQ_IOC_MAGIC, 7, VCHIQ_AWAIT_COMPLETION_T)
+#define VCHIQ_IOC_AWAIT_COMPLETION32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 7, struct vchiq_await_completion32)
 #define VCHIQ_IOC_DEQUEUE_MESSAGE \
 	_IOWR(VCHIQ_IOC_MAGIC, 8, VCHIQ_DEQUEUE_MESSAGE_T)
+#define VCHIQ_IOC_DEQUEUE_MESSAGE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 8, struct vchiq_dequeue_message32)
 #define VCHIQ_IOC_GET_CLIENT_ID        _IO(VCHIQ_IOC_MAGIC,   9)
 #define VCHIQ_IOC_GET_CONFIG \
 	_IOWR(VCHIQ_IOC_MAGIC, 10, VCHIQ_GET_CONFIG_T)
+#define VCHIQ_IOC_GET_CONFIG32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 10, struct vchiq_get_config32)
 #define VCHIQ_IOC_CLOSE_SERVICE        _IO(VCHIQ_IOC_MAGIC,   11)
 #define VCHIQ_IOC_USE_SERVICE          _IO(VCHIQ_IOC_MAGIC,   12)
 #define VCHIQ_IOC_RELEASE_SERVICE      _IO(VCHIQ_IOC_MAGIC,   13)
@@ -124,6 +191,8 @@ typedef struct {
 	_IOW(VCHIQ_IOC_MAGIC,  14, VCHIQ_SET_SERVICE_OPTION_T)
 #define VCHIQ_IOC_DUMP_PHYS_MEM \
 	_IOW(VCHIQ_IOC_MAGIC,  15, VCHIQ_DUMP_MEM_T)
+#define VCHIQ_IOC_DUMP_PHYS_MEM32 \
+	_IOW(VCHIQ_IOC_MAGIC,  15, struct vchiq_dump_mem32)
 #define VCHIQ_IOC_LIB_VERSION          _IO(VCHIQ_IOC_MAGIC,   16)
 #define VCHIQ_IOC_CLOSE_DELIVERED      _IO(VCHIQ_IOC_MAGIC,   17)
 #define VCHIQ_IOC_MAX                  17
-- 
2.10.2
