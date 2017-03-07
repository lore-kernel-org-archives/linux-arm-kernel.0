From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 7 Mar 2017 18:29:41 +0100
Subject: Warning on boot on SAMA5D2 with Linux 4.11-rc1
In-Reply-To: <faca2b81-c43d-e6da-701c-903a7157c73f@sysgo.com>
References: <CAGkQfmPP7w09xutsK5OhfWzNfCyC3Bj8VmoFxDiB5eqAFnZBbQ@mail.gmail.com>
 <CAGkQfmMxame-m+Te59EnFACqmk9TU-3Mhi6BctQWDPKuy38FXg@mail.gmail.com>
 <faca2b81-c43d-e6da-701c-903a7157c73f@sysgo.com>
Message-ID: <20170307182941.3536de7d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David, Romain,

On Tue, 7 Mar 2017 16:17:03 +0100
David Engraf <david.engraf@sysgo.com> wrote:

> Am 07.03.2017 um 16:05 schrieb Romain Izard:
> > 2017-03-06 12:28 GMT+01:00 Romain Izard <romain.izard.pro@gmail.com>:  
> >>
> >> While looking for another issue, I tried Linux 4.11-rc1 on a SAMA5D2 Xplained
> >> board. The boot log contains the following warning:
> >>
> >> [    0.100000] ------------[ cut here ]------------
> >> [    0.100000] WARNING: CPU: 0 PID: 1 at
> >> ../kernel/time/sched_clock.c:180 sched_clock_register+0x44/0x1e4
> >> [    0.100000] CPU: 0 PID: 1 Comm: swapper Not tainted 4.11.0-rc1+ #3
> >> [    0.100000] Hardware name: Atmel SAMA5
> >> [    0.100000] [<c010c494>] (unwind_backtrace) from [<c010a558>]
> >> (show_stack+0x10/0x14)
> >> [    0.100000] [<c010a558>] (show_stack) from [<c0115654>] (__warn+0xe0/0xf8)
> >> [    0.100000] [<c0115654>] (__warn) from [<c011571c>]
> >> (warn_slowpath_null+0x20/0x28)
> >> [    0.100000] [<c011571c>] (warn_slowpath_null) from [<c090b0d0>]
> >> (sched_clock_register+0x44/0x1e4)
> >> [    0.100000] [<c090b0d0>] (sched_clock_register) from [<c091fb98>]
> >> (tcb_clksrc_init+0x1ac/0x360)
> >> [    0.100000] [<c091fb98>] (tcb_clksrc_init) from [<c0900d8c>]
> >> (do_one_initcall+0xb4/0x15c)
> >> [    0.100000] [<c0900d8c>] (do_one_initcall) from [<c0900f68>]
> >> (kernel_init_freeable+0x134/0x1c4)
> >> [    0.100000] [<c0900f68>] (kernel_init_freeable) from [<c06bfc64>]
> >> (kernel_init+0x8/0x10c)
> >> [    0.100000] [<c06bfc64>] (kernel_init) from [<c0107318>]
> >> (ret_from_fork+0x14/0x3c)
> >> [    0.100000] ---[ end trace 7ce9be9d7cf6f800 ]---
> >> [    0.100012] sched_clock: 32 bits at 10MHz, resolution 96ns, wraps
> >> every 206986376143ns
> >>
> >> This is related to the following commit:
> >> 7b9f1d16e6d1 clocksource/drivers/tcb_clksrc: Use 32 bit tcb as sched_clock
> >>
> >> When we call sched_clock_register from tcb_clksrc_init from
> >> arch_initcall, we are too late as sched expects all the candidates for
> >> its clock to be registered before interrupts are enabled. This warning
> >> does not prevent the tcb clock from being used.  
> 
> I have no idea why sched_clock_register complains when interrupts are 
> already enabled. Form the code it doesn't look like this is a real issue 
> and it works for me.
> 
> > After some more use with 4.11-rc1, I also noticed that the timestamp for
> > printk rolls over to 0 after only 413s. Reverting the aforementioned commit
> > fixes it.  
> 
> I had this issue as well so I proposed the following patch a few weeks ago.

I think both issues are related: the scheduler expect the sched clock to
registered before the sched_clock_postinit() exactly to prevent the
case you're describing below.

I'd recommend that we revert 7b9f1d16e6d1
("clocksource/drivers/tcb_clksrc: Use 32 bit tcb as sched_clock")
until we have a clean solution to update sched clock at runtime (if we
ever want to support that).

Note that Alexandre posted a patch series to let the tcb_clksource
register itself earlier in the boot [1], which should prevent the
problem we have here.

Regards,

Boris

[1]http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/435532.html

> 
> -------- Forwarded Message --------
> Betreff: [PATCH resend] timers, sched_clock: Update timeout for clock wrap
> Datum: Thu,  2 Mar 2017 10:02:16 +0100
> Von: David Engraf <david.engraf@sysgo.com>
> An: tglx at linutronix.de, john.stultz at linaro.org
> Kopie (CC): linux-kernel at vger.kernel.org, David Engraf 
> <david.engraf@sysgo.com>
> 
> The scheduler clock framework may not use the correct timeout for the clock
> wrap. This happens when a new clock driver calls sched_clock_register()
> after the kernel called sched_clock_postinit(). In this case the clock wrap
> timeout is too long thus sched_clock_poll() is called too late and the clock
> already wrapped.
> 
> On my ARM system the scheduler was no longer scheduling any other task than
> the idle task because the sched_clock() wrapped.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> ---
>   kernel/time/sched_clock.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index a26036d..382b159 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -205,6 +205,11 @@ sched_clock_register(u64 (*read)(void), int bits, 
> unsigned long rate)
>    	update_clock_read_data(&rd);
>   +	if (sched_clock_timer.function != NULL) {
> +		/* update timeout for clock wrap */
> +		hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
> +	}
> +
>   	r = rate;
>   	if (r >= 4000000) {
>   		r /= 1000000;
