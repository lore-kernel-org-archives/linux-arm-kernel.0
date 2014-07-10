From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Jul 2014 23:08:01 +0100
Subject: dove (marvell A510) crash on boot with config_preempt
In-Reply-To: <20140706080845.723e9787@armhf>
References: <20140706080845.723e9787@armhf>
Message-ID: <20140710220801.GX21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 06, 2014 at 08:08:45AM +0200, Jean-Francois Moine wrote:
> Since the official 3.15.0 release, the kernel crashes at boot time
> when compiled with the option CONFIG_PREEMPT.
> 
> Reverting the commit 431a84b1a4f7d1a0085d5b91330c5053cc8e8b12
> 
>    ARM: 8034/1: Disable preemption in iwmmxt_task_enable()
> 
> removes the problem.

Yes, and it opens problems if you then have preempt enabled - so if
you revert this, disable preemption, or don't use iwmmxt at all.

Catalin, your patch is broken - you're modifying nicocode, which
means you have to expect the unexpected, because it will be highly
optimised and do things that you don't expect:

ENTRY(iwmmxt_task_enable)
        inc_preempt_count r10, r3
...
concan_save:
...
concan_dump:
...
concan_load:
...
3:
#ifdef CONFIG_PREEMPT_COUNT
        get_thread_info r10
#endif
4:      dec_preempt_count r10, r3
        ret     lr

This looks correct until you realise that those concan symbols are
entry points to the above code - for instance, the below calls
concan_dump as if it was its own stand-alone function (but it isn't):

ENTRY(iwmmxt_task_copy)

        mrs     ip, cpsr
        orr     r2, ip, #PSR_I_BIT              @ disable interrupts
        msr     cpsr_c, r2
...
        mov     r3, lr                          @ preserve return address
        bl      concan_dump
        msr     cpsr_c, ip                      @ restore interrupt mode
        ret     r3

Both iwmmxt_task_disable and iwmmxt_task_restore does similar with the
other concan symbols.

What this means is that you can't drop the preemption increment/decrement
into iwmmxt_task_enable in this way - it's not entirely a stand-alone
function.

It may be better to modify iwmmxt_task_enable() to call concan_save
in the same way that the other concan_* symbols are used, and then
undo the preempt count thing when that returns.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
