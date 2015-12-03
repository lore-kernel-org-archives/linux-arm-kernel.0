From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 3 Dec 2015 15:05:38 +0100
Subject: [PATCH v3 3/7] arm64: split off early mapping code from
 early_fixmap_init()
In-Reply-To: <20151203135939.GB2936@leverpostej>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-4-git-send-email-ard.biesheuvel@linaro.org>
 <20151203121840.GB28731@leverpostej>
 <CAKv+Gu8fZ7YeOsnVdosddiDuYd=MW=OYg_Z4KbNU=yH1PWSw+g@mail.gmail.com>
 <20151203135939.GB2936@leverpostej>
Message-ID: <CAKv+Gu9q=oAjwOFBdrmgdHm1zfD+ekkTft5sbFUmkAsW1Eb37g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2015 at 14:59, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Dec 03, 2015 at 02:31:19PM +0100, Ard Biesheuvel wrote:
>> On 3 December 2015 at 13:18, Mark Rutland <mark.rutland@arm.com> wrote:
>> > Hi Ard,
>> >
>> > Apologies that it's taken me so long to get around to this...
>> >
>> > On Mon, Nov 16, 2015 at 12:23:14PM +0100, Ard Biesheuvel wrote:
>> >> This splits off and generalises the population of the statically
>> >> allocated fixmap page tables so that we may reuse it later for
>> >> the linear mapping once we move the kernel text mapping out of it.
>> >>
>> >> This also involves taking into account that table entries at any of
>> >> the levels we are populating may have been populated already, since
>> >> the fixmap mapping might not be disjoint up to the pgd level anymore
>> >> from other early mappings.
>> >
>> > As a heads-up, for avoiding TLB conflicts, I'm currently working on
>> > alternative way of creating the kernel page tables which will definitely
>> > conflict here, and may or may not supercede this approach.
>> >
>> > By adding new FIX_{PGD,PUD,PMD,PTE} indicees to the fixmap, we can
>> > allocate page tables from anywhere via memblock, and temporarily map
>> > them as we need to.
>> >
>>
>> Interesting. So how are you dealing with the va<->pa translations and
>> vice versa that occur all over the place in create_mapping() et al ?
>
> By rewriting create_mapping() et al to not do that ;)
>
> That's requiring a fair amount of massaging, but so far I've not hit
> anything that renders the approach impossible.
>
>> > That would avoid the need for the bootstrap tables. In head.S we'd only
>> > need to create a temporary (coarse-grained, RWX) kernel mapping (with
>> > the fixmap bolted on). Later we would create a whole new set of tables
>> > with a fine-grained kernel mapping and a full linear mapping using the
>> > new fixmap entries to temporarily map tables, then switch over to those
>> > atomically.
>> >
>>
>> If we change back to a full linear mapping, are we back to not putting
>> the Image astride a 1GB/32MB/512MB boundary (depending on page size)?
>
> I'm not exactly sure what you mean here.
>

Apologies, I misread 'linear mapping' as 'id mapping, which of course
are two different things entirely

> The kernel mapping may inhibit using large section mappings, but this is
> necessary anyway due to permission changes at sub-section granularity
> (e.g. in fixup_init).
>
> The idea is that when the kernel tables are set up, things are mapped at
> the largest possible granularity that permits later permission changes
> without breaking/making sections (such that we can avoid TLB conflicts).
>
> So we'd map the kernel and memory in segments, where no two segments
> share a common last-level entry (i.e. they're all at least page-aligned,
> and don't share a section with another segment).
>
> We'd have separate segments for:
> * memory below TEXT_OFFSET
> * text
> * rodata
> * init
> * altinstr (I think this can be folded into rodata)
> * bss / data, tables
> * memory above _end
>
> Later I think it should be relatively simple to move the memory segment
> mapping for split-VA.
>

I'd need to see it to understand, I guess, but getting rid of the
pa<->va translations is definitely an improvement for the stuff I am
trying to do, and would probably make it a lot cleaner.

>> Anyway, to illustrate where I am headed with this: in my next version
>> of this series, I intend to move the kernel mapping to the start of
>> the vmalloc area, which gets moved up 64 MB to make room for the
>> module area (which also moves down). That way, we can still load
>> modules as before, but no longer have a need for a dedicated carveout
>> for the kernel below PAGE_OFFSET.
>
> Ok.
>
>> The next step is then to move the kernel Image up inside the vmalloc
>> area based on some randomness we get from the bootloader, and relocate
>> it in place (using the same approach as in the patches I sent out
>> beginning of this year). I have implemented module PLTs so that the
>> Image and the modules no longer need to be within 128 MB of each
>> other, which means that we can have full KASLR for modules and Image,
>> and also place the kernel anywhere in physical memory.The module PLTs
>> would be a runtime penalty only, i.e., a KASLR capable kernel running
>> without KASLR would not incur the penalty of branching via PLTs. The
>> only build time option is -mcmodel=large for modules so that data
>> symbol references are absolute, but that is unlike to hurt
>> performance.
>
> I'm certainly interested in seeing this!
>

I have patches for all of this, only they don't live on the same branch yet :-)
