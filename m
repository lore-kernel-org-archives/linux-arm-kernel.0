From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 27 Oct 2015 11:20:51 +0900
Subject: [PATCH v4 3/3] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <562EAA22.3010905@arm.com>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
 <562EA894.8070505@arm.com> <562EAA22.3010905@arm.com>
Message-ID: <CAKv+Gu-G1YS9Ha=-rtnPKJTOxBTrdSq6=Tqwq_GPW742JUE+2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 October 2015 at 07:33, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 10/26/2015 05:26 PM, Jeremy Linton wrote:
>>
>> On 10/08/2015 02:02 PM, Ard Biesheuvel wrote:
>>>
>>> Since arm64 does not use a builtin decompressor, the EFI stub is built
>>> into the kernel proper. So far, this has been working fine, but actually,
>>> since the stub is in fact a PE/COFF relocatable binary that is executed
>>> at an unknown offset in the 1:1 mapping provided by the UEFI firmware, we
>>> should not be seamlessly sharing code with the kernel proper, which is a
>>> position dependent executable linked at a high virtual offset.
>>
>>
>> This patch appears to be causing a build break
>>
>>   STUBCPY drivers/firmware/efi/libstub/lib-sort.stub.o
>> 0000000000000000 R_AARCH64_ABS64   __efistub___crc_sort
>> drivers/firmware/efi/libstub/lib-sort.stub.o: absolute symbol references
>> not allowed in the EFI stub
>>
>> __kcrctab_sort:
>>      .xword    __crc_sort
>>      .weak    __crc_sort
>>      .text
>>
>>
>> Which is the EXPORT_SYMBOL() in sort.c combined with !CONFIG_MODVERSIONS.
>
>
>         Sorry, I that should be CONFIG_MODVERSIONS..
>

Hi Jeremy,

Thanks for the report. The following patch should fix it

-----------------8<----------------
>From 1179099f89db54294f419493d152083fb8e5af3d Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 27 Oct 2015 11:12:51 +0900
Subject: [PATCH] arm64/efi: fix libstub build under CONFIG_MODVERSIONS

Now that we strictly forbid absolute relocations in libstub code,
make sure that we don't emit any when CONFIG_MODVERSIONS is enabled,
by stripping the kcrctab sections from the object file. This fixes
a build problem under CONFIG_MODVERSIONS=y.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile
b/drivers/firmware/efi/libstub/Makefile
index bca9a76cbd33..acc25d7c5da2 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -51,7 +51,7 @@ lib-$(CONFIG_EFI_ARMSTUB) += arm-stub.o fdt.o string.o \
 extra-$(CONFIG_EFI_ARMSTUB) := $(lib-y)
 lib-$(CONFIG_EFI_ARMSTUB) := $(patsubst %.o,%.stub.o,$(lib-y))

-STUBCOPY_FLAGS-y := -R .debug* -R *ksymtab*
+STUBCOPY_FLAGS-y := -R .debug* -R *ksymtab* -R *kcrctab*
 STUBCOPY_FLAGS-$(CONFIG_ARM64) += --prefix-alloc-sections=.init \
    --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64) := R_AARCH64_ABS
-- 
2.1.4
