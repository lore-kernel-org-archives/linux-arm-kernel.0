From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Sep 2017 15:44:42 +0100
Subject: Alignment crashes debugging?
In-Reply-To: <CAH9_wRMrkhU2y3qYZSoswe9CRUeCw6K6xweKn3ejz0fLAyCnAw@mail.gmail.com>
References: <CAH9_wRMrkhU2y3qYZSoswe9CRUeCw6K6xweKn3ejz0fLAyCnAw@mail.gmail.com>
Message-ID: <20170918144442.GH20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 08:08:43PM +0530, Sriram V wrote:
> [147278.696759] Alignment trap: not handling instruction e1901f9f at [<c010ad10>]

Quite a right objection by the kernel...

> [147278.714884] Unhandled fault: alignment exception (0x001) at 0xffffff7f
> [147278.725921] Internal error: : 1 [#1] PREEMPT SMP ARM
> [147278.731321] Modules linked in: omaplfb(O) pvrsrvkm(O)
> pruss_remoteproc remoteproc virtio virtio_ring
> [147278.741197] CPU: 0 PID: 21706 Comm: zygote Tainted: G           O 3.12.20+ #1
> [147278.748893] task: ea86ebc0 ti: ec6cc000 task.ti: ec6cc000
> [147278.754749] PC is at __destroy_inode+0xfc/0x14c
> [147278.759676] LR is at _raw_spin_unlock+0x30/0x50
> [147278.764596] pc : [<c010ad14>]    lr : [<c06d8918>]    psr: a00f0013
> [147278.764596] sp : ec6cdd40  ip : ec6cdcf0  fp : ec6cdd54
> [147278.777007] r10: dc0e77e0  r9 : e13b0c90  r8 : dc0e7778
> [147278.782663] r7 : c06ed8f4  r6 : c06ed8f4  r5 : ece67b80  r4 : ece67b28
> [147278.789705] r3 : 00000000  r2 : ec6cdcf0  r1 : 00000000  r0 : ffffff7f
>...
> [147279.166953] Code: 0affffdf e3a03000 ee073fba e1901f9f (e2411001)

   0:   0affffdf        beq     0xffffff84
   4:   e3a03000        mov     r3, #0
   8:   ee073fba        mcr     15, 0, r3, cr7, cr10, {5}
   c:   e1901f9f        ldrex   r1, [r0]		; <=====
  10:   e2411001        sub     r1, r1, #1

As we can see, r0 is 0xffffff7f, which is definitely incorrect.

Does this happen if you omit loading the out-of-tree modules?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
