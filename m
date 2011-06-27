From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Jun 2011 15:41:39 -0700
Subject: [PATCH v3 05/12] OMAP: Serial: Hold console lock for console
	usage.
In-Reply-To: <BANLkTi=Zcre6cXrD4bRw-K6DtPKX3=O7jA@mail.gmail.com> (Govindraj's
	message of "Mon, 27 Jun 2011 19:05:06 +0530")
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-6-git-send-email-govindraj.raja@ti.com>
	<87boxmsrjt.fsf@ti.com>
	<BANLkTi=Zcre6cXrD4bRw-K6DtPKX3=O7jA@mail.gmail.com>
Message-ID: <878vsm99ss.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Sat, Jun 25, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> Acquire console lock before enabling and writing to console-uart
>>> to avoid any recursive prints from console write.
>>> for ex:
>>> ? ? ? ? --> printk
>>> ? ? ? ? ? --> uart_console_write
>>> ? ? ? ? ? ? --> get_sync
>>> ? ? ? ? ? ? ? --> printk from omap_device enable
>>> ? ? ? ? ? ? ? ? --> uart_console write
>>>
>>> Use RPM_SUSPENDING check to avoid below scenario during bootup
>>> As during bootup console_lock is not available.
>>> ? ? ? ?--> uart_add_one_port
>>> ? ? ? ? ? ?--> console_register
>>> ? ? ? ? ? ? ? ?--> console_lock
>>> ? ? ? ? ? ? ? ? --> console_unlock
>>> ? ? ? ? ? ? ? ? ? ? ?--> call_console_drivers (here yet console_lock is not released)
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? --> uart_console_write
>>>
>>> Acked-by: Alan Cox <alan@linux.intel.com>
>>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> ---
>>> ?drivers/tty/serial/omap-serial.c | ? 20 +++++++++++++++++++-
>>> ?1 files changed, 19 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>>> index 897416f..ee94291 100644
>>> --- a/drivers/tty/serial/omap-serial.c
>>> +++ b/drivers/tty/serial/omap-serial.c
>>> @@ -1008,7 +1008,22 @@ serial_omap_console_write(struct console *co, const char *s,
>>> ? ? ? struct uart_omap_port *up = serial_omap_console_ports[co->index];
>>> ? ? ? unsigned long flags;
>>> ? ? ? unsigned int ier;
>>> - ? ? int locked = 1;
>>> + ? ? int console_lock = 0, locked = 1;
>>> +
>>> + ? ? if (console_trylock())
>>> + ? ? ? ? ? ? console_lock = 1;
>>
>> So now we take the console lock on *every* console write? ?Even if the
>> device is not about to be idled? ? This is rather over-protective, don't
>> you think?
>>
>
> This scenario is because of print from
> omap_uart_console_write --> get_sync --> omap_enable_enable
> trying to print worst activate or deactivate latency some times.
>
> will result in recursive print scenario.
>
> holding console lock will only ensure that the print from get_sync gets
> logged to be printed later to console.

Yes, but my problem is you now hold a lock for *every* console write,
even when the UART is not in the process of being enabled/disabled.

The point is that it should only be held when you're about to disable
the UART (or you know it's already disabled), and the point where you
know this is exactly at the .runtime_suspend callback.

>>> + ? ? /*
>>> + ? ? ?* If console_lock is not available and we are in suspending
>>> + ? ? ?* state then we can avoid the console usage scenario
>>
>> s/in suspending state/runtime suspending/
>
> ok.
>
>>
>>> + ? ? ?* as this may introduce recursive prints.
>>> + ? ? ?* Basically this scenario occurs during boot while
>>> + ? ? ?* printing debug bootlogs.
>>
>> The exact scenario for triggering this still not well described, and
>> thus still I don't get it.
>>
>
> scenario is same as said above.

Which as I said, is not well described.

> omap_uart_console_write --> get_sync --> omap_device
>
> printk worst activate latency calls omap_uart_console write.
>
> after boot up we have access to console lock,
> but during boot up we don't have console lock available
> and results in printk recursiveness.

Then leave UART runtime PM disabled during bootup.

>> I still don't fully understand this problem,
>
> basically its due to recursive printk during bootup
> and also after bootup as said above.

You've said all of these things, but are mixing them together in a way
that is very difficult to understand.

Please separate out the boot-up problem from the recursive write problem
and make 2 separate patches with two separate descriptive changelogs for
them.

>> but if it's isolated to
>> runtime suspending, maybe you need a console lock in the runtime_suspend
>> path (like you already have in the static suspend path.)
>
> console_lock in runtime_suspend will not help
> during bootup 

I understand it wont help when the console lock has not been
initialized, and this is a separate problem (and needs a separate fix),
but...

> and due to printk emerging out from omap_device enable after system
> bootup.

Why doesn't a printk after an omap_device *enable* work?  The UART
should be enabled by that point.
 
In any case, the omap_device_enable is the result of a runtime PM
request, so the locking for this problem should be handled in the
runtime PM callbacks.

>
>>
>>> + ? ? ?*/
>>> +
>>> + ? ? if (!console_lock &&
>>> + ? ? ? ? ? ? up->pdev->dev.power.runtime_status == RPM_SUSPENDING)
>>> + ? ? ? ? ? ? return;
>>
>> Assuming this was a printk, it's now lost, right? ? Not sure that's an
>> acceptable solution.
>>
>
> AFAIK it gets logged prints later.

How will it get written later?  There is no return value to this
function, so he caller can't know if it has succeeded or failed, so it
obviously assumes that the data was written to the UART.

> to summarize holding console lock helps after bootup
> since during boot up console lock is not available need to use
> above runtime_status check.

The point is you've fixed a small problem with a very big-hammer
solution.

The problem you have occurs because of two different causes that need
two different well-targeted solutions.

Kevin
