From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 10 May 2013 17:36:30 -0700
Subject: [PATCH v3 24/32] arm64: KVM: 32bit GP register access
In-Reply-To: <20130507163303.GH29757@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
 <20130502160906.GI20730@arm.com> <51892B90.8060706@arm.com>
 <20130507163303.GH29757@arm.com>
Message-ID: <20130511003630.GD30999@chazy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 05:33:03PM +0100, Catalin Marinas wrote:
> On Tue, May 07, 2013 at 05:28:00PM +0100, Marc Zyngier wrote:
> > On 02/05/13 17:09, Catalin Marinas wrote:
> > > BTW, on arch/arm it looks like this is used when you get a data abort
> > > with PC as the destination register and you inject a prefetch abort in
> > > this case. Why isn't this a normal data abort? Once you get the
> > > information, you load it into PC but first you need to sort out the data
> > > abort (unless I don't understand how the kvm_inject_pabt works).
> > 
> > Indeed, it should be a data abort, as we correctly fetched the
> > instruction. Now, I wonder why we even bother trying to catch this case.
> > Fetching PC from MMIO looks quite silly, but I don't think anything
> > really forbids it in the architecture.
> 
> It's not forbidden and you should just treat it as any other data abort,
> no need to check whether the register is PC. If you do the PC adjustment
> further down in that function it will be overridden by the instruction
> emulation anyway. There is no optimisation in checking for PC since such
> fault is very unlikely in sane code anyway.
> 
The reason is simply that it is most likely because of a bug that this
happens, and we would rather catch such an error in a meaningful way
than let this go crazy and have users track it down for a long time.

Especially, this was relevant when we did io instruction decoding and we
wanted to catch potential bugs in that when it was development code.

That all being said, we can remove the check.  I don't think, however,
that it being an unlikely thing is a good argument: if we remove the
check we need to make sure that the VM does whatever the architecture
dictates, which I assume is to not skip the MMIO instruction and support
setting the PC to the value returned from an I/O emulation device in
QEMU.

I think the scenario sounds crazy and is more than anything a sign of a
bug somewhere, and whether it should be a PABT or a DABT is a judgement
call, but I chose a PABT because the thing that's weird is jumping to an
I/O address, it's not that the memory address for the load is
problematic.

-Christoffer
