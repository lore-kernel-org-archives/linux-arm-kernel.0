From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 30 Sep 2016 09:41:23 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_EFI
In-Reply-To: <1473949700-12814-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1473949700-12814-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <4ed239b2-e15b-039a-1192-fa21fad883f3@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 15/09/16 15:28, Ard Biesheuvel wrote:
> This enables CONFIG_EFI for multi_v7_defconfig, which adds support for
> booting via EFI, and for the EFI framebuffer as builtin options. It
> also enables the EFI rtc, the EFI variable pseudo-filesystem and the
> EFI capsule loader as modules.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> We have been happily booting multi_v7_defconfig+CONFIG_EFI=y kernels on
> kernelci for months now, so please consider enabling this by default.
> The increase in compressed kernel footprint is ~30 KB, for the uncompressed
> kernel it's ~10 KB, some of which is .init code.

After this patch was applied the Tegra automated building for
multi_v7_defconfig has been failing on -next [0]. The error I am seeing
is as follows ...

  STUBCPY drivers/firmware/efi/libstub/lib-sort.stub.o
00000000 R_ARM_ABS32       sort
00000004 R_ARM_ABS32       __ksymtab_strings
drivers/firmware/efi/libstub/lib-sort.stub.o: absolute symbol references
not allowed in the EFI stub
make[4]: *** [drivers/firmware/efi/libstub/lib-sort.stub.o] Error 1
make[3]: *** [drivers/firmware/efi/libstub] Error 2
make[2]: *** [drivers/firmware/efi] Error 2
make[1]: *** [drivers/firmware] Error 2
make: *** [drivers] Error 2

The toolchain this builder uses (which is quite old admittedly) is ...

arm-linux-gnueabi-gcc (Ubuntu/Linaro 4.7.3-12ubuntu1) 4.7.3

I am not seeing this error on other machines but for the life of me, I
cannot figure out why this one is failing. Any thoughts?

Cheers
Jon

[0] http://nvtb.github.io/linux-next/		

-- 
nvpublic
