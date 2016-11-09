From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Nov 2016 22:07:38 +0100
Subject: [PATCH] staging: vc04_services: rework ioctl code path
In-Reply-To: <20161109203727.28333-1-mzoran@crowfest.net>
References: <20161109203727.28333-1-mzoran@crowfest.net>
Message-ID: <6602710.g0hLoND8U1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 9, 2016 12:37:27 PM CET Michael Zoran wrote:

>  static long
> -vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +vchiq_ioctl_shutdown(VCHIQ_INSTANCE_T instance,
> +		     unsigned int cmd,
> +		     unsigned long arg) {

This does not use cmd or arg, so you can just drop both parameters.
In cases where the argument is actually used, better make it take
a pointer than an unsigned long argument, to save a conversion.

> +	vchiq_log_trace(vchiq_arm_log_level,
> +			"vchiq_ioctl(compat) - instance %pK, cmd %s, arg %lx",
> +			instance,
> +			((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) &&
> +			(ioctl_nr <= VCHIQ_IOC_MAX)) ?
> +			ioctl_names[ioctl_nr] : "<invalid>", arg);

I'd suggest dropping the log_trace here.

> +	if ((ioctl_nr > VCHIQ_IOC_MAX) ||
> +	    (vchiq_ioctl_compat_table[ioctl_nr].ioctl != cmd)) {
> +		ret = -ENOTTY;
> +	} else {
> +		ret = vchiq_ioctl_compat_table[ioctl_nr].func(instance, cmd, arg);
>  	}

It's rather unusual to have a table like this, most drivers have a
simple switch/case statement. If you do a swapper like this, better
make it do something more and let it also pass the data as a kernel
pointer that you copy in and out of the kernel according to the
direction and size bits in the command number.

> @@ -104,6 +109,12 @@ typedef struct vchiq_service_base_struct {
>  	void *userdata;
>  } VCHIQ_SERVICE_BASE_T;
>  
> +struct vchiq_service_base32 {
> +	int fourcc;
> +	u32 callback;
> +	u32 userdata;
> +};

Maybe better use compat_uptr_t along with compat_ptr() for passing
32-bit pointers. This will however require moving the struct definitions
into an #ifdef.

	Arnd
