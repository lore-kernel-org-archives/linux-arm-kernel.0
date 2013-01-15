From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 15 Jan 2013 11:00:44 +0800
Subject: [PATCH V2 2/6] ARM: tegra20: cpuidle: add powered-down state
 for secondary CPU
In-Reply-To: <20130111122417.GE30538@e102568-lin.cambridge.arm.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
 <1354701715-24150-3-git-send-email-josephl@nvidia.com>
 <20121205105010.GA12999@e102568-lin.cambridge.arm.com>
 <1357888829.2034.39.camel@jlo-ubuntu-64.nvidia.com>
 <20130111122417.GE30538@e102568-lin.cambridge.arm.com>
Message-ID: <1358218844.8513.30.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-11 at 20:24 +0800, Lorenzo Pieralisi wrote:
> On Fri, Jan 11, 2013 at 07:20:29AM +0000, Joseph Lo wrote:
> > On Wed, 2012-12-05 at 18:50 +0800, Lorenzo Pieralisi wrote:
> > > On Wed, Dec 05, 2012 at 10:01:49AM +0000, Joseph Lo wrote:
> > > > The powered-down state of Tegra20 requires power gating both CPU cores.
> > > > When the secondary CPU requests to enter powered-down state, it saves
> > > > its own contexts and then enters WFI. The Tegra20 had a limition to
> > > > power down both CPU cores. The secondary CPU must waits for CPU0 in
> > > > powered-down state too. If the secondary CPU be woken up before CPU0
> > > > entering powered-down state, then it needs to restore its CPU states
> > > > and waits for next chance.
> > > >
> > > > Be aware of that, you may see the legacy power state "LP2" in the code
> > > > which is exactly the same meaning of "CPU power down".
> > > >
> > > > Based on the work by:
> > > > Colin Cross <ccross@android.com>
> > > > Gary King <gking@nvidia.com>
> > > >
> > > > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > > > +
> > > > +#ifdef CONFIG_PM_SLEEP
> > > > +/*
> > > > + * tegra_pen_lock
> > > > + *
> > > > + * spinlock implementation with no atomic test-and-set and no coherence
> > > > + * using Peterson's algorithm on strongly-ordered registers
> > > > + * used to synchronize a cpu waking up from wfi with entering lp2 on idle
> > > > + *
> > > > + * SCRATCH37 = r1 = !turn (inverted from Peterson's algorithm)
> > > > + * on cpu 0:
> > > > + * SCRATCH38 = r2 = flag[0]
> > > > + * SCRATCH39 = r3 = flag[1]
> > > > + * on cpu1:
> > > > + * SCRATCH39 = r2 = flag[1]
> > > > + * SCRATCH38 = r3 = flag[0]
> > > > + *
> > > > + * must be called with MMU on
> > > > + * corrupts r0-r3, r12
> > > > + */
> > > > +ENTRY(tegra_pen_lock)
> > > > +       mov32   r3, TEGRA_PMC_VIRT
> > > > +       cpu_id  r0
> > > > +       add     r1, r3, #PMC_SCRATCH37
> > > > +       cmp     r0, #0
> > > > +       addeq   r2, r3, #PMC_SCRATCH38
> > > > +       addeq   r3, r3, #PMC_SCRATCH39
> > > > +       addne   r2, r3, #PMC_SCRATCH39
> > > > +       addne   r3, r3, #PMC_SCRATCH38
> > > > +
> > > > +       mov     r12, #1
> > > > +       str     r12, [r2]               @ flag[cpu] = 1
> > > > +       dsb
> > > > +       str     r12, [r1]               @ !turn = cpu
> > > > +1:     dsb
> > > > +       ldr     r12, [r3]
> > > > +       cmp     r12, #1                 @ flag[!cpu] == 1?
> > > > +       ldreq   r12, [r1]
> > > > +       cmpeq   r12, r0                 @ !turn == cpu?
> > > > +       beq     1b                      @ while !turn == cpu && flag[!cpu] == 1
> > > > +
> > > > +       mov     pc, lr                  @ locked
> > > > +ENDPROC(tegra_pen_lock)
> > > > +
> > > > +ENTRY(tegra_pen_unlock)
> > > > +       dsb
> > > > +       mov32   r3, TEGRA_PMC_VIRT
> > > > +       cpu_id  r0
> > > > +       cmp     r0, #0
> > > > +       addeq   r2, r3, #PMC_SCRATCH38
> > > > +       addne   r2, r3, #PMC_SCRATCH39
> > > > +       mov     r12, #0
> > > > +       str     r12, [r2]
> > > > +       mov     pc, lr
> > > > +ENDPROC(tegra_pen_unlock)
> > > 
> > > There is an ongoing work to make this locking scheme for MMU/coherency off
> > > paths ARM generic, and we do not want to merge yet another platform specific
> > > locking mechanism. I will point you to the patchset when it hits LAK.
> > > 
> > 
> > You did mention there is an ARM generic locking scheme for MMU/coherency
> > off case before. Do you mean the patch below?
> > 
> > https://patchwork.kernel.org/patch/1957911/
> > https://patchwork.kernel.org/patch/1957901/
> 
> Those are used for first-man election when multiple CPUs come out of
> idle at once.
> 
> You should have a look at the entire series and in particular:
> 
> https://patchwork.kernel.org/patch/1957891/
> https://patchwork.kernel.org/patch/1957951/
> 
> > I gave it a review today. Looks it can't fit our usage for CPU idle
> > powered-down mode on Tegra20.
> > 
> > The generic mechanism only can be used when CPUs in non coherent world.
> > But our usage needs the mechanism could be used in both coherent and non
> > coherent case. OK. The case is we need to sync the status about the CPU1
> > was ready to power down. In this case, the CPU0 is still in coherent
> > world but the CPU1 isn't. So we need the locking scheme could be still
> > safe in this situation.
> 
> I know, I implemented something of that sort for an A9 based development
> platform, that's why I pointed you to this new patchset.
> 
> Have a look at the series, it should do what you want.
> 
Hi Lorenzo,

May I upstream this stuff first? I can promise to you I will re-work a
common CPUs and cluster power sync wrappers (platform_power_ops) for all
Tegra series that based on the generic framework. Because we didn't have
this work in Tegra tree yet and we indeed need it for supporting cluster
power down and switching.

But it need lots of time for re-work, testing and verification. And I
have lots of patches that need the function of cpu suspend that be
introduced in this patch series to support platform suspend for Tegra.

So I am asking the permission here for upstream this series first and I
will continue the job to come out a common CPUs and cluster power sync
wrappers for Tegra that we indeed need it to support cluster power down
and switching.

Thanks,
Joseph
