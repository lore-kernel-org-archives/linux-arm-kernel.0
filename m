From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 28 Feb 2017 14:01:56 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: enable some newly added crypto
 modules
In-Reply-To: <1487183412-25261-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1487183412-25261-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <68af3dce-14ce-b464-3b75-479759402f8a@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15/02/17 18:30, Ard Biesheuvel wrote:
> Enable the new accelerated CRC32(C), CRC-T10DIF and ChaCha20 drivers
> as modules for multi_v7_defconfig builds.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index b01a43851294..597e56047747 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -936,6 +936,9 @@ CONFIG_CRYPTO_SHA512_ARM=m
>  CONFIG_CRYPTO_AES_ARM=m
>  CONFIG_CRYPTO_AES_ARM_BS=m
>  CONFIG_CRYPTO_AES_ARM_CE=m
> +CONFIG_CRYPTO_CHACHA20_NEON=m
> +CONFIG_CRYPTO_CRC32_ARM_CE=m
> +CONFIG_CRYPTO_CRCT10DIF_ARM_CE=m
>  CONFIG_CRYPTO_GHASH_ARM_CE=m
>  CONFIG_CRYPTO_DEV_ATMEL_AES=m
>  CONFIG_CRYPTO_DEV_ATMEL_TDES=m

Now these are enabled by default, I see the following error ...

AS [M]  arch/arm/crypto/crc32-ce-core.o
arch/arm/crypto/crc32-ce-core.S: Assembler messages:
arch/arm/crypto/crc32-ce-core.S:56: Error: unknown architecture `crc'

arch/arm/crypto/crc32-ce-core.S:138: Error: bad type for scalar -- `vmov dCONSTANTl[0],CRC'
arch/arm/crypto/crc32-ce-core.S:300: Error: bad instruction `crc32w r0,r0,r2'
arch/arm/crypto/crc32-ce-core.S:300: Error: bad instruction `crc32w r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:300: Error: bad instruction `crc32w r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:300: Error: bad instruction `crc32h r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:300: Error: bad instruction `crc32b r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:300: Error: bad instruction `crc32b r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:300: Error: bad instruction `crc32h r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:305: Error: bad instruction `crc32cw r0,r0,r2'
arch/arm/crypto/crc32-ce-core.S:305: Error: bad instruction `crc32cw r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:305: Error: bad instruction `crc32cw r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:305: Error: bad instruction `crc32ch r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:305: Error: bad instruction `crc32cb r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:305: Error: bad instruction `crc32cb r0,r0,r3'
arch/arm/crypto/crc32-ce-core.S:305: Error: bad instruction `crc32ch r0,r0,r3'
scripts/Makefile.build:395: recipe for target 'arch/arm/crypto/crc32-ce-core.o' failed
make[1]: *** [arch/arm/crypto/crc32-ce-core.o] Error 1

Yes this is with an older toolchain that uses an older assembler (GNU assembler
(crosstool-NG linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC 2013.04) 2.23.1),
however, I am curious if older toolchains not supporting the 'crc' arch_extension
are deprecated now?

Cheers
Jon
