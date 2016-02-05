From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Feb 2016 17:32:48 +0000
Subject: [PATCH v5sub2 0/8] arm64: implement virtual KASLR
In-Reply-To: <CAKv+Gu-AhLcatkDsQVeoFGJ+pTEwaW1Hy9M-fY1-VWvRc_E47w@mail.gmail.com>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu-AhLcatkDsQVeoFGJ+pTEwaW1Hy9M-fY1-VWvRc_E47w@mail.gmail.com>
Message-ID: <20160205173248.GJ6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 02:35:03PM +0100, Ard Biesheuvel wrote:
> On 1 February 2016 at 14:09, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > At the request of Catalin, this series has been split off from my series
> > 'arm64: implement support for KASLR v4' [1]. This sub-series deals with
> > creating a relocatable binary, and randomizing the virtual placement of
> > the kernel itself, the modules and the linear region based on entropy
> > supplied by the bootloader in the /chosen/kaslr-seed DT property.
> >
> > Changes since v4:
> > - add randomization of the linear region, i.e., if the linear region is
> >   substantially larger than the space spanned by RAM, the mapping of RAM
> >   is moved to a random offset inside the linear region.
> > - dropped the CRC check in kaslr_early_init(), since the only code that may
> >   modify .data through __fixmap_remap_fdt() is instrumentation that should
> >   deal with that correctly (For instance, the branch profiling records taken
> >   branches in structs allocated in .data, and these counts will not be reset
> >   to 0 between the first and the second call to __mmap_switched())
> > - add Mark's ack to patch #4
> >
> 
> NOTE: I have omitted the relative kallsyms and relative extable
> patches, since they already queued in akpm's tree. However, while the
> kallsyms patch is merely an optimization, the extable patches are in
> fact required for correct operation, since the build time sorting does
> not work on absolute extables (this is due to the fact that the
> resolution of the relocations is deferred until runtime, and so the
> extable addresses are all zero at sorting time)
> 
> http://ozlabs.org/~akpm/mmotm/broken-out/extable-add-support-for-relative-extables-to-search-and-sort-routines.patch
> http://ozlabs.org/~akpm/mmotm/broken-out/arm64-switch-to-relative-exception-tables.patch

I'm still trying to get my head around how we merge those. Since I
assume akpm will push them during the merging window, part of your code
cannot be tested before.

Can we deselect CONFIG_BUILDTIME_EXTABLE_SORT temporarily while we use
absolute extable addresses? We patch them at boot-time and sort them
at run-time. Once the above patches go in, we can revert to build-time
extable sorting.

-- 
Catalin
