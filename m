From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Dec 2015 13:18:34 +0100
Subject: [PATCH tip/core/rcu 8/9] arm: Use common outgoing-CPU-notification
 code
In-Reply-To: <1431467407-1223-8-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20150512214945.GA813@linux.vnet.ibm.com>
 <1431467407-1223-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1431467407-1223-8-git-send-email-paulmck@linux.vnet.ibm.com>
Message-ID: <CAMuHMdXuAQnmGo=a0fa1qJNG6szF4-UGpcmCJOfwqyKhHaNN6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tue, May 12, 2015 at 11:50 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>
> This commit removes the open-coded CPU-offline notification with new
> common code.  In particular, this change avoids calling scheduler code
> using RCU from an offline CPU that RCU is ignoring.  This is a minimal
> change.  A more intrusive change might invoke the cpu_check_up_prepare()
> and cpu_set_state_online() functions at CPU-online time, which would
> allow onlining throw an error if the CPU did not go offline properly.
>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Russell King <linux@arm.linux.org.uk>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, this seems to fix the intermittent "suspicious RCU usage" warnings I've
been seeing during suspend to RAM on r8a7791/koelsch, which has a dual-core
Cortex A15:

    Disabling non-boot CPUs ...

    ===============================
    [ INFO: suspicious RCU usage. ]
    4.4.0-rc4-koelsch #2123 Tainted: G        W
    -------------------------------
    kernel/sched/fair.c:4938 suspicious rcu_dereference_check() usage!

    other info that might help us debug this:

    RCU used illegally from offline CPU!
    rcu_scheduler_active = 1, debug_locks = 0
    3 locks held by swapper/1/0:
     #0:  ((cpu_died).wait.lock){......}, at: [<c006077c>] complete+0x14/0x44
     #1:  (&p->pi_lock){-.-.-.}, at: [<c004b8a8>] try_to_wake_up+0x24/0x340
     #2:  (rcu_read_lock){......}, at: [<c0052740>]
select_task_rq_fair+0xb4/0x820

    stack backtrace:
    CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
4.4.0-rc4-koelsch #2123
    Hardware name: Generic R8A7791 (Flattened Device Tree)
    [<c0017390>] (unwind_backtrace) from [<c0013094>] (show_stack+0x10/0x14)
    [<c0013094>] (show_stack) from [<c01ee718>] (dump_stack+0x70/0x8c)
    [<c01ee718>] (dump_stack) from [<c0052810>]
(select_task_rq_fair+0x184/0x820)
    [<c0052810>] (select_task_rq_fair) from [<c004ba54>]
(try_to_wake_up+0x1d0/0x340)
    [<c004ba54>] (try_to_wake_up) from [<c0060070>] (__wake_up_common+0x4c/0x78)
    [<c0060070>] (__wake_up_common) from [<c00600ac>]
(__wake_up_locked+0x10/0x18)
    [<c00600ac>] (__wake_up_locked) from [<c006079c>] (complete+0x34/0x44)
    [<c006079c>] (complete) from [<c00159f8>] (arch_cpu_idle_dead+0x2c/0x8c)
    [<c00159f8>] (arch_cpu_idle_dead) from [<c0060a24>]
(cpu_startup_entry+0x84/0x228)
    [<c0060a24>] (cpu_startup_entry) from [<4000a4ac>] (0x4000a4ac)
    CPU1: shutdown

But I understand from the various other threads about this issue that this
patch is not going upstream, as it papers over the real issue?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
