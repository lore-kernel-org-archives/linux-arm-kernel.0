From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 8 Jan 2014 14:02:13 -0800
Subject: [PATCH v3 0/2] PSCI system off and reset for KVM ARM/ARM64
In-Reply-To: <20140107115024.GB4180@e106331-lin.cambridge.arm.com>
References: <1387280136-13622-1-git-send-email-anup.patel@linaro.org>
 <20131217185154.GN5711@cbox>
 <87wqj2ql57.fsf@e102391-lin.cambridge.arm.com>
 <52B1C251.9040801@gmail.com>
 <87eh5aowrw.fsf@e102391-lin.cambridge.arm.com>
 <20140107115024.GB4180@e106331-lin.cambridge.arm.com>
Message-ID: <20140108220213.GB4053@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 11:50:24AM +0000, Mark Rutland wrote:
> On Wed, Dec 18, 2013 at 06:10:27PM +0000, Marc Zyngier wrote:
> > Hi Rob,
> > 
> > On Wed, Dec 18 2013 at 03:42:09 PM, Rob Herring <robherring2@gmail.com> wrote:
> > > Adding Mark Rutland.
> > >
> > > On 12/18/2013 08:38 AM, Marc Zyngier wrote:
> > >> Christoffer Dall <christoffer.dall@linaro.org> writes:
> > >> 
> > >>> On Tue, Dec 17, 2013 at 05:05:34PM +0530, Anup Patel wrote:
> > >>>> The Power State and Coordination Interface (PSCI) specification defines
> > >>>> SYSTEM_OFF and SYSTEM_RESET functions for system poweroff and reboot.
> > >>>>
> > >>>> This patchset adds emulation of PSCI SYSTEM_OFF and SYSTEM_RESET functions
> > >>>> in KVM ARM/ARM64 by forwarding them to user space (QEMU or KVMTOOL) using
> > >>>> KVM_EXIT_SYSTEM_EVENT exit reason.
> > >>>>
> > >>>> To try this patch from guest kernel, we will need PSCI-based restart and
> > >>>> poweroff support in the guest kenel for both ARM and ARM64.
> > >>>>
> > >>>> Rob Herring has already submitted patches for PSCI-based restart and
> > >>>> poweroff in ARM kernel but these are not merged yet due unstable device
> > >>>> tree bindings of kernel PSCI support. We will be having similar patches
> > >>>> for PSCI-based restart and poweroff in ARM64 kernel.
> > >>>> (Refer http://www.spinics.net/lists/arm-kernel/msg262217.html)
> > >>>> (Refer http://www.spinics.net/lists/devicetree/msg05348.html)
> > >>>
> > >>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> > >>>
> > >>> I can merge this series if Marc acks it as well.
> > >> 
> > >> The patches themselves are mostly fine. One issue though: They implement
> > >> part of the v0.2 spec, but keep on using the range of function IDs that
> > >> we made up for v0.1.
> > >> 
> > >> I just had a chat with the person responsible for the spec, and realized
> > >> that the Function IDs mentionned in the v0.2 spec are not optional, and
> > >> not using them would be in direct violation of the spec (the new numbers
> > >> now come directly from the SMC calling convention).
> > >
> > > News to me. That is exactly the opposite of what Mark Rutland told me.
> > > This would certainly simplify things since the SMC calling convention
> > > IDs encode the size and there would be no reason to put the IDs into
> > > DT.
> 
> Hi Rob,
> 
> Sorry for the confusion here. My position changed over the course of the
> discussion, so I'm probably arguing against my original side now.
> 
> I think the key point was that I wanted a PSCI 0.2 system to function
> with an existing kernel if possible, as all the existing calls still
> exist. That implied placing the numbers (redundantly) into the DT. This
> is important for extending KVM with PSCI 0.2 support without breaking
> support for existing guests and having to have a load of messy flags
> depending on the guest you want to boot.
> 
> I agree that we should use the specified function IDs, and therefore we
> do not need to specify the IDs. A new system that old kernels can't run
> on anyway can just have:
> 
> psci {
> 	compatible = "arm,psci-0.2";
> 	methoc = "smc";
> };
> 
> However, it would be nice to have a set of function IDs in the DT for
> existing clients as a fallback. Preferably in the same node (we have the
> compatible list, we may as well use it and make it clear we expect
> clients to use one or the other):
> 
> psci {
> 	compatible = "arm,psci-0.2", "arm,psci";
> 	method = "smc";
> 
> 	/* 
> 	 * The mandated PSCI 0.2 IDs are used by the client if it
> 	 * understands PSCI 0.2. These IDs are for older clients that
> 	 * only support the kernel's old PSCI version.
> 	 *
> 	 * These IDs might not match any of the PSCI 0.2 IDs, and are
> 	 * purely here for compatibility with existing software.
> 	 */
> 	cpu_off = <...>;
> 	cpu_on = <...>;
> 	cpu_suspend = <...>;
> };
> 
> I believe KVM currently uses the same ID numbers regardless of guest
> register-width, which is unfortunately different from what PSCI 0.2 says
> it should. As KVM can figure out the register width of the caller it
> might be able to do the right thing (unless that's in conflict with PSCI
> 0.2). At worst we should be able to allocate a third set of
> width-agnostic IDs for older clients that imply the current behaviour.

I would assume we keep the current PSCI 0.1 implementation in KVM the
way it is, and add PSCI 0.2 as an additional 'feature' and leave it up
to user space to decide how to put it into the device tree.  But without
doing much more work on the current PSCI 0.1 implementation.  User space
can then choose either of your proposed DT nodes depending on the level
of backwards compatibility with VM kernels it wants.

Is this in line with your thinking?

-Christoffer

> 
> Does that sound reasonable? Sorry for leading you in circles.
> 
> > 
> > Hmmm. I'd hate to contredict Mark. But as he's on holiday (and hopefully
> > unlikely to reply immediately), I win the argument! ;-)
> > 
> > More seriously, given that we have a document specifying the IDs, I'd be
> > inclined to follow it. It is not that often that ARM actually *mandates*
> > something... ;-)
> > 
> > Mark (assuming you're reading this): what were your objections about
> > following the ID mentioned in the spec?
> 
> Originally I was worried about more spectacularly bad implementations
> with wrong IDs or a subset of IDs supported. Now I agree that we can
> handle those later if and when they arise, and using the correct IDs is
> a far better option.
> 
> The other issue was KVM forwards-compatibility, but I think the above
> covers that.
> 
> > 
> > >> So I rekon we need to create a separate range for those. Also, I'd like
> > >> to progress the DT and kernel side of things as well (otherwise this is
> > >> all a bit pointless).
> > >> 
> > >> Rob: what are your plans regarding your PSCI v0.2 patches?
> > >
> > > My plan was to simply add 2 optional properties for reset/off and be
> > > done with it like is done here. I'll leave it to ARM to sort out all of
> > > v0.2 ID and 32-bit vs. 64-bit issues.
> 
> Does the above sound OK for adding that support?
> 
> Thanks,
> Mark.
