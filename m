From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 May 2013 17:33:03 +0100
Subject: [PATCH v3 24/32] arm64: KVM: 32bit GP register access
In-Reply-To: <51892B90.8060706@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
 <20130502160906.GI20730@arm.com> <51892B90.8060706@arm.com>
Message-ID: <20130507163303.GH29757@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 05:28:00PM +0100, Marc Zyngier wrote:
> On 02/05/13 17:09, Catalin Marinas wrote:
> > BTW, on arch/arm it looks like this is used when you get a data abort
> > with PC as the destination register and you inject a prefetch abort in
> > this case. Why isn't this a normal data abort? Once you get the
> > information, you load it into PC but first you need to sort out the data
> > abort (unless I don't understand how the kvm_inject_pabt works).
> 
> Indeed, it should be a data abort, as we correctly fetched the
> instruction. Now, I wonder why we even bother trying to catch this case.
> Fetching PC from MMIO looks quite silly, but I don't think anything
> really forbids it in the architecture.

It's not forbidden and you should just treat it as any other data abort,
no need to check whether the register is PC. If you do the PC adjustment
further down in that function it will be overridden by the instruction
emulation anyway. There is no optimisation in checking for PC since such
fault is very unlikely in sane code anyway.

-- 
Catalin
