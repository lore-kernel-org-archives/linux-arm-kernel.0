From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Sep 2015 16:19:21 -0700
Subject: [PATCH v2 0/7] arm64: relax Image placement rules
In-Reply-To: <CAKv+Gu_YKo+c2rTzxMhjtfQzwix7d=Z33ej7omaJVz620U2efA@mail.gmail.com>
References: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
 <560426BF.4030300@arm.com>
 <CAKv+Gu_YKo+c2rTzxMhjtfQzwix7d=Z33ej7omaJVz620U2efA@mail.gmail.com>
Message-ID: <CAKv+Gu-WGSaGA+4OJcNOct+sdBHsO8yKOc50t3jmB86xonWQ=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 September 2015 at 09:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 24 September 2015 at 09:37, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 23/09/15 01:37, Ard Biesheuvel wrote:
>>>
>>> This is a followup to the "arm64: update/clarify/relax Image and FDT
>>> placement
>>> rules" series I sent a while ago:
>>> (http://article.gmane.org/gmane.linux.ports.arm.kernel/407148)
>>>
>>> This has now been split in two series: this second series deals with the
>>> physical and virtual placement of the kernel Image.
>>>
>>> This series updates the mapping of the kernel Image and the linear mapping
>>> of
>>> system memory to allow more freedom in the choice of placement without
>>> affecting
>>> the accessibility of system RAM below the kernel Image, and the mapping
>>> efficiency (i.e., memory can always be mapped in 512 MB or 1 GB blocks).
>>>
>>
>> Ard,
>>
>> I gave your series a quick run and dumping the kernel page tables(with
>> CONFIG_ARM64_PTDUMP)
>> I find this problem :
>>
>> ...
>>
>> ---[ Kernel Mapping ]---
>> 0xffffffbffc000000-0xffffffbffc600000           6M     RW x  SHD AF
>> MEM/NORMAL    *****
>> 0xffffffbffc600000-0xffffffbffc7f5000        2004K     RW x  SHD AF    UXN
>> MEM/NORMAL
>> 0xffffffbffc7f5000-0xffffffbffc875000         512K     RW NX SHD AF    UXN
>> MEM/NORMAL
>> 0xffffffbffc875000-0xffffffbffca00000        1580K     RW x  SHD AF    UXN
>> MEM/NORMAL
>> ---[ Linear Mapping ]---
>> 0xffffffc000000000-0xffffffc040000000           1G     RW NX SHD AF    UXN
>> MEM/NORMAL
>>
>>
>> Note that the first mapping in the kernel doesn't have UXN set, which is a
>> regression.
>> I haven't started digging into it yet, but I thought I will point it out
>> here, in case you
>> already fixed it.
>>
>
> Ok, thanks for pointing that out. I will look into it.
>

Turns out that, since the kernel mapping is not overwritten by the
linear mapping, it retains the original permissions assigned in
head.S. So this is enough to fix it

"""
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2df4a55f00d4..fcd250cff4bf 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -62,8 +62,8 @@
 /*
  * Initial memory map attributes.
  */
-#define PTE_FLAGS      PTE_TYPE_PAGE | PTE_AF | PTE_SHARED
-#define PMD_FLAGS      PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S
+#define PTE_FLAGS      PTE_TYPE_PAGE | PTE_AF | PTE_SHARED | PTE_UXN
+#define PMD_FLAGS      PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S | PMD_SECT_UXN

 #ifdef CONFIG_ARM64_64K_PAGES
 #define MM_MMUFLAGS    PTE_ATTRINDX(MT_NORMAL) | PTE_FLAGS
"""


>> Note: I see that you have used CONFIG_ARM64_64K_PAGES to handle
>> section/table mapping
>> (which I have tried to cleanup in 16K page size series and which is not
>> merged yet).
>> We should be careful when we merge our patches, as we could miss such new
>> cases.
>>
>
> I was aware of this, and I think it makes sense to the 16 KB pages to
> be merged first, and then I will rebase these patches on top of it.
>

Do you have a git tree with the latest version?
