From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Aug 2014 12:57:14 +0100
Subject: [PATCH v2 1/3] arm64: spin-table: handle unmapped
 cpu-release-addrs
In-Reply-To: <CAKv+Gu9ftjZby+5U5Vs0hXhyFdNLwx4MwvC-LL=y3a9eSz34iQ@mail.gmail.com>
References: <CAKv+Gu_UjRNhhiM0GPsKRdXRtmEnY6cbpY-JZ33RUMapbPYsbQ@mail.gmail.com>
 <20140813125844.GE32644@leverpostej>
 <20140814171323.GH9039@arm.com>
 <CAKv+Gu9ftjZby+5U5Vs0hXhyFdNLwx4MwvC-LL=y3a9eSz34iQ@mail.gmail.com>
Message-ID: <20140815115714.GP27466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 07:10:13PM +0100, Ard Biesheuvel wrote:
> On 14 August 2014 19:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, Aug 13, 2014 at 01:58:45PM +0100, Mark Rutland wrote:
> >> > With the 3.17 merge window not far from closing, is there anything we
> >> > could still do this cycle to get $subject addressed?
> >> > As I have indicated before, the newly introduced TEXT_OFFSET fuzzing
> >> > may break APM Mustang if booting from UEFI (i.e., for low values of
> >> > rand()), and as this option is recommended for distribution kernels,
> >> > it could make apt-get update'ing your kernel a frustrating experience.
> >> > However, the fix for that issue triggers the issue addressed by
> >> > $subject.
> >> >
> >> > In my personal opinion, relaxing the requirements imposed on where
> >> > your cpu-release-addr may live could remain a separate discussion. In
> >> > the APM Mustang case, even when adhering to booting.txt by the letter
> >> > (i.e., pu cpu-release-addr in a memreserved area in DRAM and load
> >> > Image at a 2 meg boundary + TEXT_OFFSET), the kernel fails to bring up
> >> > the secondaries if the cpu-release-addr is below the kernel.
> >>
> >> For the moment I would be happy with the patch as it stands (using
> >> ioremap_cache).
> >>
> >> Catalin, Will?
> >
> > Using ioremap_cache() sounds fine to me but I have to dig the original
> > patches as I've only been cc'ed in the middle of the thread (and that's
> > just for patch 1/3).
> >
> 
> http://marc.info/?l=linux-arm-kernel&m=140671806332258&w=2
> http://marc.info/?l=linux-arm-kernel&m=140671807532262&w=2
> http://marc.info/?l=linux-arm-kernel&m=140671807732263&w=2
> 
> Patch 3/3 makes the EFI stub load Image at the lowest 2 meg boundary +
> TEXT_OFFSET instead of erroring out when base of DRAM + TEXT_OFFSET is
> occupied. This is necessary as the randomized TEXT_OFFSET could
> potentially conflict with reserved areas at the base of DRAM if a low
> value happens to be chosen.
> 
> Patch 1/3 fixes the resulting breakage on APM Mustang in bringing up
> the secondaries, as on that board in particular, the reserved area at
> the base of DRAM contains the holding pen, and loading Image higher up
> makes the mailbox inaccessible through the linear mapping hence the
> need for ioremap_cache()
> 
> Patch 2/3 is also a fix for a potential issue on UEFI boot, but it is
> unrelated to 1/3 and 3/3

I was planning to take all of these for 3.18 as there's no regression here
(the fuzzing is a new debug feature and defaults to `n'). Do you think these
qualify as -rc1 material?

Will
