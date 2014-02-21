From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 20 Feb 2014 17:24:48 -0800
Subject: [PATCH] arm/arm64: KVM: detect CPU reset on CPU_PM_EXIT
In-Reply-To: <20140220233543.1836e2d5@slackpad>
References: <1392910014-15495-1-git-send-email-marc.zyngier@arm.com>
 <20140220233543.1836e2d5@slackpad>
Message-ID: <20140221012448.GC27393@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 11:35:43PM +0100, Andre Przywara wrote:
> On Thu, 20 Feb 2014 15:26:54 +0000
> Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> > Commit 1fcf7ce0c602 (arm: kvm: implement CPU PM notifier) added
> > support for CPU power-management, using a cpu_nofigier to re-init
> > KVM on a CPU that entered CPU idle.
> > 
> > The code assumed that a CPU entering idle would actually be powered
> > off, loosing its state entierely, and would then need to be
> > reinitialized. It turns out that this is not always the case, and
> > some HW performs CPU PM without actually killing the core. In this
> > case, we try to reinitialize KVM while it still live. It ends up
> > badly, as reported by Andre Przywara (using a Calxeda Midway):
> > 
> > [    3.663897] Kernel panic - not syncing: unexpected prefetch abort
> > in Hyp mode at: 0x685760 [    3.663897] unexpected data abort in Hyp
> > mode at: 0xc067d150 [    3.663897] unexpected HVC/SVC trap in Hyp
> > mode at: 0xc0901dd0
> > 
> > The trick here is to detect if we've been through a full re-init or
> > not by looking at HVBAR (VBAR_EL2 on arm64). This involves
> > implementing the backend for __hyp_get_vectors in the main KVM HYP
> > code (rather small), and checking the return value against the
> > default one when the CPU notifier is called on CPU_PM_EXIT.
> > 
> > Reported-by: Andre Przywara <osp@andrep.de>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <rob.herring@linaro.org>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Tested-by: Andre Przywara <osp@andrep.de>
> 
> (there seems to be a typo in the second line of the commit message)
> 
> Marc,
> 
> thanks a lot for this quick and perfectly working patch! I still
> believe it is actually the firmware that needs to be fixed, but this is
> rather unlikely in this special case ...
> 
The fix doesn't hurt anything or complicate the code and now we know
that some platforms can do this trick, so let's merge the patch and have
KVM be resilient towards these things.

-Christoffer
