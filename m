From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 19 Feb 2016 15:29:13 +0100
Subject: [PATCH v6sub1 00/11] arm64: split linear and kernel mappings
In-Reply-To: <CAKv+Gu_44=2NMuon694T_YW6QUU-ixC+q_7WxbMtBuN3dRNP2Q@mail.gmail.com>
References: <1455627162-31600-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160218182509.GG2538@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_UqoYB5QAWOU9_iZDoRO=rqHu8o87JboSAqNqOhoOCXw@mail.gmail.com>
 <CAKv+Gu_25mz37gdgVx5Yz7DJ+QbOMNa4rYBymFL1nL7nGOzBVQ@mail.gmail.com>
 <CAKv+Gu8aKDtev2LdGMy9a485Z8S7TYgsbXky6wR6e3F+j2nkUQ@mail.gmail.com>
 <20160219142551.GA12864@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_44=2NMuon694T_YW6QUU-ixC+q_7WxbMtBuN3dRNP2Q@mail.gmail.com>
Message-ID: <CAKv+Gu9WTVrYmc7GwxDeHppSHoRmSS4nK5iG3HZVMOPcPP1MOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2016 at 15:27, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 19 February 2016 at 15:25, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Fri, Feb 19, 2016 at 09:05:25AM +0100, Ard Biesheuvel wrote:
>>> On 18 February 2016 at 20:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> > On 18 February 2016 at 19:27, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> >> On 18 February 2016 at 19:25, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>> >>> On Tue, Feb 16, 2016 at 01:52:31PM +0100, Ard Biesheuvel wrote:
>>> >>>> Ard Biesheuvel (11):
>>> >>>>   of/fdt: make memblock minimum physical address arch configurable
>>> >>>>   of/fdt: factor out assignment of initrd_start/initrd_end
>>> >>>>   arm64: prevent potential circular header dependencies in asm/bug.h
>>> >>>>   arm64: add support for ioremap() block mappings
>>> >>>>   arm64: introduce KIMAGE_VADDR as the virtual base of the kernel region
>>> >>>>   arm64: pgtable: implement static [pte|pmd|pud]_offset variants
>>> >>>>   arm64: decouple early fixmap init from linear mapping
>>> >>>>   arm64: kvm: deal with kernel symbols outside of linear mapping
>>> >>>>   arm64: move kernel image to base of vmalloc area
>>> >>>>   arm64: defer __va translation of initrd_start and initrd_end
>>> >>>>   arm64: allow kernel Image to be loaded anywhere in physical memory
>>> >>>
>>> >>> I queued this patches (again) for 4.6. I'll wait a few days with the
>>> >>> rest of KASLR until these get a bit more coverage in -next.
>>> >>>
>>> >
>>> > I rebased the remaining patches onto for-next/core, and pushed it here:
>>> > https://git.linaro.org/people/ard.biesheuvel/linux-arm.git/shortlog/refs/heads/arm64-kaslr-v6
>>> >
>>> > I need to check if everything still works, and if it does, I will send
>>> > them out as v6sub2
>>> > Note that I have included the arm64 extable patch plus its generic
>>> > dependency, and the kallsyms patches as well. We can decide later how
>>> > to proceed with those, but for now, I included them for completeness.
>>>
>>> OK, as it turns out, my arm64/extable patch conflicts with the UAO
>>> patches that are now in for-next/core, not textually, but those
>>> patches add additional absolute extable entries that need to be
>>> updated to relative as well.
>>
>> I noticed this as well while testing KASLR.
>>
>>> So it appears that akpm will need to drop that patch anyway, as he
>>> won't be able to carry an updated version since he does not have the
>>> UAO patches. That means it probably makes even more sense to take
>>> those through the arm64 tree as well (minus the x86 one, which has a
>>> conflict now as well). In fact, perhaps it makes sense to only take
>>> the base patch and the arm64 patch, and I can send the remaining ones
>>> to the various maintainers (or akpm) for v4.7
>>
>> Or we make BUILDTIME_EXTABLE_SORT depend on !RANDOMIZE_BASE until we
>> sort out the extable patches.
>>
>
> That would still result in breakage once the current version queued by
> akpm hits mainline.

... or in other words, the breakage is already in -next. This is
completely unrelated to the sorting, btw, but due to the difference
between relative/absolute
