From: khilman@ti.com (Kevin Hilman)
Date: Thu, 05 May 2011 07:52:03 -0700
Subject: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console
	usage.
In-Reply-To: <BANLkTi=Ded-q777t=fTc_rcX4=HBq5Bh1g@mail.gmail.com> (Govindraj's
	message of "Thu, 5 May 2011 15:55:17 +0530")
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-6-git-send-email-govindraj.raja@ti.com>
	<87vcxqp577.fsf@ti.com>
	<BANLkTi=Ded-q777t=fTc_rcX4=HBq5Bh1g@mail.gmail.com>
Message-ID: <8762ppmc8c.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Thu, May 5, 2011 at 2:13 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> Acquire console lock before enabling and writing to console-uart
>>> to avoid any recursive prints from console write.
>>> for ex:
>>> ? ? ? --> printk
>>> ? ? ? ? --> uart_console_write
>>> ? ? ? ? ? --> get_sync
>>> ? ? ? ? ? ? --> printk from omap_device enable
>>> ? ? ? ? ? ? ? --> uart_console write
>>
>> By this time, since the device's runtime PM hooks have been called, the
>> device's rutime PM state should be set to RPM_SUSPENDING (not yet
>> RPM_SUSPENDED).
>>
>> In addition to the console lock, you should be able to use that flag to
>> avoid console writes while the console is in the process of suspending.
>>
>
> Yes RPM_SUSPENDING check helps along with console lock

Great!

> << Changes as below >>
> ---------------
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 59f548f..71964c3 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1040,6 +1040,18 @@ serial_omap_console_write(struct console *co,
> const char *s,
>         if (console_trylock())
>                 console_lock = 1;
>
> +       /*
> +        * If console_lock is not available and we are in suspending
> +        * state then we can avoid the console usage scenario
> +        * as this may introduce recursive prints.
> +        * Basically this scenario occurs during boot while
> +        * printing debug bootlogs.
> +        */
> +
> +       if (!console_lock &&
> +               up->pdev->dev.power.runtime_status == RPM_SUSPENDING)
> +               return;
> +
>         local_irq_save(flags);
>         if (up->port.sysrq)
>                 locked = 0;
>
> ------------
>
> Is it ok to check the RPM_SUSPENDING flag in driver ?
> I can't find any API currently available under runtime.h to use.

I would propose a new API in pm_runtime.h similar to
pm_runtime_suspended() that checks for this.

Kevin
