From: andrea.adami@gmail.com (Andrea Adami)
Date: Thu, 6 May 2010 11:04:31 +0200
Subject: [PATCH v2] ARM: Add support for LZMA-compressed kernel images
In-Reply-To: <4BAB2552.9070704@gmail.com>
References: <1258729323-16318-1-git-send-email-albin.tonnerre@free-electrons.com>
	<1268335467-24223-1-git-send-email-albin.tonnerre@free-electrons.com>
	<4BAB2552.9070704@gmail.com>
Message-ID: <x2nd1b08f941005060204j3bbf3fc9z11cc4325a20bdb82@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 10:56 AM, Paulius Zaleckas
<paulius.zaleckas@gmail.com> wrote:
> On 03/11/2010 09:24 PM, Albin Tonnerre wrote:
>>
>> This patch allows using a kernel image compressed with LZMA on ARM.
>> Extracting the image is fairly slow, but it might be useful on machines
>> with a very limited amount of storage, as the size benefit is quite
>> significant:
>> Gzip: Data Size: ? ?1586352 Bytes = 1549.17 kB = 1.51 MB
>> LZMA: Data Size: ? ?2135916 Bytes = 2085.86 kB = 2.04 MB
>>
>> Signed-off-by: Albin Tonnerre<albin.tonnerre@free-electrons.com>
>> Tested-by: Martin Michlmayr<tbm@cyrius.com>
>
> You can add
> Tested-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
>
> I think you should submit this patch to Russell's patch system.
>
>> ---
>> v2: Updated to apply on top of 2.6.34-rc1
>>
>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/boot/compressed/Makefile ? ? | ? ?1 +
>> ?arch/arm/boot/compressed/decompress.c | ? ?4 ++++
>> ?arch/arm/boot/compressed/piggy.lzma.S | ? ?6 ++++++
>> ?4 files changed, 12 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/boot/compressed/piggy.lzma.S
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 3b18128..3ebc7c3 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -21,6 +21,7 @@ config ARM
>> ? ? ? ?select HAVE_GENERIC_DMA_COHERENT
>> ? ? ? ?select HAVE_KERNEL_GZIP
>> ? ? ? ?select HAVE_KERNEL_LZO
>> + ? ? ? select HAVE_KERNEL_LZMA
>> ? ? ? ?select HAVE_PERF_EVENTS
>> ? ? ? ?select PERF_USE_VMALLOC
>> ? ? ? ?help
>> diff --git a/arch/arm/boot/compressed/Makefile
>> b/arch/arm/boot/compressed/Makefile
>> index 97c89e7..53faa90 100644
>> --- a/arch/arm/boot/compressed/Makefile
>> +++ b/arch/arm/boot/compressed/Makefile
>> @@ -65,6 +65,7 @@ SEDFLAGS ? ? ?=
>> s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
>>
>> ?suffix_$(CONFIG_KERNEL_GZIP) = gzip
>> ?suffix_$(CONFIG_KERNEL_LZO) ?= lzo
>> +suffix_$(CONFIG_KERNEL_LZMA) = lzma
>>
>> ?targets ? ? ? := vmlinux vmlinux.lds \
>> ? ? ? ? ? ? ? ? piggy.$(suffix_y) piggy.$(suffix_y).o \
>> diff --git a/arch/arm/boot/compressed/decompress.c
>> b/arch/arm/boot/compressed/decompress.c
>> index 0da382f..d554df6 100644
>> --- a/arch/arm/boot/compressed/decompress.c
>> +++ b/arch/arm/boot/compressed/decompress.c
>> @@ -39,6 +39,10 @@ extern void error(char *);
>> ?#include "../../../../lib/decompress_unlzo.c"
>> ?#endif
>>
>> +#ifdef CONFIG_KERNEL_LZMA
>> +#include "../../../../lib/decompress_unlzma.c"
>> +#endif
>> +
>> ?void do_decompress(u8 *input, int len, u8 *output, void (*error)(char
>> *x))
>> ?{
>> ? ? ? ?decompress(input, len, NULL, NULL, output, NULL, error);
>> diff --git a/arch/arm/boot/compressed/piggy.lzma.S
>> b/arch/arm/boot/compressed/piggy.lzma.S
>> new file mode 100644
>> index 0000000..d7e69cf
>> --- /dev/null
>> +++ b/arch/arm/boot/compressed/piggy.lzma.S
>> @@ -0,0 +1,6 @@
>> + ? ? ? .section .piggydata,#alloc
>> + ? ? ? .globl ?input_data
>> +input_data:
>> + ? ? ? .incbin "arch/arm/boot/compressed/piggy.lzma"
>> + ? ? ? .globl ?input_data_end
>> +input_data_end:
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Any reason to further delay the LZMA adoption?
It will not be the fastest decompressor, but gives the smallest kernel size.
Tested on various Zaurus models (pxa255, pxa270, armv4).

Regards

Andrea Adami

P.S. Fixes to .gitignore would need to be added for lzma.
