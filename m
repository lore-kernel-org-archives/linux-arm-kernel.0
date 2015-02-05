From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 5 Feb 2015 10:47:23 +0000
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <20150205104149.GA18158@e104818-lin.cambridge.arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
 <1423066107.18187.99.camel@deneb.redhat.com>
 <20150204175734.GI26006@e104818-lin.cambridge.arm.com>
 <1423076294.18187.103.camel@deneb.redhat.com>
 <20150205104149.GA18158@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-tqY4C0eaRvp5FAzx9PqOGMg+sFNzxr2f25omdJKr7JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 February 2015 at 10:41, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Feb 04, 2015 at 06:58:14PM +0000, Mark Salter wrote:
>> On Wed, 2015-02-04 at 17:57 +0000, Catalin Marinas wrote:
>> > On Wed, Feb 04, 2015 at 04:08:27PM +0000, Mark Salter wrote:
>> > > acpi_os_remap() is used to map ACPI tables. These tables may be in ram
>> > > which are already included in the kernel's linear RAM mapping. So we
>> > > need ioremap_cache to avoid two mappings to the same physical page
>> > > having different caching attributes.
>> >
>> > What's the call path to acpi_os_ioremap() on such tables already in the
>> > linear mapping? I can see an acpi_map() function which already takes
>> > care of the RAM mapping case but there are other cases where
>> > acpi_os_ioremap() is called directly. For example,
>> > acpi_os_read_memory(), can it be called on both RAM and I/O?
>>
>> acpi_map() is the one I've seen.
>
> By default, if should_use_kmap() is not patched for arm64, it translates
> to page_is_ram(); acpi_map() would simply use a kmap() which returns the
> current kernel linear mapping on arm64.
>
>> I'm not sure about others.
>
> Question for the ARM ACPI guys: what happens if you implement
> acpi_os_ioremap() on arm64 as just ioremap()? Do you get any WARN_ON()
> (__ioremap_caller() checks whether the memory is RAM)?
>

Regardless of whether you hit any WARN_ON()s now, we still need to
distinguish between MMIO ranges with device semantics, and ACPI or
other tables whose data may not be naturally aligned all the time, and
hence requiring memory semantics. acpi_os_ioremap() may be used for
both, afaik
