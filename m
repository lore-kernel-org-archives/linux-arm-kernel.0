From: steve.capper@arm.com (Steve Capper)
Date: Mon, 4 Dec 2017 18:12:13 +0000
Subject: [PATCH 07/12] arm64: mm: Place kImage at bottom of VA space
In-Reply-To: <CAKv+Gu9Mjd7f57ZZdv+1p70Vs-YD8p6-1P=pb4-KAUsxNVppGw@mail.gmail.com>
References: <20171204141313.31604-1-steve.capper@arm.com>
 <20171204141313.31604-8-steve.capper@arm.com>
 <CAKv+Gu_A-fAMpheWbKZ+prEVKHR58er7sXz0L93Af1XhJrGZeQ@mail.gmail.com>
 <20171204171809.wvrqfd435bh7i5r4@capper-debian.cambridge.arm.com>
 <CAKv+Gu9Mjd7f57ZZdv+1p70Vs-YD8p6-1P=pb4-KAUsxNVppGw@mail.gmail.com>
Message-ID: <20171204181213.or2t24rdh6uwj3iu@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 05:27:10PM +0000, Ard Biesheuvel wrote:
> On 4 December 2017 at 17:18, Steve Capper <steve.capper@arm.com> wrote:
> > Hi Ard,
> >
> > On Mon, Dec 04, 2017 at 04:25:18PM +0000, Ard Biesheuvel wrote:
> >> On 4 December 2017 at 14:13, Steve Capper <steve.capper@arm.com> wrote:
> >> > Re-arrange the kernel memory map s.t. the kernel image resides in the
> >> > bottom 514MB of memory.
> >>
> >> I guess this breaks KASLR entirely, no? Given that it adds an offset
> >> in the range [0 ... sizeof(VMALLOC_SPACE) /4 ].
> >
> > Yes, yes it does. Sorry about this. I had very carefully tested KASLR
> > with custom offsets... on my early page table code. I will have a think
> > about this.
> >
> > From a KASLR side, my (renewed) understanding is that a virtual address
> > as low as possible is desired for the kimage start as that affords the
> > most wiggle room?
> >
> 
> Well, the nice thing about the current arrangement is that the default
> is adjacent to the vmalloc space so any non-zero [bounded] offset
> produces a valid placement. Addition with subtraction is easy, so
> which side the default placement happens to be at does not really
> matter. Having to implement additional bounds checking in the early
> KASLR init code to stay clear of the PCI I/O or fixmap regions sounds
> a bit more cumbersome.
> 

I *think* I can fix KASAN_SHADOW_END to be 0xFFFF200000000000 on both 48-bit
and 52-bit VA configurations. Thus I may be able to enable 52-bit VA with
minimal disruption to the layout of the VA space (i.e. no need to change
the layout) if I also depend on CONFIG_RELOCATABLE.

I'll investigate...

Cheers,
--
Steve
