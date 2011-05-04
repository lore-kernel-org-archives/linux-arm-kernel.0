From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 4 May 2011 15:49:48 +0530
Subject: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console
	usage.
In-Reply-To: <20110504100232.GA2092@atomide.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-6-git-send-email-govindraj.raja@ti.com>
	<20110504100232.GA2092@atomide.com>
Message-ID: <BANLkTimKFXSCHX-xrG41QJZiDWppGS+EnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2011 at 3:32 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
>>
>> Also during bootup console_lock is not available.
>> ? ? ? ?--> uart_add_one_port
>> ? ? ? ? ?--> console_register
>> ? ? ? ? ? ? ?--> console_lock
>> ? ? ? ? ? ? ? --> console_unlock
>> ? ? ? ? ? ? ? ? ? ?--> call_console_drivers (here yet console_lock is not released)
>> ? ? ? ? ? ? ? ? ? ? ? ? --> uart_console_write
>>
>> Hence convert prints from omap_device_enable/disable to pr_debug.
>
> This sounds like a hack considering we have things working with
> pr_debug currently.

The reason it works currently is because we are aquiring console
lock in omap_serial_init since with the patch series cleanup and
things are moving to driver I see this issue.

The issue is due to recursive prints because of get_sync/put_sync
printing active/deactivate latency from omap_device layer.

During printk -> uart_console_write -->
we do get_sync and if clock is cut and omap_device_enable
gets called and omap_device_enable trying to pr_warn
activate latency.
Here we end up in recursive lock up from printk.

--
Thanks,
Govindraj.R

>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
