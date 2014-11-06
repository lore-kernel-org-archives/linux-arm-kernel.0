From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Nov 2014 21:38:26 +0100
Subject: (bisected) Lock up on sh73a0/kzm9g on cpuidle initialization
Message-ID: <CAMuHMdXaaa2t6+sH2egGacVxkAPeTUkAgwdYsOnMnEPnuLdB5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_CPU_IDLE=y, the kernel locks up during cpuidle initialization
on Renesas sh73a0/kzm9g-reference, which has a dual-core Cortex-A9.

Last message is:

    DMA: preallocated 256 KiB pool for atomic coherent allocations

After this it's supposed to print:

    cpuidle: using governor ladder
    cpuidle: using governor menu

I've bisected this to commit 442bf3aaf55a91ebfec71da46a4ee10a3c905bcc
("sched: Let the scheduler see CPU idle states").

Reverting that commit, and commit 83a0a96a5f26d974580fd7251043ff70c8f1823d
("sched/fair: Leverage the idle state info when choosing the "idlest"
cpu") which
depends on it, fixes the problem.

I saw the discussion "lockdep splat in CPU hotplug", so I enabled lockdep
debugging, but didn't see a lockdep splat.

I'm using CONFIG_TREE_RCU=y, as this is SMP without PREEMPT.

Anyone with a clue?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
