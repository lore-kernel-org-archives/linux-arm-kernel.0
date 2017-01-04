From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jan 2017 14:02:23 +0000
Subject: [PATCH 2/2] arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA
In-Reply-To: <CAKv+Gu8MdpVDCSjfum7AMtbgR6cTP5H+67svhDSu6bkaijvvyg@mail.gmail.com>
References: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
 <1481706707-6211-3-git-send-email-ard.biesheuvel@linaro.org>
 <20170104132831.GD18193@arm.com>
 <CAKv+Gu8MdpVDCSjfum7AMtbgR6cTP5H+67svhDSu6bkaijvvyg@mail.gmail.com>
Message-ID: <20170104140223.GF18193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 01:50:20PM +0000, Ard Biesheuvel wrote:
> On 4 January 2017 at 13:28, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Dec 14, 2016 at 09:11:47AM +0000, Ard Biesheuvel wrote:
> >> The NUMA code may get confused by the presence of NOMAP regions within
> >> zones, resulting in spurious BUG() checks where the node id deviates
> >> from the containing zone's node id.
> >>
> >> Since the kernel has no business reasoning about node ids of pages it
> >> does not own in the first place, enable CONFIG_HOLES_IN_ZONE to ensure
> >> that such pages are disregarded.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/Kconfig | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 111742126897..0472afe64d55 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -614,6 +614,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
> >>       def_bool y
> >>       depends on NUMA
> >>
> >> +config HOLES_IN_ZONE
> >> +     def_bool y
> >> +     depends on NUMA
> >> +
> >>  source kernel/Kconfig.preempt
> >>  source kernel/Kconfig.hz
> >
> > I'm happy to apply this, but I'll hold off until the first patch is queued
> > somewhere, since this doesn't help without the VM_BUG_ON being moved.
> >
> > Alternatively, I can queue both if somebody from the mm camp acks the
> > first patch.
> >
> 
> Actually, I am not convinced the discussion is finalized. These
> patches do fix the issue, but Robert also suggested an alternative fix
> which may be preferable.
> 
> http://marc.info/?l=linux-arm-kernel&m=148190753510107&w=2
> 
> I haven't responded to it yet, due to the holidays, but I'd like to
> explore that solution a bit further before applying anything, if you
> don't mind.

Using early_pfn_valid feels like a bodge to me, since having pfn_valid
return false for something that early_pfn_valid says is valid (and is
therefore initialised in the memmap) makes the NOMAP semantics even more
confusing.

But there's no rush, so I'll hold off for the moment. I was under the
impression that things had stalled.

Will
