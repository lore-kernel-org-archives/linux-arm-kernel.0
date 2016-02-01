From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 1 Feb 2016 17:31:11 +0100
Subject: [PATCH v5sub1 8/8] arm64: allow kernel Image to be loaded
 anywhere in physical memory
In-Reply-To: <CAKv+Gu8rgkBWfJXfWzWSkxyKhLOnxirycu-wdcmvRovpDB5hKw@mail.gmail.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-9-git-send-email-ard.biesheuvel@linaro.org>
 <20160201150624.GG15514@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8rgkBWfJXfWzWSkxyKhLOnxirycu-wdcmvRovpDB5hKw@mail.gmail.com>
Message-ID: <CAKv+Gu8+DdtGQmZtKsB8YOabH1NfzSJge=w0vQwFZPwbQkgYzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2016 at 16:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 1 February 2016 at 16:06, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Mon, Feb 01, 2016 at 11:54:53AM +0100, Ard Biesheuvel wrote:
>>> Note that limiting memory using mem= is not unambiguous anymore after
>>> this change, considering that the kernel may be at the top of physical
>>> memory, and clipping from the bottom rather than the top will discard
>>> any 32-bit DMA addressable memory first. To deal with this, the handling
>>> of mem= is reimplemented to clip top down, but take special care not to
>>> clip memory that covers the kernel image.
>>
>> I may have forgotten the reason - why do we need to avoid clipping the
>> memory that covers the kernel image? It's already mapped in the vmalloc
>> area, so we wouldn't need it in the linear map as well.
>>
>
> Good question. Originally, I needed it for swapper_pg_dir, whose
> pud/pmd/pte levels were accessed via __va() translations of the values
> found in the higher-up table entries, but after Mark's patches, only
> the top level pgd of swapper_pg_dir is still used. Similarly, for
> idmap_pg_dir, we don't change any mappings at runtime so the same
> applies there I think.
>
> I will try dropping this, and see what happens.
>

I have given this a spin, and this chokes on
a) the fact that not all of the translation tables are accessible via
the linear mapping: the fixmap, due to its vicinity to PCI i/o and
other populated regions, will share its pud/pmd level tables with
other users, like ioremap, which traverses the translation tables in
the ordinary way, i.e., it expects that __va() applied on the phys
address in the table entry returns something that is mapped
b) free_initmem() now calls __free_pages() on a region that we never
mapped or registered as available.

So it may be feasible with some hackery, but I wonder if it is worth
it to complicate the common case for implementing mem= more
efficiently.

-- 
Ard.
