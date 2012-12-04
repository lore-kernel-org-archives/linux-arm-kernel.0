From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Dec 2012 15:05:12 +0800
Subject: [PATCH 1/5] ARM: tegra20: cpuidle: add powered-down state for
 secondary CPU
In-Reply-To: <50BCF01E.4070504@wwwdotorg.org>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-2-git-send-email-josephl@nvidia.com>
 <50BCF01E.4070504@wwwdotorg.org>
Message-ID: <1354604712.30563.31.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-04 at 02:31 +0800, Stephen Warren wrote:
> On 12/02/2012 08:00 PM, Joseph Lo wrote:
> > The powered-down state of Tegra20 requires power gating both CPU cores.
> > When the secondary CPU requests to enter powered-down state, it saves
> > its own contexts and then enters WFI. The Tegra20 had a limition to
> > power down both CPU cores. The secondary CPU must waits for CPU0 in
> > powered-down state too. If the secondary CPU be woken up before CPU0
> > entering powered-down state, then it needs to restore its CPU states
> > and waits for next chance.
> > 
> > Be aware of that, you may see the legacy power state "LP2" in the code
> > which is exactly the same meaning of "CPU power down".
> 
> > diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
> 
> > +/*
> > + * tegra_pen_lock
> > + *
> > + * spinlock implementation with no atomic test-and-set and no coherence
> > + * using Peterson's algorithm on strongly-ordered registers
> > + * used to synchronize a cpu waking up from wfi with entering lp2 on idle
> > + *
> > + * SCRATCH37 = r1 = !turn (inverted from Peterson's algorithm)
> 
> A link to a description of that algorithm would be useful.
> 
This algorithm was very famous. It can be very easy to find on the
internet. But if you want the link of the paper, it may not be
available. It usually need to access the paper as a member.

Can you accept a link from wikipedia?
http://en.wikipedia.org/wiki/Peterson's_algorithm#cite_ref-1

> > + * on cpu 0:
> > + * SCRATCH38 = r2 = flag[0]
> > + * SCRATCH39 = r3 = flag[1]
> > + * on cpu1:
> > + * SCRATCH39 = r2 = flag[1]
> > + * SCRATCH38 = r3 = flag[0]
> 
> That implies that r2/r3 are used for different purposes on the 2 CPUs,
> and/or shadow the values of different registers. However, I see nothing
> in the code which is conditional on cpu ID.

here:
+       cpu_id  r0
+       add     r1, r3, #PMC_SCRATCH37
+       cmp     r0, #0
+       addeq   r2, r3, #PMC_SCRATCH38
+       addeq   r3, r3, #PMC_SCRATCH39
+       addne   r2, r3, #PMC_SCRATCH39
+       addne   r3, r3, #PMC_SCRATCH38
It's proper to say that the SCRATCH38/SCRATCH39 are used for dedicate
cpu lock flag on the 2 CPUs.

Thanks,
Joseph
