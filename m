From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 6 Oct 2015 20:03:43 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <55559D55.6020703@aksignal.cz>
References: <55559D55.6020703@aksignal.cz>
Message-ID: <20151006180342.GA13434@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ji??,

On Fri, May 15, 2015 at 09:16:37AM +0200, Ji?? Prchal wrote:
> Hi all,
> I'm trying to discover what's wrong with watchdog on my board. I didn't find
> anything about it on internet so I would ask you for help.
> I have a board with sam9g25 and slow clock xtal 32768Hz with 10p capacitors
> to GND. Frequency seems to be good since hwclock (RTC) runs pretty precisely
> powered from backup and main power too (no NTP). But watchdog time to reset
> is still 61s regardless default (16s) or 4s heartbeat setting. No change to
> WDT_MR in bootstrap, so in Linux should work.

I'm a bit late here but it looks like there is a misunderstanding about 
the watchdog stack involved here:

userland
------- /dev/watchdog0 ------
watchdog0
  -> userland wanted reset time value
  -> userland wanted ping time value
------- internal kernel watchdog interface ------
atmel,at91sam9260-wdt
  -> atmel,min-heartbeat-sec
  -> atmel,max-heartbeat-sec

watchdog0 is the software interface, controlled by your userland, is it 
always on top of the hardware watchdog and it calls the watchdog_ops 
hooks, like watchdog_ops->start(), watchdog_ops->stop(), or 
watchdog_ops->set_timeout() for this driver depending on the userland 
willingness to (re)start, stop the watchdog or change the hardware 
timeout value.

watchdog0 have two configurable values, reset time and ping time, the 
default is 60s for timeout and 30s for ping (the 61s you are 
seeing is the default timeout value).

For example, the watchdog binary from BusyBox allows you to set the 
watchdog0 reset and ping time using -T and -t arguments:
    -T N    Reboot after N seconds if not reset (default 60)
    -t N    Reset every N seconds (default 30)

The -T value is sent to the hardware driver using the 
watchdog_ops->set_timeout() hook. The -t value is how often you want the 
watchdog to be (re)started using the watchdog_ops->start() hook.

In a perfect world, the watchdog_ops->set_timeout() hook should be able 
to precisely set the hardware timeout you want, but there is two 
problems here:

  - 60 secs timeout is more than supported by this hardware watchdog, 
which have a maximum timeout value of 16 secs. The driver is able to 
return to userland that wanted values are not acceptable, but it would 
means the default watchdog values wouldn't work.

  - This hardware watchdog is a bit special: its period cannot be 
changed once started, usually the hardware timeout follows the watchdog0 
timeout value wanted by userspace but that's not possible here. That's 
why this driver is using its own heartbeat software timer to reset the 
hardware watchdog more often than actually asked by userland. Thus, 
because we are resetting on your own the hardware watchdog it means that 
once the software watchdog embedded into this driver expire there is 
still the hardware watchdog to expire.

We try to reset the watchdog counter 4 or 2 times more often than 
actually requested, in order to avoid spurious watchdog reset. For the 4 
times case (the default), we get a hardware timeout between 12 and 16 
secs.

Conclusion, if you want a fast reset, you have to use a lower 
atmel,max-heartbeat-sec value as well as using low values for the 
timeouts values passed to kernel through the watchdog interface 
"watchdog -T -t".

I wonder if we should substract from the watchdog_ops->set_timeout() 
new_timeout argument value the previously set hardware timeout period, 
this way we would have a "60 - 16 + 12~16" instead of a "60 + 12~16" 
watchdog timeout. If someone agree I will propose a patch to do that.


> / # killall watchdog
> [ 1821.114114] watchdog watchdog0: nowayout prevents watchdog being stopped!
> [ 1821.123123] watchdog watchdog0: watchdog did not stop!

60 seconds software timeout, this is the default set by userland tools.

> [ 1882.294294] at91sam9_wdt: I will reset your machine !

Then 12 to 16 seconds timeout, this is the hardware timeout.


Sylvain
