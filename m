From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Feb 2016 17:34:11 +0000
Subject: [PATCH v6sub1 00/11] arm64: split linear and kernel mappings
In-Reply-To: <CAKv+Gu-3y9LoxM9swbwZuXXxuMppnWzd=PmyALa+P0NhvR7mtw@mail.gmail.com>
References: <1455627162-31600-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160218182509.GG2538@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_UqoYB5QAWOU9_iZDoRO=rqHu8o87JboSAqNqOhoOCXw@mail.gmail.com>
 <CAKv+Gu_25mz37gdgVx5Yz7DJ+QbOMNa4rYBymFL1nL7nGOzBVQ@mail.gmail.com>
 <CAKv+Gu8aKDtev2LdGMy9a485Z8S7TYgsbXky6wR6e3F+j2nkUQ@mail.gmail.com>
 <20160219142551.GA12864@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_44=2NMuon694T_YW6QUU-ixC+q_7WxbMtBuN3dRNP2Q@mail.gmail.com>
 <CAKv+Gu9WTVrYmc7GwxDeHppSHoRmSS4nK5iG3HZVMOPcPP1MOw@mail.gmail.com>
 <20160219143701.GB12864@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-3y9LoxM9swbwZuXXxuMppnWzd=PmyALa+P0NhvR7mtw@mail.gmail.com>
Message-ID: <20160219173411.GE12864@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 03:40:32PM +0100, Ard Biesheuvel wrote:
> On 19 February 2016 at 15:37, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Feb 19, 2016 at 03:29:13PM +0100, Ard Biesheuvel wrote:
> >> On 19 February 2016 at 15:27, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> > On 19 February 2016 at 15:25, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> >> On Fri, Feb 19, 2016 at 09:05:25AM +0100, Ard Biesheuvel wrote:
> >> >>> So it appears that akpm will need to drop that patch anyway, as he
> >> >>> won't be able to carry an updated version since he does not have the
> >> >>> UAO patches. That means it probably makes even more sense to take
> >> >>> those through the arm64 tree as well (minus the x86 one, which has a
> >> >>> conflict now as well). In fact, perhaps it makes sense to only take
> >> >>> the base patch and the arm64 patch, and I can send the remaining ones
> >> >>> to the various maintainers (or akpm) for v4.7
> >> >>
> >> >> Or we make BUILDTIME_EXTABLE_SORT depend on !RANDOMIZE_BASE until we
> >> >> sort out the extable patches.
> >> >
> >> > That would still result in breakage once the current version queued by
> >> > akpm hits mainline.
> >>
> >> ... or in other words, the breakage is already in -next. This is
> >> completely unrelated to the sorting, btw, but due to the difference
> >> between relative/absolute
> >
> > Ah, I now realised that it was only working fine for me before merging
> > the EFI patches to actually do the base randomisation. Once we fully
> > randomise the load address, we must have relative extable.
> >
> > Is your branch updated with the patches needed for arm64 (against
> > for-next/core)?
> 
> Yes. I dropped the kallsyms patches, and included only the base and
> arm64 extable patches, with the UAO issue fixed.
> 
> https://git.linaro.org/people/ard.biesheuvel/linux-arm.git/shortlog/refs/heads/arm64-kaslr-v6
> git://git.linaro.org/people/ard.biesheuvel/linux-arm.git arm64-kaslr-v6

I pushed these patches to the arm64 for-next/kaslr for now, rebased
against the latest for-next/core branch. There was one commit
(e9ee71275034 arm64: add support for module PLTs) which inadvertently
got some extra information in the log but I found it useful, so I kept
it. If nothing else falls, I'll push them into -next on Monday.

I noticed that we still have MODULES_VADDR around and used in couple of
places (printing the kernel memory layout during init, debugfs
kernel_page_tables and KASAN). Shouldn't we use module_alloc_base
instead?

-- 
Catalin
