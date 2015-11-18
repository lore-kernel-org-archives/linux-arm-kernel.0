From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Nov 2015 12:01:44 +0000
Subject: [RFC PATCH] arm64: use non-global mappings for UEFI runtime
 regions
In-Reply-To: <CAKv+Gu8DZRmbV-wFrp7vCRVq9iO8pRKPEOOJcEtn3tz3oPrvfA@mail.gmail.com>
References: <1447750411-6424-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151117152558.GK12586@leverpostej>
 <20151117163445.GE30101@arm.com>
 <20151117164759.GA12266@leverpostej>
 <CAKv+Gu8Z=Jb-x1ZL7YSYpLWsEBqh7z0EQ0myg2Gz5asAuHdNbg@mail.gmail.com>
 <20151117171709.GB12266@leverpostej>
 <CAKv+Gu8DZRmbV-wFrp7vCRVq9iO8pRKPEOOJcEtn3tz3oPrvfA@mail.gmail.com>
Message-ID: <20151118120144.GA10644@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 07:42:27AM +0100, Ard Biesheuvel wrote:
> On 17 November 2015 at 18:17, Mark Rutland <mark.rutland@arm.com> wrote:
> >> >> > For backporting, I'm not sure that this is necessarily safe prior to
> >> >> > Will's rework of the ASID allocator. I think we can IPI in this context,
> >> >> > and it looks like the cpu_set_reserved_ttbr0() in flush_context() would
> >> >> > save us from the problem described above, but I may have missed
> >> >> > something.
> >> >> >
> >> >> > Will, are you aware of anything that could bite us here?
> >> >>
> >> >> Can we guarantee that efi_virtmap_{load,unload} are called with interrupts
> >> >> enabled?
> >> >
> >> > Unfortuantely, it looks like we can guarantee interrupts are _disabled_.
> >> >
> >> > Every function in drivers/firmware/efi/runtime-wrappers.c which uses
> >> > efi_call_virt (and hence efi_virtmap_{load,unload}) wraps the call in a
> >> > spin_lock_irq{save,restore} pair. Those appear to be the only uses of
> >> > efi_call_virt.
> >> >
> >>
> >> There is actually no need from the UEFI pov to invoke the UEFI runtime
> >> services with interrupts disabled, this is simply an implementation
> >> detail of the kernel support, and I think it is primarily for x86 (but
> >> I have to dig up the old thread for the details)
> >>
> >> And even if we stick with spin_lock_irqsave(), we could refactor the
> >> runtime wrappers to perform the mm switch outside of them.
> >
> > Ok.
> >
> > I'm only thinking about stable here.
> >
> > In the context of a stable backport, I think the simplest thing to do is
> > always go via the resesrved ttbr0 to perform the TLB flush, and
> > hand-code the save/restore of the active mm's TTBR0_EL1 value rather
> > than going through cpu_switch_mm (which I believe we can't call with
> > interrupts disabled).
> >
> 
> I think calling cpu_switch_mm() should be fine. It does set the ASID
> to #0 (which shouldn't matter since we only create global mappings)
> but does not invoke any of the logic regarding ASID assignment or
> rollover.

Sorry, I got confused between switch_mm and cpu_switch_mm.

I was also worried about a concurrent rollover of the same mm's ASID
(e.g. in another thread) on another CPU, but I think that's fine. With
the old allocator the CPU handling the rollover would block until the
CPU doing the EFI call returned and enabled interrupts.

> > It doesn't look like it's easy to stash the value given
> > efi_virtmap_{load,unload} are separate functions, and I don't think we
> > can just restore from current->active_mm in case there was a concurrent
> > rollover on another CPU.
> >
> 
> OK, so the fact that we switch to the UEFI page tables and back with
> interrupts disabled is keeping us safe here, and whether we use global
> mappings or not is completely irrelevant.

You are correct.

I'd misunderstood the old allocator. The CPU handling the rollover will
block until all other CPUs handled their IPI, so disabling interrupts
saves us from problems with concurrent rollover.

> In any case, I am going to check with Matt if we can leave interrupts
> enabled during the UEFI Runtime Services (since the execution time is
> not bounded by the spec), but I will keep this in mind in case anyone
> tries to backport that.

Sounds good; sorry for the noise!

Mark.
