From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Apr 2015 09:57:43 +0100
Subject: [PATCH v3 04/11] arm64: use fixmap region for permanent FDT
 mapping
In-Reply-To: <85D4C79C-6EAC-4E25-8DCE-B0514142A0DE@linaro.org>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
 <1428674035-26603-5-git-send-email-ard.biesheuvel@linaro.org>
 <20150413150203.GF4076@leverpostej>
 <CAKv+Gu8AmPU0iPYHsvG6Lbyi+ho_DBD1PG+8sOLYkTiHjF-ZtQ@mail.gmail.com>
 <20150413152636.GH4076@leverpostej>
 <CAKv+Gu-w=BnoHT3chHXurZ0x-U71SbQo0jZCYg5pEPC4GeC59Q@mail.gmail.com>
 <20150413162646.GK4076@leverpostej>
 <85D4C79C-6EAC-4E25-8DCE-B0514142A0DE@linaro.org>
Message-ID: <20150414085742.GA28709@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 08:44:27AM +0100, Ard Biesheuvel wrote:
> 
> On 13 apr. 2015, at 18:26, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> >> I was wondering: this code now always maps the full 4 MB, also on 64k
> >> pages, even if in the majority of cases, the actual FDT is much
> >> smaller. Do you think there is a downside to that?
> > 
> > The two cases I can think of as problematic are when the FDT is in the
> > last 2M of RAM, or in a 2M region immediately before some carveout which
> > won't use MT_NORMAL attributes.
> > 
> > We could solve those by only mapping however many 2M chunks are
> > necessary, or we could keep the requirement that it fits within a
> > naturally-aligned 2M region for now.
> > 
> 
> I strongly prefer the former, since otherwise, you always need to
> verify the allocation explicitly, for an fdt of any size, and it turns
> out the logic is easily updated to move the vetting into
> fixmap_remap_fdt() and check the magic and size after mapping the
> first chunk, and set pfn_end accordingly

I'm happy with that; it also decays to the old behaviour for anything
that works currently.

We should probably make it clear in the booting document that the kernel
should be expected to map the DTB in 2M chunks, so people know they
shouldn't share any 2M chunk with a carveout.

Mark.
