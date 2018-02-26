From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Feb 2018 09:43:26 +0100
Subject: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
In-Reply-To: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 24, 2018 at 3:50 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
> used with care - it forces a lower limit of another symbol, ignoring
> the dependency.
>
> MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
> select it.
>
> This causes unmet dependencies for architecture without HAS_IOMEM.
>
>   $ make ARCH=score randconfig
>   scripts/kconfig/conf  --randconfig Kconfig
>   KCONFIG_SEED=0x27C47F43
>   warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
>   selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>
> Use 'depends on' to observe the dependency.
>
> This commit was created by the following command:
>
>   $ find drivers -name 'Kconfig*' | xargs sed -i -e \
>     's/select MFD_SYSCON$/depends on MFD_SYSCON/'
>
> Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.
>
> Also, make MFD_SYSCON 'default y' because some defconfig files may
> rely on someone select's MFD_SYSCON.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> If you have a better idea to fix 'unmet dependencies',
> please suggest.

Changing 'select MFD_SYSCON' to 'depends on' will definitely break lots
of defconfig configurations, I'd rather not do that.

Only score, tile and um have some configurations that select 'NO_IOMEM'.
Score is getting removed now, tile might get removed later (we could make
PCI mandatory in the meantime to avoid that configuration), and I think for
um, we already have a workaround for the NO_IOMEM dependencies
(I forget the details).

        Arnd
