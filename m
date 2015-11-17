From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Nov 2015 18:05:50 +0100
Subject: [RFC PATCH] arm64: use non-global mappings for UEFI runtime
 regions
In-Reply-To: <CAKv+Gu8Z=Jb-x1ZL7YSYpLWsEBqh7z0EQ0myg2Gz5asAuHdNbg@mail.gmail.com>
References: <1447750411-6424-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151117152558.GK12586@leverpostej>
 <20151117163445.GE30101@arm.com>
 <20151117164759.GA12266@leverpostej>
 <CAKv+Gu8Z=Jb-x1ZL7YSYpLWsEBqh7z0EQ0myg2Gz5asAuHdNbg@mail.gmail.com>
Message-ID: <CAKv+Gu8ss2Lagm6srZ2e=in7irHXkYgH2ko95TiOW9vGSOp0Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2015 at 18:00, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 17 November 2015 at 17:48, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Tue, Nov 17, 2015 at 04:34:46PM +0000, Will Deacon wrote:
>>> On Tue, Nov 17, 2015 at 03:25:58PM +0000, Mark Rutland wrote:
>>> > On Tue, Nov 17, 2015 at 09:53:31AM +0100, Ard Biesheuvel wrote:
>>> > > As pointed out by Russell King in response to the proposed ARM version
>>> > > of this code, the sequence to switch between the UEFI runtime mapping
>>> > > and current's actual userland mapping (and vice versa) is potentially
>>> > > unsafe, since it leaves a time window between the switch to the new
>>> > > page tables and the TLB flush where speculative accesses may hit on
>>> > > stale global TLB entries.
>>> >
>>> > Wow, annoying that we missed that.
>>> >
>>> > > So instead, use non-global mappings, and perform the switch via the
>>> > > ordinary ASID-aware context switch routines.
>>> > >
>>> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> >
>>> > From digging into the way the ASID allocator works, I believe this is
>>> > correct. FWIW:
>>> >
>>> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>>> >
>>> > For backporting, I'm not sure that this is necessarily safe prior to
>>> > Will's rework of the ASID allocator. I think we can IPI in this context,
>>> > and it looks like the cpu_set_reserved_ttbr0() in flush_context() would
>>> > save us from the problem described above, but I may have missed
>>> > something.
>>> >
>>> > Will, are you aware of anything that could bite us here?
>>>
>>> Can we guarantee that efi_virtmap_{load,unload} are called with interrupts
>>> enabled?
>>
>> Unfortuantely, it looks like we can guarantee interrupts are _disabled_.
>>
>> Every function in drivers/firmware/efi/runtime-wrappers.c which uses
>> efi_call_virt (and hence efi_virtmap_{load,unload}) wraps the call in a
>> spin_lock_irq{save,restore} pair. Those appear to be the only uses of
>> efi_call_virt.
>>
>
> There is actually no need from the UEFI pov to invoke the UEFI runtime
> services with interrupts disabled, this is simply an implementation
> detail of the kernel support, and I think it is primarily for x86 (but
> I have to dig up the old thread for the details)
>

Thread is here:
http://marc.info/?l=linux-arm-kernel&m=140429592914544

> And even if we stick with spin_lock_irqsave(), we could refactor the
> runtime wrappers to perform the mm switch outside of them.
