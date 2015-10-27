From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Oct 2015 12:05:21 +0000
Subject: [PATCH] arm64: efi: make sure vmlinux load address aligned on
 2MBytes
In-Reply-To: <563137DF.1040908@codeaurora.org>
References: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
 <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
 <563101DD.8080508@codeaurora.org>
 <20151028172619.GA26777@leverpostej>
 <563137DF.1040908@codeaurora.org>
Message-ID: <20151027120520.GA1839@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 04:02:23PM -0500, Timur Tabi wrote:
> On 10/28/2015 12:26 PM, Mark Rutland wrote:
> >>>This does make the kernel boot, but we suspect that there may be
> >>>another problem.  We need to investigate it, but we have a suspicion
> >>>that the EFI stub is trying to allocate from the Runtime Data block,
> >>>and the alignment adjustment "fixes" the problem by moving the
> >>>pointer to Conventional Memory.
> >I don't follow. EFI_BOOT_SERVICES.AllocatePages() should only give us
> >pages which are available, so it shouldn't ever return pages which are
> >runtime data -- it would fail and we'd fall back to efi_low_alloc().
> >
> >Could you elaborate?
> 
> So we're still debugging this internally, but it turns out that
> dram_base is equal to 0x4000820000, which also happens to be the
> start of a Runtime Data block:
> 
>   0x004000820000-0x00400085ffff [Runtime Data       |RUN|XP|  |  |
> |WB|WT|WC|UC]
> 
> I think this is not supposed to happen.

It's perfectly valid for that to be detected as dram_base, and the stub may
call AllocatePages() for that region, but AllocatePages() shouldn't
successfully allocate from there.

The stub should fall back to efi_low_alloc, walking through the memory map
until it finds a large enough region to allocate from, with some subsequent
AllocatePages() call eventually succeeding.

Is that not what you're seeing?

Thanks,
Mark.
