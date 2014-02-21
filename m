From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 21 Feb 2014 14:39:51 +0000
Subject: [PATCH] arm/arm64: KVM: detect CPU reset on CPU_PM_EXIT
In-Reply-To: <53073696.5080005@arm.com>
References: <1392910014-15495-1-git-send-email-marc.zyngier@arm.com>
 <20140220233543.1836e2d5@slackpad> <53073696.5080005@arm.com>
Message-ID: <20140221143951.GA6315@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 11:20:54AM +0000, Marc Zyngier wrote:
> On 20/02/14 22:35, Andre Przywara wrote:
> > On Thu, 20 Feb 2014 15:26:54 +0000
> > Marc Zyngier <marc.zyngier@arm.com> wrote:
> > 
> >> Commit 1fcf7ce0c602 (arm: kvm: implement CPU PM notifier) added
> >> support for CPU power-management, using a cpu_nofigier to re-init
> >> KVM on a CPU that entered CPU idle.
> >>
> >> The code assumed that a CPU entering idle would actually be powered
> >> off, loosing its state entierely, and would then need to be
> >> reinitialized. It turns out that this is not always the case, and
> >> some HW performs CPU PM without actually killing the core. In this
> >> case, we try to reinitialize KVM while it still live. It ends up
> >> badly, as reported by Andre Przywara (using a Calxeda Midway):
> >>
> >> [    3.663897] Kernel panic - not syncing: unexpected prefetch abort
> >> in Hyp mode at: 0x685760 [    3.663897] unexpected data abort in Hyp
> >> mode at: 0xc067d150 [    3.663897] unexpected HVC/SVC trap in Hyp
> >> mode at: 0xc0901dd0
> >>
> >> The trick here is to detect if we've been through a full re-init or
> >> not by looking at HVBAR (VBAR_EL2 on arm64). This involves
> >> implementing the backend for __hyp_get_vectors in the main KVM HYP
> >> code (rather small), and checking the return value against the
> >> default one when the CPU notifier is called on CPU_PM_EXIT.
> >>
> >> Reported-by: Andre Przywara <osp@andrep.de>
> >> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Cc: Rob Herring <rob.herring@linaro.org>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Tested-by: Andre Przywara <osp@andrep.de>
> 
> Thanks!
> 
> > (there seems to be a typo in the second line of the commit message)
> 
> Ah, good katsh! ;-)
> 
> > Marc,
> > 
> > thanks a lot for this quick and perfectly working patch! I still
> > believe it is actually the firmware that needs to be fixed, but this is
> > rather unlikely in this special case ...
> 
> Well, that is completely debatable. This is a valid (if minimal)
> implementation of cpu idle, and the KVM code *must* be robust enough to
> deal with that kind of implementation.

I definitely agree with Marc, and thanks for the fix.

I have to say though, off-topic, that having a C-state that just calls
PSCI to do wfi is not ideal (since it is called from cpu_suspend, which
expects the CPU to lose context), since CPU enters that state by saving
context and flushing L1 just to execute wfi. Power down can fail in
general, and that's why this patch makes perfect sense, the question is
why should we leave a C-state in the Calxeda idle driver that just cripples
performance and burns more power instead of saving it.

At least for testing and doing KVM development you should disable the
PSCI based C-state.

Lorenzo
