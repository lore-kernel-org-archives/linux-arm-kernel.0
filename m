From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 Dec 2013 20:30:26 -0800
Subject: [PATCH v3 0/2] PSCI system off and reset for KVM ARM/ARM64
In-Reply-To: <CAL_Jsq+O_wuZN==PObGnGK5no_2Yt2ROp4Q1m5JhH-LnBrY6VA@mail.gmail.com>
References: <1387280136-13622-1-git-send-email-anup.patel@linaro.org>
 <20131217185154.GN5711@cbox>
 <87wqj2ql57.fsf@e102391-lin.cambridge.arm.com>
 <CAAhSdy1BenCt+tuBYVR2Kzbrt0Ev59SFG8kaguOwj2Dug7Be4A@mail.gmail.com>
 <87txe6p3o8.fsf@e102391-lin.cambridge.arm.com>
 <CAAhSdy1PEvudWMq__Qt2ZT663LsuF335myZaPyA81uhnqmVKoQ@mail.gmail.com>
 <87a9fyowqi.fsf@e102391-lin.cambridge.arm.com>
 <CAAhSdy1XKBdyXGWGZXwj8+C0_P3CqyzyFuW=HysEps_QByuv4g@mail.gmail.com>
 <8738lqow22.fsf@e102391-lin.cambridge.arm.com>
 <CAL_Jsq+O_wuZN==PObGnGK5no_2Yt2ROp4Q1m5JhH-LnBrY6VA@mail.gmail.com>
Message-ID: <20131219043026.GQ5711@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 05:26:46PM -0600, Rob Herring wrote:
> On Wed, Dec 18, 2013 at 12:25 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On Wed, Dec 18 2013 at 06:18:54 PM, Anup Patel <anup@brainfault.org> wrote:
> >> On Wed, Dec 18, 2013 at 11:41 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>> On Wed, Dec 18 2013 at 03:52:29 PM, Anup Patel <anup@brainfault.org> wrote:
> >>>> On Wed, Dec 18, 2013 at 9:11 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>>>> Hi Anup,
> >>>>>
> >>>>> On Wed, Dec 18 2013 at 03:03:43 PM, Anup Patel <anup@brainfault.org> wrote:
> >>>>>> On Wed, Dec 18, 2013 at 8:08 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>>>>>> Christoffer Dall <christoffer.dall@linaro.org> writes:
> >>>>>>>
> >>>>>>>> On Tue, Dec 17, 2013 at 05:05:34PM +0530, Anup Patel wrote:
> >>>>>>>>> The Power State and Coordination Interface (PSCI) specification defines
> >>>>>>>>> SYSTEM_OFF and SYSTEM_RESET functions for system poweroff and reboot.
> >>>>>>>>>
> >>>>>>>>> This patchset adds emulation of PSCI SYSTEM_OFF and SYSTEM_RESET functions
> >>>>>>>>> in KVM ARM/ARM64 by forwarding them to user space (QEMU or KVMTOOL) using
> >>>>>>>>> KVM_EXIT_SYSTEM_EVENT exit reason.
> >>>>>>>>>
> >>>>>>>>> To try this patch from guest kernel, we will need PSCI-based restart and
> >>>>>>>>> poweroff support in the guest kenel for both ARM and ARM64.
> >>>>>>>>>
> >>>>>>>>> Rob Herring has already submitted patches for PSCI-based restart and
> >>>>>>>>> poweroff in ARM kernel but these are not merged yet due unstable device
> >>>>>>>>> tree bindings of kernel PSCI support. We will be having similar patches
> >>>>>>>>> for PSCI-based restart and poweroff in ARM64 kernel.
> >>>>>>>>> (Refer http://www.spinics.net/lists/arm-kernel/msg262217.html)
> >>>>>>>>> (Refer http://www.spinics.net/lists/devicetree/msg05348.html)
> >>>>>>>>
> >>>>>>>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> >>>>>>>>
> >>>>>>>> I can merge this series if Marc acks it as well.
> >>>>>>>
> >>>>>>> The patches themselves are mostly fine. One issue though: They implement
> >>>>>>> part of the v0.2 spec, but keep on using the range of function IDs that
> >>>>>>> we made up for v0.1.
> >>>>>>>
> >>>>>>> I just had a chat with the person responsible for the spec, and realized
> >>>>>>> that the Function IDs mentionned in the v0.2 spec are not optional, and
> >>>>>>> not using them would be in direct violation of the spec (the new numbers
> >>>>>>> now come directly from the SMC calling convention).
> >>>>>>
> >>>>>> Should we emulate PSCI_VERSION call to help Guest determine
> >>>>>> the spec version emulated by KVM (i.e. v0.1 or v0.2) ??
> >>>>>
> >>>>> I think that'd be a nice to have, but the guest is likely to get its
> >>>>> information from the DT anyway. Plus I don't think the original PSCI
> >>>>> spec specified PSCI_VERSION, which only make it useful for whatever
> >>>>> comes after v0.2.
> >>>>>
> >>>>> So I think we need to:
> >>>>> - Use the new range for PSCI v0.2 (while still supporting v0.1 and the
> >>>>> old range)
> >>>>
> >>>> Does this mean we should have first isolate v0.2 ID range
> >>>> from v0.1 ID range?
> >>>
> >>> Yes.
> >>
> >> Are you planning to do it ?
> >> OR
> >> Do you expect me to do it because this patchset would depend on that?
> >
> > First, I want to understand the objections that were raised against
> > using the Function IDs as defined in the spec.
> >
> > Then, assuming we move in that direction, I'd expect you to create a
> > separate range of IDs and update the PSCI code to handle both PSCI
> > versions.
> >
> > But as this has direct implication with userspace (DT generation), I'd
> > rather take it slow and first try to understand the issues Mark raised.
> 
> Here is the thread where relying on SMC calling convention was discussed:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/188057.html
> 
>From reading that thread and the PSCI and SMC calling convention docs I
don't see anything that suggests that PSCI v0.2 should not follow the
function IDs in the PSCI document.

Am I missing something?

-Christoffer
