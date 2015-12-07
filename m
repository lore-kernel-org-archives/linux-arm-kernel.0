From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Dec 2015 16:08:57 +0000
Subject: [PATCH v3 3/7] arm64: split off early mapping code from
 early_fixmap_init()
In-Reply-To: <CAKv+Gu8fZ7YeOsnVdosddiDuYd=MW=OYg_Z4KbNU=yH1PWSw+g@mail.gmail.com>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-4-git-send-email-ard.biesheuvel@linaro.org>
 <20151203121840.GB28731@leverpostej>
 <CAKv+Gu8fZ7YeOsnVdosddiDuYd=MW=OYg_Z4KbNU=yH1PWSw+g@mail.gmail.com>
Message-ID: <20151207160856.GD7083@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 02:31:19PM +0100, Ard Biesheuvel wrote:
> On 3 December 2015 at 13:18, Mark Rutland <mark.rutland@arm.com> wrote:
> > As a heads-up, for avoiding TLB conflicts, I'm currently working on
> > alternative way of creating the kernel page tables which will definitely
> > conflict here, and may or may not supercede this approach.
> >
> > By adding new FIX_{PGD,PUD,PMD,PTE} indicees to the fixmap, we can
> > allocate page tables from anywhere via memblock, and temporarily map
> > them as we need to.
[...]
> > That would avoid the need for the bootstrap tables. In head.S we'd only
> > need to create a temporary (coarse-grained, RWX) kernel mapping (with
> > the fixmap bolted on). Later we would create a whole new set of tables
> > with a fine-grained kernel mapping and a full linear mapping using the
> > new fixmap entries to temporarily map tables, then switch over to those
> > atomically.

If we separate the kernel image mapping from the linear one, I think
things would be slightly simpler to avoid TLB conflicts (but I haven't
looked at Mark's patches yet).

> If we change back to a full linear mapping, are we back to not putting
> the Image astride a 1GB/32MB/512MB boundary (depending on page size)?
> 
> Anyway, to illustrate where I am headed with this: in my next version
> of this series, I intend to move the kernel mapping to the start of
> the vmalloc area, which gets moved up 64 MB to make room for the
> module area (which also moves down). That way, we can still load
> modules as before, but no longer have a need for a dedicated carveout
> for the kernel below PAGE_OFFSET.

This makes sense, I guess it can be easily added to the existing series
just by changing the KIMAGE_OFFSET macro.

> The next step is then to move the kernel Image up inside the vmalloc
> area based on some randomness we get from the bootloader, and relocate
> it in place (using the same approach as in the patches I sent out
> beginning of this year). I have implemented module PLTs so that the
> Image and the modules no longer need to be within 128 MB of each
> other, which means that we can have full KASLR for modules and Image,
> and also place the kernel anywhere in physical memory.The module PLTs
> would be a runtime penalty only, i.e., a KASLR capable kernel running
> without KASLR would not incur the penalty of branching via PLTs. The
> only build time option is -mcmodel=large for modules so that data
> symbol references are absolute, but that is unlike to hurt
> performance.

I guess full KASLR would be conditional on a config option.

-- 
Catalin
