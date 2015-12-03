From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 3 Dec 2015 14:31:19 +0100
Subject: [PATCH v3 3/7] arm64: split off early mapping code from
 early_fixmap_init()
In-Reply-To: <20151203121840.GB28731@leverpostej>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-4-git-send-email-ard.biesheuvel@linaro.org>
 <20151203121840.GB28731@leverpostej>
Message-ID: <CAKv+Gu8fZ7YeOsnVdosddiDuYd=MW=OYg_Z4KbNU=yH1PWSw+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2015 at 13:18, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> Apologies that it's taken me so long to get around to this...
>
> On Mon, Nov 16, 2015 at 12:23:14PM +0100, Ard Biesheuvel wrote:
>> This splits off and generalises the population of the statically
>> allocated fixmap page tables so that we may reuse it later for
>> the linear mapping once we move the kernel text mapping out of it.
>>
>> This also involves taking into account that table entries at any of
>> the levels we are populating may have been populated already, since
>> the fixmap mapping might not be disjoint up to the pgd level anymore
>> from other early mappings.
>
> As a heads-up, for avoiding TLB conflicts, I'm currently working on
> alternative way of creating the kernel page tables which will definitely
> conflict here, and may or may not supercede this approach.
>
> By adding new FIX_{PGD,PUD,PMD,PTE} indicees to the fixmap, we can
> allocate page tables from anywhere via memblock, and temporarily map
> them as we need to.
>

Interesting. So how are you dealing with the va<->pa translations and
vice versa that occur all over the place in create_mapping() et al ?

> That would avoid the need for the bootstrap tables. In head.S we'd only
> need to create a temporary (coarse-grained, RWX) kernel mapping (with
> the fixmap bolted on). Later we would create a whole new set of tables
> with a fine-grained kernel mapping and a full linear mapping using the
> new fixmap entries to temporarily map tables, then switch over to those
> atomically.
>

If we change back to a full linear mapping, are we back to not putting
the Image astride a 1GB/32MB/512MB boundary (depending on page size)?

Anyway, to illustrate where I am headed with this: in my next version
of this series, I intend to move the kernel mapping to the start of
the vmalloc area, which gets moved up 64 MB to make room for the
module area (which also moves down). That way, we can still load
modules as before, but no longer have a need for a dedicated carveout
for the kernel below PAGE_OFFSET.

The next step is then to move the kernel Image up inside the vmalloc
area based on some randomness we get from the bootloader, and relocate
it in place (using the same approach as in the patches I sent out
beginning of this year). I have implemented module PLTs so that the
Image and the modules no longer need to be within 128 MB of each
other, which means that we can have full KASLR for modules and Image,
and also place the kernel anywhere in physical memory.The module PLTs
would be a runtime penalty only, i.e., a KASLR capable kernel running
without KASLR would not incur the penalty of branching via PLTs. The
only build time option is -mcmodel=large for modules so that data
symbol references are absolute, but that is unlike to hurt
performance.

> Otherwise, one minor comment below.
>
>> +static void __init bootstrap_early_mapping(unsigned long addr,
>> +                                        struct bootstrap_pgtables *reg,
>> +                                        bool pte_level)
>
> The only caller in this patch passes true for pte_level.
>
> Can we not introduce the argument when it is first needed? Or at least
> have something in the commit message as to why we'll need it later?
>

Yes, that should be possible.

>>       /*
>>        * The boot-ioremap range spans multiple pmds, for which
>> -      * we are not preparted:
>> +      * we are not prepared:
>>        */
>
> I cannot wait to see this typo go!
>
> Otherwise, this looks fine to me.
>

Thanks Mark
