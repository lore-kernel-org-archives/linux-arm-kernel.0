From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Sun, 12 May 2013 11:51:30 -0700
Subject: [PATCH v3 24/32] arm64: KVM: 32bit GP register access
In-Reply-To: <20130511094336.GA56525@MacBook-Pro.local>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
 <20130502160906.GI20730@arm.com> <51892B90.8060706@arm.com>
 <20130507163303.GH29757@arm.com> <20130511003630.GD30999@chazy>
 <20130511094336.GA56525@MacBook-Pro.local>
Message-ID: <20130512184536.GA58092@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 11, 2013 at 10:43:37AM +0100, Catalin Marinas wrote:
> On Sat, May 11, 2013 at 01:36:30AM +0100, Christoffer Dall wrote:
> > On Tue, May 07, 2013 at 05:33:03PM +0100, Catalin Marinas wrote:
> > > On Tue, May 07, 2013 at 05:28:00PM +0100, Marc Zyngier wrote:
> > > > On 02/05/13 17:09, Catalin Marinas wrote:
> > > > > BTW, on arch/arm it looks like this is used when you get a data abort
> > > > > with PC as the destination register and you inject a prefetch abort in
> > > > > this case. Why isn't this a normal data abort? Once you get the
> > > > > information, you load it into PC but first you need to sort out the data
> > > > > abort (unless I don't understand how the kvm_inject_pabt works).
> > > > 
> > > > Indeed, it should be a data abort, as we correctly fetched the
> > > > instruction. Now, I wonder why we even bother trying to catch this case.
> > > > Fetching PC from MMIO looks quite silly, but I don't think anything
> > > > really forbids it in the architecture.
> > > 
> > > It's not forbidden and you should just treat it as any other data abort,
> > > no need to check whether the register is PC. If you do the PC adjustment
> > > further down in that function it will be overridden by the instruction
> > > emulation anyway. There is no optimisation in checking for PC since such
> > > fault is very unlikely in sane code anyway.
> > > 
> > The reason is simply that it is most likely because of a bug that this
> > happens, and we would rather catch such an error in a meaningful way
> > than let this go crazy and have users track it down for a long time.
> 
> It is probably a bug but it is a valid code sequence (and Peter even
> gave an example).
> 
> > Especially, this was relevant when we did io instruction decoding and we
> > wanted to catch potential bugs in that when it was development code.
> > 
> > That all being said, we can remove the check.  I don't think, however,
> > that it being an unlikely thing is a good argument: if we remove the
> > check we need to make sure that the VM does whatever the architecture
> > dictates, which I assume is to not skip the MMIO instruction and support
> > setting the PC to the value returned from an I/O emulation device in
> > QEMU.
> > 
> > I think the scenario sounds crazy and is more than anything a sign of a
> > bug somewhere, and whether it should be a PABT or a DABT is a judgement
> > call, but I chose a PABT because the thing that's weird is jumping to an
> > I/O address, it's not that the memory address for the load is
> > problematic.
> 
> I think that's where things get confused. You are reading from an I/O
> location with the destination being the PC and it is trapped by KVM.
> This has nothing to do with PABT, it's purely a DABT on the I/O access.
> You should emulate it and store the result in the PC. If the value
> loaded in PC is wrong, you will get a subsequent PABT in the guest but
> you must not translate the DABT on I/O memory (which would be generated
> even if the destination is not PC) into a PABT which confuses the guest
> further. By doing this you try to convince the guest that it really
> branched to the I/O address (since you raise the PABT with the DFAR
> value) when it simply tried to load an address from I/O and branch to
> this new address.
> 
> IOW, these two are equivalent regarding PC:
> 
> 	ldr	pc, [r0]	@ r0 is an I/O address
> 
> and 
> 
> 	ldr	r1, [r0]	@ r0 is an I/O address
> 	mov	pc, r1
> 
> In the second scenario, you don't raise a PABT on the first instruction.
> You may raise one on the second if PC is invalid but that's different
> and most likely it will be a guest-only thing.
> 
> So for DABT emulation, checking whether the destination register is PC
> is simply a minimal optimisation (if at all) of that case to avoid
> storing the PC twice. Injecting PABT when you get a DABT is a bug. You
> already catch PABT on I/O address in kvm_handle_guest_abort() and
> correctly inject PABT into guest.
> 
Yeah, I got a little confused on the jump to an I/O address and load
the PC from an I/O address distinction, thanks for waking me up.

I will send out a patch that should address this issue by correctly
loading the value into the PC (and not inject a DABT).  Note that I
don't plan on doing any explicit checking for a case where the VM does
something like:

	ldrb	pc, [r0]	@ r0 is an I/O address

Because I assume that this is either an undefined instruction or the
behavior is unpredictable as per the architecture anyway, and we should
never get there unless we have a bug in our decoding implementation,
which I doubt at this point.

-Christoffer
