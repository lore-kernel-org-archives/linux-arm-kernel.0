From: mzoran@crowfest.net (Michael Zoran)
Date: Mon,  7 Nov 2016 16:48:35 -0800
Subject: [PATCH] staging: vc04_services: Add 32-bit compatibility ioctls
Message-ID: <20161108004835.7458-1-mzoran@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VCHIQ/vc04_services has a userland device interface
that includes ioctls.  The ioctls are very pointer
dependent, so in the case of 32-bit running on top
of a 64-bit kernel, it is necessary to deal with
the structure differences.

The solution to this is that the standard ioctl numbering
mechanism includes a data size field. Since the size of the
userland data structures change between 32-bit and 64-bit,
the length of the data can be used to easily determine the
type of application.

On 64-bit ONLY - Compatibility ioctls are defined.

Example:

Native ioctl:
	_IOW(VCHIQ_IOC_MAGIC,  4, VCHIQ_QUEUE_MESSAGE_T)

Compatibility ioctl:
	_IOW(VCHIQ_IOC_MAGIC,  4, VCHIQ_QUEUE_MESSAGE32_T)

For this particular ioctl, the two ioctls share a different
code path.  For some ioctls, it is much easier to share
the same code path and only occasionally handle the differences.
This is typically done by copying the 32-bit datastructure into
the 64-bit datastructure after it has been read from userland.

Testing:

1. vchiq_test -f 10 and vchiq_test -p 1 were run from a native
64-bit OS(debian sid) to check for regressions.

2. vchiq_test -f 10 and vchiq_test -p 1 where run from a 32-bit
chroot install from the same OS to test the compatibility ioctls.

Both test cases now pass.

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 269 +++++++++++++++++++++
 .../vc04_services/interface/vchiq_arm/vchiq_if.h   |  25 ++
 .../interface/vchiq_arm/vchiq_ioctl.h              | 102 ++++++++
 3 files changed, 396 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 8fcd940..df343a0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -573,12 +573,40 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				"vchiq: could not connect: %d", status);
 		break;
 
+#if defined(CONFIG_64BIT)
+	case VCHIQ_IOC_CREATE_SERVICE32:
+#endif
 	case VCHIQ_IOC_CREATE_SERVICE: {
 		VCHIQ_CREATE_SERVICE_T args;
 		USER_SERVICE_T *user_service = NULL;
 		void *userdata;
 		int srvstate;
 
+#if defined(CONFIG_64BIT)
+		if (cmd == VCHIQ_IOC_CREATE_SERVICE32) {
+			VCHIQ_CREATE_SERVICE32_T args32;
+
+			if (copy_from_user
+				(&args32, (const void __user *)arg,
+				sizeof(args32)) != 0) {
+				ret = -EFAULT;
+				break;
+			}
+
+			args.params.fourcc   = args32.params.fourcc;
+			args.params.callback =
+				(VCHIQ_CALLBACK_T)(unsigned long)
+					args32.params.callback;
+			args.params.userdata =
+				(void *)(unsigned long)
+					args32.params.userdata;
+			args.params.version = args32.params.version;
+			args.params.version_min = args32.params.version_min;
+			args.is_open = args32.is_open;
+			args.is_vchi = args32.is_vchi;
+			args.handle  = args32.handle;
+		} else
+#endif
 		if (copy_from_user
 			 (&args, (const void __user *)arg,
 			  sizeof(args)) != 0) {
@@ -641,6 +669,19 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				}
 			}
 
+#if defined(CONFIG_64BIT)
+			if (cmd == VCHIQ_IOC_CREATE_SERVICE32) {
+				if (copy_to_user((void __user *)
+						 &(((VCHIQ_CREATE_SERVICE32_T __user *)
+						 arg)->handle),
+						 (const void *)&service->handle,
+						sizeof(service->handle)) != 0) {
+							ret = -EFAULT;
+							vchiq_remove_service(
+								service->handle);
+				}
+			} else
+#endif
 			if (copy_to_user((void __user *)
 				&(((VCHIQ_CREATE_SERVICE_T __user *)
 					arg)->handle),
@@ -736,6 +777,49 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			ret = -EINVAL;
 	} break;
 
+#if defined(CONFIG_64BIT)
+	case VCHIQ_IOC_QUEUE_MESSAGE32: {
+		VCHIQ_QUEUE_MESSAGE32_T args32;
+
+		if (copy_from_user
+			 (&args32, (const void __user *)arg,
+			  sizeof(args32)) != 0) {
+			ret = -EFAULT;
+			break;
+		}
+
+		service = find_service_for_instance(instance, args32.handle);
+
+		if ((service) && (args32.count <= MAX_ELEMENTS)) {
+			/* Copy elements into kernel space */
+			VCHIQ_ELEMENT_T elements[MAX_ELEMENTS];
+			VCHIQ_ELEMENT32_T elements32[MAX_ELEMENTS];
+
+			if (copy_from_user(elements32,
+					   (void *)(unsigned long)args32.elements,
+					   args32.count * sizeof(VCHIQ_ELEMENT32_T)) == 0) {
+						unsigned int i;
+
+						for (i = 0; i < args32.count; i++) {
+							elements[i].data =
+								(const void *)(unsigned long)
+								elements32[i].data;
+							elements[i].size =
+								elements32[i].size;
+						}
+						status = vchiq_ioc_queue_message
+							(args32.handle,
+							elements, args32.count);
+				}
+			else {
+				ret = -EFAULT;
+			}
+		} else {
+			ret = -EINVAL;
+		}
+	} break;
+#endif
+
 	case VCHIQ_IOC_QUEUE_MESSAGE: {
 		VCHIQ_QUEUE_MESSAGE_T args;
 		if (copy_from_user
@@ -762,6 +846,10 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 	} break;
 
+#if defined(CONFIG_64BIT)
+	case VCHIQ_IOC_QUEUE_BULK_TRANSMIT32:
+	case VCHIQ_IOC_QUEUE_BULK_RECEIVE32:
+#endif
 	case VCHIQ_IOC_QUEUE_BULK_TRANSMIT:
 	case VCHIQ_IOC_QUEUE_BULK_RECEIVE: {
 		VCHIQ_QUEUE_BULK_TRANSFER_T args;
@@ -770,6 +858,28 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			(cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT) ?
 			VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;
 
+#if defined(CONFIG_64BIT)
+		if (cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT32 ||
+		    cmd == VCHIQ_IOC_QUEUE_BULK_RECEIVE32) {
+			VCHIQ_QUEUE_BULK_TRANSFER32_T args32;
+
+			if (copy_from_user
+				(&args32, (const void __user *)arg,
+				sizeof(args32)) != 0) {
+				ret = -EFAULT;
+				break;
+			}
+
+			args.handle	= args32.handle;
+			args.data	= (void *)(unsigned long)args32.data;
+			args.size	= args32.size;
+			args.userdata   = (void *)(unsigned long)args32.userdata;
+			args.mode	= args32.mode;
+
+			dir = (cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT32) ?
+				VCHIQ_BULK_TRANSMIT : VCHIQ_BULK_RECEIVE;
+		} else
+#endif
 		if (copy_from_user
 			(&args, (const void __user *)arg,
 			sizeof(args)) != 0) {
@@ -847,6 +957,18 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				"saved bulk_waiter %pK for pid %d",
 				waiter, current->pid);
 
+#if defined(CONFIG_64BIT)
+			if (cmd == VCHIQ_IOC_QUEUE_BULK_TRANSMIT32 ||
+			    cmd == VCHIQ_IOC_QUEUE_BULK_RECEIVE32) {
+				if (copy_to_user((void __user *)
+						 &(((VCHIQ_QUEUE_BULK_TRANSFER32_T __user *)
+						 arg)->mode),
+						 (const void *)&mode_waiting,
+						 sizeof(mode_waiting)) != 0)
+							ret = -EFAULT;
+			} else
+#endif
+
 			if (copy_to_user((void __user *)
 				&(((VCHIQ_QUEUE_BULK_TRANSFER_T __user *)
 					arg)->mode),
@@ -856,6 +978,9 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 	} break;
 
+#if defined(CONFIG_64BIT)
+	case VCHIQ_IOC_AWAIT_COMPLETION32:
+#endif
 	case VCHIQ_IOC_AWAIT_COMPLETION: {
 		VCHIQ_AWAIT_COMPLETION_T args;
 
@@ -865,6 +990,25 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			break;
 		}
 
+#if defined(CONFIG_64BIT)
+		if (cmd == VCHIQ_IOC_AWAIT_COMPLETION32) {
+			VCHIQ_AWAIT_COMPLETION32_T args32;
+
+			if (copy_from_user(&args32, (const void __user *)arg,
+					   sizeof(args32)) != 0) {
+						ret = -EFAULT;
+						break;
+			}
+
+			args.count = args32.count;
+			args.buf =
+				(VCHIQ_COMPLETION_DATA_T *)(unsigned long)
+					args32.buf;
+			args.msgbufsize = args32.msgbufsize;
+			args.msgbufcount = args32.msgbufcount;
+			args.msgbufs = (void **)(unsigned long)args32.msgbufs;
+		} else
+#endif
 		if (copy_from_user(&args, (const void __user *)arg,
 			sizeof(args)) != 0) {
 			ret = -EFAULT;
@@ -942,6 +1086,24 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 						break;
 					/* Get the pointer from user space */
 					msgbufcount--;
+#if defined(CONFIG_64BIT)
+					if (cmd == VCHIQ_IOC_AWAIT_COMPLETION32) {
+						u32 msgbuf32;
+
+						if (copy_from_user(&msgbuf32,
+								   (const void __user *)
+								   (void *)(args.msgbufs) +
+								   (sizeof(u32) * msgbufcount),
+								   sizeof(msgbuf32)) != 0) {
+									if (ret == 0)
+										ret = -EFAULT;
+									break;
+						}
+
+						msgbuf = (void *)(unsigned long)
+								msgbuf32;
+					} else
+#endif
 					if (copy_from_user(&msgbuf,
 						(const void __user *)
 						&args.msgbufs[msgbufcount],
@@ -974,6 +1136,33 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 					!instance->use_close_delivered)
 					unlock_service(service);
 
+#if defined(CONFIG_64BIT)
+				if (cmd == VCHIQ_IOC_AWAIT_COMPLETION32) {
+					VCHIQ_COMPLETION_DATA32_T completion32;
+
+					completion32.reason =
+						completion->reason;
+					completion32.header =
+						(u32)(unsigned long)
+							completion->header;
+					completion32.service_userdata =
+						(u32)(unsigned long)
+							completion->service_userdata;
+					completion32.bulk_userdata =
+						(u32)(unsigned long)
+							completion->bulk_userdata;
+
+					if (copy_to_user((void __user *)(
+						(void *)args.buf +
+						ret * sizeof(VCHIQ_COMPLETION_DATA32_T)),
+						&completion32,
+						sizeof(VCHIQ_COMPLETION_DATA32_T)) != 0) {
+						   if (ret == 0)
+							ret = -EFAULT;
+						break;
+					}
+				} else
+#endif
 				if (copy_to_user((void __user *)(
 					(size_t)args.buf +
 					ret * sizeof(VCHIQ_COMPLETION_DATA_T)),
@@ -988,6 +1177,17 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			}
 
 			if (msgbufcount != args.msgbufcount) {
+#if defined(CONFIG_64BIT)
+				if (cmd == VCHIQ_IOC_AWAIT_COMPLETION32) {
+					if (copy_to_user((void __user *)
+							 &((VCHIQ_AWAIT_COMPLETION32_T *)arg)->
+							 msgbufcount,
+							 &msgbufcount,
+							 sizeof(msgbufcount)) != 0) {
+								ret = -EFAULT;
+					}
+				} else
+#endif
 				if (copy_to_user((void __user *)
 					&((VCHIQ_AWAIT_COMPLETION_T *)arg)->
 						msgbufcount,
@@ -1004,12 +1204,32 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		DEBUG_TRACE(AWAIT_COMPLETION_LINE);
 	} break;
 
+#if defined(CONFIG_64BIT)
+	case VCHIQ_IOC_DEQUEUE_MESSAGE32:
+#endif
 	case VCHIQ_IOC_DEQUEUE_MESSAGE: {
 		VCHIQ_DEQUEUE_MESSAGE_T args;
 		USER_SERVICE_T *user_service;
 		VCHIQ_HEADER_T *header;
 
 		DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+#if defined(CONFIG_64BIT)
+		if (cmd == VCHIQ_IOC_DEQUEUE_MESSAGE32) {
+			VCHIQ_DEQUEUE_MESSAGE32_T args32;
+
+			if (copy_from_user(&args32,
+					   (const void __user *)arg,
+					   sizeof(args32)) != 0) {
+						ret = -EFAULT;
+						break;
+			}
+
+			args.handle	= args32.handle;
+			args.blocking	= args32.blocking;
+			args.bufsize	= args32.bufsize;
+			args.buf	= (void *)(unsigned long)args32.buf;
+		} else
+#endif
 		if (copy_from_user
 			 (&args, (const void __user *)arg,
 			  sizeof(args)) != 0) {
@@ -1093,6 +1313,37 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ret = vchiq_get_client_id(handle);
 	} break;
 
+#if defined(CONFIG_64BIT)
+	case VCHIQ_IOC_GET_CONFIG32: {
+		VCHIQ_GET_CONFIG32_T args32;
+		VCHIQ_CONFIG_T config;
+
+		if (copy_from_user(&args32,
+				   (const void __user *)arg,
+				   sizeof(args32)) != 0) {
+					ret = -EFAULT;
+					break;
+		}
+		if (args32.config_size > sizeof(config)) {
+			ret = -EINVAL;
+			break;
+		}
+		status = vchiq_get_config(instance,
+					  args32.config_size,
+					  &config);
+		if (status == VCHIQ_SUCCESS) {
+			if (copy_to_user((void __user *)(unsigned long)
+					 args32.pconfig,
+					 &config,
+					 args32.config_size)
+					 != 0) {
+						ret = -EFAULT;
+						break;
+			}
+		}
+	} break;
+#endif
+
 	case VCHIQ_IOC_GET_CONFIG: {
 		VCHIQ_GET_CONFIG_T args;
 		VCHIQ_CONFIG_T config;
@@ -1136,6 +1387,21 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				args.handle, args.option, args.value);
 	} break;
 
+#if defined(CONFIG_64BIT)
+	case VCHIQ_IOC_DUMP_PHYS_MEM32: {
+		VCHIQ_DUMP_MEM32_T  args32;
+
+		if (copy_from_user(&args32,
+				   (const void __user *)arg,
+				   sizeof(args32)) != 0) {
+					ret = -EFAULT;
+					break;
+		}
+		dump_phys_mem((void *)(unsigned long)args32.virt_addr,
+			      args32.num_bytes);
+	} break;
+#endif
+
 	case VCHIQ_IOC_DUMP_PHYS_MEM: {
 		VCHIQ_DUMP_MEM_T  args;
 
@@ -1660,6 +1926,9 @@ static const struct file_operations
 vchiq_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = vchiq_ioctl,
+#if defined(CONFIG_64BIT)
+	.compat_ioctl = vchiq_ioctl,
+#endif
 	.open = vchiq_open,
 	.release = vchiq_release,
 	.read = vchiq_read
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 377e8e4..f4cc324 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -93,6 +93,13 @@ typedef struct {
 	unsigned int size;
 } VCHIQ_ELEMENT_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct {
+	u32 data;
+	unsigned int size;
+} VCHIQ_ELEMENT32_T;
+#endif
+
 typedef unsigned int VCHIQ_SERVICE_HANDLE_T;
 
 typedef VCHIQ_STATUS_T (*VCHIQ_CALLBACK_T)(VCHIQ_REASON_T, VCHIQ_HEADER_T *,
@@ -104,6 +111,14 @@ typedef struct vchiq_service_base_struct {
 	void *userdata;
 } VCHIQ_SERVICE_BASE_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct vchiq_service_base_struct32 {
+	int fourcc;
+	u32 callback;
+	u32 userdata;
+} VCHIQ_SERVICE_BASE32_T;
+#endif
+
 typedef struct vchiq_service_params_struct {
 	int fourcc;
 	VCHIQ_CALLBACK_T callback;
@@ -112,6 +127,16 @@ typedef struct vchiq_service_params_struct {
 	short version_min;   /* Update for incompatible changes */
 } VCHIQ_SERVICE_PARAMS_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct vchiq_service_params_struct32 {
+	int fourcc;
+	u32 callback;
+	u32 userdata;
+	short version;       /* Increment for non-trivial changes */
+	short version_min;   /* Update for incompatible changes */
+} VCHIQ_SERVICE_PARAMS32_T;
+#endif
+
 typedef struct vchiq_config_struct {
 	unsigned int max_msg_size;
 	unsigned int bulk_threshold; /* The message size above which it
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 6137ae9..001d346 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -47,12 +47,29 @@ typedef struct {
 	unsigned int handle;       /* OUT */
 } VCHIQ_CREATE_SERVICE_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct {
+	VCHIQ_SERVICE_PARAMS32_T params;
+	int is_open;
+	int is_vchi;
+	unsigned int handle;       /* OUT */
+} VCHIQ_CREATE_SERVICE32_T;
+#endif
+
 typedef struct {
 	unsigned int handle;
 	unsigned int count;
 	const VCHIQ_ELEMENT_T *elements;
 } VCHIQ_QUEUE_MESSAGE_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct {
+	unsigned int handle;
+	unsigned int count;
+	u32 elements;
+} VCHIQ_QUEUE_MESSAGE32_T;
+#endif
+
 typedef struct {
 	unsigned int handle;
 	void *data;
@@ -61,6 +78,16 @@ typedef struct {
 	VCHIQ_BULK_MODE_T mode;
 } VCHIQ_QUEUE_BULK_TRANSFER_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct {
+	unsigned int handle;
+	u32 data;
+	unsigned int size;
+	u32 userdata;
+	VCHIQ_BULK_MODE_T mode;
+} VCHIQ_QUEUE_BULK_TRANSFER32_T;
+#endif
+
 typedef struct {
 	VCHIQ_REASON_T reason;
 	VCHIQ_HEADER_T *header;
@@ -68,6 +95,15 @@ typedef struct {
 	void *bulk_userdata;
 } VCHIQ_COMPLETION_DATA_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct {
+	VCHIQ_REASON_T reason;
+	u32 header;
+	u32 service_userdata;
+	u32 bulk_userdata;
+} VCHIQ_COMPLETION_DATA32_T;
+#endif
+
 typedef struct {
 	unsigned int count;
 	VCHIQ_COMPLETION_DATA_T *buf;
@@ -76,6 +112,16 @@ typedef struct {
 	void **msgbufs;
 } VCHIQ_AWAIT_COMPLETION_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct {
+	unsigned int count;
+	u32 buf;
+	unsigned int msgbufsize;
+	unsigned int msgbufcount; /* IN/OUT */
+	u32 msgbufs;
+} VCHIQ_AWAIT_COMPLETION32_T;
+#endif
+
 typedef struct {
 	unsigned int handle;
 	int blocking;
@@ -83,11 +129,27 @@ typedef struct {
 	void *buf;
 } VCHIQ_DEQUEUE_MESSAGE_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct {
+	unsigned int handle;
+	int blocking;
+	unsigned int bufsize;
+	u32 buf;
+} VCHIQ_DEQUEUE_MESSAGE32_T;
+#endif
+
 typedef struct {
 	unsigned int config_size;
 	VCHIQ_CONFIG_T *pconfig;
 } VCHIQ_GET_CONFIG_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct {
+	unsigned int config_size;
+	u32 pconfig;
+} VCHIQ_GET_CONFIG32_T;
+#endif
+
 typedef struct {
 	unsigned int handle;
 	VCHIQ_SERVICE_OPTION_T option;
@@ -99,24 +161,60 @@ typedef struct {
 	size_t    num_bytes;
 } VCHIQ_DUMP_MEM_T;
 
+#if defined(CONFIG_64BIT)
+typedef struct {
+	u32 virt_addr;
+	u32 num_bytes;
+} VCHIQ_DUMP_MEM32_T;
+
+#endif
+
 #define VCHIQ_IOC_CONNECT              _IO(VCHIQ_IOC_MAGIC,   0)
 #define VCHIQ_IOC_SHUTDOWN             _IO(VCHIQ_IOC_MAGIC,   1)
 #define VCHIQ_IOC_CREATE_SERVICE \
 	_IOWR(VCHIQ_IOC_MAGIC, 2, VCHIQ_CREATE_SERVICE_T)
+#if defined(CONFIG_64BIT)
+#define VCHIQ_IOC_CREATE_SERVICE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 2, VCHIQ_CREATE_SERVICE32_T)
+#endif
 #define VCHIQ_IOC_REMOVE_SERVICE       _IO(VCHIQ_IOC_MAGIC,   3)
 #define VCHIQ_IOC_QUEUE_MESSAGE \
 	_IOW(VCHIQ_IOC_MAGIC,  4, VCHIQ_QUEUE_MESSAGE_T)
+#if defined(CONFIG_64BIT)
+#define VCHIQ_IOC_QUEUE_MESSAGE32 \
+	_IOW(VCHIQ_IOC_MAGIC,  4, VCHIQ_QUEUE_MESSAGE32_T)
+#endif
 #define VCHIQ_IOC_QUEUE_BULK_TRANSMIT \
 	_IOWR(VCHIQ_IOC_MAGIC, 5, VCHIQ_QUEUE_BULK_TRANSFER_T)
+#if defined(CONFIG_64BIT)
+#define VCHIQ_IOC_QUEUE_BULK_TRANSMIT32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 5, VCHIQ_QUEUE_BULK_TRANSFER32_T)
+#endif
 #define VCHIQ_IOC_QUEUE_BULK_RECEIVE \
 	_IOWR(VCHIQ_IOC_MAGIC, 6, VCHIQ_QUEUE_BULK_TRANSFER_T)
+#if defined(CONFIG_64BIT)
+#define VCHIQ_IOC_QUEUE_BULK_RECEIVE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 6, VCHIQ_QUEUE_BULK_TRANSFER32_T)
+#endif
 #define VCHIQ_IOC_AWAIT_COMPLETION \
 	_IOWR(VCHIQ_IOC_MAGIC, 7, VCHIQ_AWAIT_COMPLETION_T)
+#if defined(CONFIG_64BIT)
+#define VCHIQ_IOC_AWAIT_COMPLETION32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 7, VCHIQ_AWAIT_COMPLETION32_T)
+#endif
 #define VCHIQ_IOC_DEQUEUE_MESSAGE \
 	_IOWR(VCHIQ_IOC_MAGIC, 8, VCHIQ_DEQUEUE_MESSAGE_T)
+#if defined(CONFIG_64BIT)
+#define VCHIQ_IOC_DEQUEUE_MESSAGE32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 8, VCHIQ_DEQUEUE_MESSAGE32_T)
+#endif
 #define VCHIQ_IOC_GET_CLIENT_ID        _IO(VCHIQ_IOC_MAGIC,   9)
 #define VCHIQ_IOC_GET_CONFIG \
 	_IOWR(VCHIQ_IOC_MAGIC, 10, VCHIQ_GET_CONFIG_T)
+#if defined(CONFIG_64BIT)
+#define VCHIQ_IOC_GET_CONFIG32 \
+	_IOWR(VCHIQ_IOC_MAGIC, 10, VCHIQ_GET_CONFIG32_T)
+#endif
 #define VCHIQ_IOC_CLOSE_SERVICE        _IO(VCHIQ_IOC_MAGIC,   11)
 #define VCHIQ_IOC_USE_SERVICE          _IO(VCHIQ_IOC_MAGIC,   12)
 #define VCHIQ_IOC_RELEASE_SERVICE      _IO(VCHIQ_IOC_MAGIC,   13)
@@ -124,6 +222,10 @@ typedef struct {
 	_IOW(VCHIQ_IOC_MAGIC,  14, VCHIQ_SET_SERVICE_OPTION_T)
 #define VCHIQ_IOC_DUMP_PHYS_MEM \
 	_IOW(VCHIQ_IOC_MAGIC,  15, VCHIQ_DUMP_MEM_T)
+#if defined(CONFIG_64BIT)
+#define VCHIQ_IOC_DUMP_PHYS_MEM32 \
+	_IOW(VCHIQ_IOC_MAGIC,  15, VCHIQ_DUMP_MEM32_T)
+#endif
 #define VCHIQ_IOC_LIB_VERSION          _IO(VCHIQ_IOC_MAGIC,   16)
 #define VCHIQ_IOC_CLOSE_DELIVERED      _IO(VCHIQ_IOC_MAGIC,   17)
 #define VCHIQ_IOC_MAX                  17
-- 
2.10.2
