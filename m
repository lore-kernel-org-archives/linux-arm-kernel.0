From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 30 Jan 2015 18:38:58 +0100
Subject: [PATCH v3 1/1] arm64: kernel: remove ARM64_CPU_SUSPEND config
 option
In-Reply-To: <20150130170118.GA11122@red-moon>
References: <1422297224-27834-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1598265.lHdhMYsZXo@amdc1032> <20150130170118.GA11122@red-moon>
Message-ID: <1431736.neD4SrGVzg@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 30, 2015 05:01:18 PM Lorenzo Pieralisi wrote:
> On Fri, Jan 30, 2015 at 04:18:27PM +0000, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Monday, January 26, 2015 06:33:44 PM Lorenzo Pieralisi wrote:
> > > ARM64_CPU_SUSPEND config option was introduced to make code providing
> > > context save/restore selectable only on platforms requiring power
> > > management capabilities.
> > >
> > > Currently ARM64_CPU_SUSPEND depends on the PM_SLEEP config option which
> > > in turn is set by the SUSPEND config option.
> > >
> > > The introduction of CPU_IDLE for arm64 requires that code configured
> > > by ARM64_CPU_SUSPEND (context save/restore) should be compiled in
> > > in order to enable the CPU idle driver to rely on CPU operations
> > > carrying out context save/restore.
> > >
> > > The ARM64_CPUIDLE config option (ARM64 generic idle driver) is therefore
> > > forced to select ARM64_CPU_SUSPEND, even if there may be (ie PM_SLEEP)
> > > failed dependencies, which is not a clean way of handling the kernel
> > > configuration option.
> > >
> > > For these reasons, this patch removes the ARM64_CPU_SUSPEND config option
> > > and makes the context save/restore dependent on CPU_PM, which is selected
> > > whenever either SUSPEND or CPU_IDLE are configured, cleaning up dependencies
> > > in the process.
> > >
> > > This way, code previously configured through ARM64_CPU_SUSPEND is
> > > compiled in whenever a power management subsystem requires it to be
> > > present in the kernel (SUSPEND || CPU_IDLE), which is the behaviour
> > > expected on ARM64 kernels.
> > >
> > > The cpu_suspend and cpu_init_idle CPU operations are added only if
> > > CPU_IDLE is selected, since they are CPU_IDLE specific methods and
> > > should be grouped and defined accordingly.
> > >
> > > PSCI CPU operations are updated to reflect the introduced changes.
> > 
> > cpu_suspend CPU operation is currently CPU_IDLE specific but I wonder
> > whether this is correct in the context of PSCI?
> 
> On arm64 cpu_suspend() is the function interfacing the idle driver to
> the arch code, I will rename it in a subsequent clean-up that will
> include cpu_ops.cpu_suspend too (ie cpu_enter_idle).
> 
> PSCI implements the cpu_ops.cpu_suspend operation through the PSCI CPU
> suspend call.
> 
> > 
> > [ On 32-bit ARM PSCI cpu_suspend operation can be used in suspend code-path
> >   (please take a look at arch/arm/mach-highbank/pm.c), on 64-bit ARM PSCI
> >   this is not possible currently. ]
> 
> I did not merge that code, and in that context PSCI CPU suspend has been
> used to enter what I guess what the deepest idle state, it slipped my
> review, it is a valid usage, should have been documented though before
> implementing it that way.
> 
> On arm64 we are defining a specific system suspend interface to give
> system suspend a clearer semantics:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318540.html
> 
> Does this answer your question ?

Yes.  Thank you!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
