From: philippe.retornaz@gmail.com (=?windows-1252?Q?Philippe_R=E9tornaz?=)
Date: Tue, 07 Oct 2014 09:46:59 +0200
Subject: [PATCH 01/44] kernel: Add support for poweroff handler call chain
In-Reply-To: <1412659726-29957-2-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-2-git-send-email-linux@roeck-us.net>
Message-ID: <54339A73.40107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This seems exactly what I would need on the mc13783 to handle cleanly 
the poweroff,
but after reading this patchset I have the following question:

[...]

> +/*
> + *	Notifier list for kernel code which wants to be called
> + *	to power off the system.
> + */
> +static ATOMIC_NOTIFIER_HEAD(poweroff_handler_list);

[...]

> +void do_kernel_poweroff(void)
> +{
> +	atomic_notifier_call_chain(&poweroff_handler_list, 0, NULL);
> +}
> +

It seems that the poweroff callback needs to be atomic as per
_atomic_notifier_call_chain documentation:

	"Calls each function in a notifier chain in turn.  The functions
	 run in an atomic context"

But this is a problem for many MFD (mc13783, twl4030 etc ...) which are
accessible on only a blocking bus (SPI, I2C).

What I am missing here ?

Thanks,

Philippe
