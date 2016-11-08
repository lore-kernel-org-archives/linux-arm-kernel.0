From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Nov 2016 13:11:11 +0100
Subject: [PATCH] staging: vc04_services: Add 32-bit compatibility ioctls
In-Reply-To: <20161108004835.7458-1-mzoran@crowfest.net>
References: <20161108004835.7458-1-mzoran@crowfest.net>
Message-ID: <3832904.LMk9ToHSyP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 7, 2016 4:48:35 PM CET Michael Zoran wrote:
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 269 +++++++++++++++++++++
>  .../vc04_services/interface/vchiq_arm/vchiq_if.h   |  25 ++
>  .../interface/vchiq_arm/vchiq_ioctl.h              | 102 ++++++++
>  3 files changed, 396 insertions(+)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 8fcd940..df343a0 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -573,12 +573,40 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  				"vchiq: could not connect: %d", status);
>  		break;
>  
> +#if defined(CONFIG_64BIT)
> +	case VCHIQ_IOC_CREATE_SERVICE32:
> +#endif

>  	case VCHIQ_IOC_CREATE_SERVICE: {
>  		VCHIQ_CREATE_SERVICE_T args;
>  		USER_SERVICE_T *user_service = NULL;
>  		void *userdata;
>  		int srvstate;
>  
> +#if defined(CONFIG_64BIT)
> +		if (cmd == VCHIQ_IOC_CREATE_SERVICE32) {

Better use CONFIG_COMPAT here. Also, a simple #ifdef is sufficient
as neither of those symbols can be a loadable module.

Also, just move all the compat handling into the .compat_ioctl
callback function and move out the common parts into helpers
for simplicity.

> +#if defined(CONFIG_64BIT)
> +		if (cmd == VCHIQ_IOC_AWAIT_COMPLETION32) {
> +			VCHIQ_AWAIT_COMPLETION32_T args32;
> +
> +			if (copy_from_user(&args32, (const void __user *)arg,
> +					   sizeof(args32)) != 0) {
> +						ret = -EFAULT;
> +						break;
> +			}
> +
> +			args.count = args32.count;
> +			args.buf =
> +				(VCHIQ_COMPLETION_DATA_T *)(unsigned long)
> +					args32.buf;
> +			args.msgbufsize = args32.msgbufsize;
> +			args.msgbufcount = args32.msgbufcount;
> +			args.msgbufs = (void **)(unsigned long)args32.msgbufs;
> +		} else
> +#endif

There seems to be a bit of confusion about the address space
here. args.buf should be a user space pointer, right?

> +#if defined(CONFIG_64BIT)
> +typedef struct {
> +	u32 data;
> +	unsigned int size;
> +} VCHIQ_ELEMENT32_T;
> +#endif

remove the typedefs, it just forces someone to clean it up later.

>  #define VCHIQ_IOC_CONNECT              _IO(VCHIQ_IOC_MAGIC,   0)
>  #define VCHIQ_IOC_SHUTDOWN             _IO(VCHIQ_IOC_MAGIC,   1)
>  #define VCHIQ_IOC_CREATE_SERVICE \
>  	_IOWR(VCHIQ_IOC_MAGIC, 2, VCHIQ_CREATE_SERVICE_T)
> +#if defined(CONFIG_64BIT)
> +#define VCHIQ_IOC_CREATE_SERVICE32 \
> +	_IOWR(VCHIQ_IOC_MAGIC, 2, VCHIQ_CREATE_SERVICE32_T)
> +#endif

No need for the #ifdef here.

	Arnd
