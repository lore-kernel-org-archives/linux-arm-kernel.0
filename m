From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Nov 2015 17:05:59 +0000
Subject: [RFC PATCH] arm64: use non-global mappings for UEFI runtime
 regions
In-Reply-To: <CAKv+Gu8Z=Jb-x1ZL7YSYpLWsEBqh7z0EQ0myg2Gz5asAuHdNbg@mail.gmail.com>
References: <1447750411-6424-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151117152558.GK12586@leverpostej>
 <20151117163445.GE30101@arm.com>
 <20151117164759.GA12266@leverpostej>
 <CAKv+Gu8Z=Jb-x1ZL7YSYpLWsEBqh7z0EQ0myg2Gz5asAuHdNbg@mail.gmail.com>
Message-ID: <20151117170558.GG30101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 06:00:36PM +0100, Ard Biesheuvel wrote:
> On 17 November 2015 at 17:48, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Nov 17, 2015 at 04:34:46PM +0000, Will Deacon wrote:
> >> On Tue, Nov 17, 2015 at 03:25:58PM +0000, Mark Rutland wrote:
> >> > Will, are you aware of anything that could bite us here?
> >>
> >> Can we guarantee that efi_virtmap_{load,unload} are called with interrupts
> >> enabled?
> >
> > Unfortuantely, it looks like we can guarantee interrupts are _disabled_.
> >
> > Every function in drivers/firmware/efi/runtime-wrappers.c which uses
> > efi_call_virt (and hence efi_virtmap_{load,unload}) wraps the call in a
> > spin_lock_irq{save,restore} pair. Those appear to be the only uses of
> > efi_call_virt.
> >
> 
> There is actually no need from the UEFI pov to invoke the UEFI runtime
> services with interrupts disabled, this is simply an implementation
> detail of the kernel support, and I think it is primarily for x86 (but
> I have to dig up the old thread for the details)

So you have a double-edged sword here:

  - switch_mm must be called with interrupts enabled prior to -rc1,
    otherwise we play a song-and-dance with TIF_SWITCH_MM.

  - If you have interrupts enabled, you can receive a rollover IPI from
    another core, which means you switch to current->active_mm.

Will
