From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 27 Jun 2011 19:05:06 +0530
Subject: [PATCH v3 05/12] OMAP: Serial: Hold console lock for console
	usage.
In-Reply-To: <87boxmsrjt.fsf@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-6-git-send-email-govindraj.raja@ti.com>
	<87boxmsrjt.fsf@ti.com>
Message-ID: <BANLkTi=Zcre6cXrD4bRw-K6DtPKX3=O7jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Acquire console lock before enabling and writing to console-uart
>> to avoid any recursive prints from console write.
>> for ex:
>> ? ? ? ? --> printk
>> ? ? ? ? ? --> uart_console_write
>> ? ? ? ? ? ? --> get_sync
>> ? ? ? ? ? ? ? --> printk from omap_device enable
>> ? ? ? ? ? ? ? ? --> uart_console write
>>
>> Use RPM_SUSPENDING check to avoid below scenario during bootup
>> As during bootup console_lock is not available.
>> ? ? ? ?--> uart_add_one_port
>> ? ? ? ? ? ?--> console_register
>> ? ? ? ? ? ? ? ?--> console_lock
>> ? ? ? ? ? ? ? ? --> console_unlock
>> ? ? ? ? ? ? ? ? ? ? ?--> call_console_drivers (here yet console_lock is not released)
>> ? ? ? ? ? ? ? ? ? ? ? ? ? --> uart_console_write
>>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> ?drivers/tty/serial/omap-serial.c | ? 20 +++++++++++++++++++-
>> ?1 files changed, 19 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index 897416f..ee94291 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1008,7 +1008,22 @@ serial_omap_console_write(struct console *co, const char *s,
>> ? ? ? struct uart_omap_port *up = serial_omap_console_ports[co->index];
>> ? ? ? unsigned long flags;
>> ? ? ? unsigned int ier;
>> - ? ? int locked = 1;
>> + ? ? int console_lock = 0, locked = 1;
>> +
>> + ? ? if (console_trylock())
>> + ? ? ? ? ? ? console_lock = 1;
>
> So now we take the console lock on *every* console write? ?Even if the
> device is not about to be idled? ? This is rather over-protective, don't
> you think?
>

This scenario is because of print from
omap_uart_console_write --> get_sync --> omap_enable_enable
trying to print worst activate or deactivate latency some times.

will result in recursive print scenario.

holding console lock will only ensure that the print from get_sync gets
logged to be printed later to console.

>> + ? ? /*
>> + ? ? ?* If console_lock is not available and we are in suspending
>> + ? ? ?* state then we can avoid the console usage scenario
>
> s/in suspending state/runtime suspending/

ok.

>
>> + ? ? ?* as this may introduce recursive prints.
>> + ? ? ?* Basically this scenario occurs during boot while
>> + ? ? ?* printing debug bootlogs.
>
> The exact scenario for triggering this still not well described, and
> thus still I don't get it.
>

scenario is same as said above.

omap_uart_console_write --> get_sync --> omap_device

printk worst activate latency calls omap_uart_console write.

after boot up we have access to console lock,
but during boot up we don't have console lock available
and results in printk recursiveness.

> I still don't fully understand this problem,

basically its due to recursive printk during bootup
and also after bootup as said above.

> but if it's isolated to
> runtime suspending, maybe you need a console lock in the runtime_suspend
> path (like you already have in the static suspend path.)

console_lock in runtime_suspend will not help
during bootup and due to printk emerging out from
omap_device enable after system bootup.


>
>> + ? ? ?*/
>> +
>> + ? ? if (!console_lock &&
>> + ? ? ? ? ? ? up->pdev->dev.power.runtime_status == RPM_SUSPENDING)
>> + ? ? ? ? ? ? return;
>
> Assuming this was a printk, it's now lost, right? ? Not sure that's an
> acceptable solution.
>

AFAIK it gets logged prints later.

to summarize holding console lock helps after bootup
since during boot up console lock is not available need to use
above runtime_status check.

--
Thanks,
Govindraj.R


>> ? ? ? local_irq_save(flags);
>> ? ? ? if (up->port.sysrq)
>> @@ -1044,6 +1059,9 @@ serial_omap_console_write(struct console *co, const char *s,
>> ? ? ? if (up->msr_saved_flags)
>> ? ? ? ? ? ? ? check_modem_status(up);
>>
>> + ? ? if (console_lock)
>> + ? ? ? ? ? ? console_unlock();
>> +
>> ? ? ? serial_omap_port_disable(up);
>> ? ? ? if (locked)
>> ? ? ? ? ? ? ? spin_unlock(&up->port.lock);
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
