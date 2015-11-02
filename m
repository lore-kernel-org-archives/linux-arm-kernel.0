From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 2 Nov 2015 20:47:09 +0900
Subject: [PATCH 1/2] pinctrl: uniphier: enable UniPhier SoCs pinctrl
 drivers by default
In-Reply-To: <20151031014110.GA1991@localhost>
References: <1445912911-1292-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdY4hs_7dE2KicDeUj7hvbKmHu3pcwQO3eshTtSmzH2PGA@mail.gmail.com>
 <20151031014110.GA1991@localhost>
Message-ID: <CAK7LNARaHE5NU=Q2LwEGChV6BiN02s9KbiUztDJ-d7kf9Zcd9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,


2015-10-31 10:41 GMT+09:00 Olof Johansson <olof@lixom.net>:
> On Thu, Oct 29, 2015 at 02:33:34PM +0100, Linus Walleij wrote:
>> On Tue, Oct 27, 2015 at 3:28 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>
>> > Add "default y" to the Kconfig rather than adding entries into
>> > arch/arm/configs/multi_v7_defconfig.
>> >
>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> (...)
>> > config PINCTRL_UNIPHIER_PH1_LD4
>> >         tristate "UniPhier PH1-LD4 SoC pinctrl driver"
>> > +       default y
>> >         select PINCTRL_UNIPHIER_CORE
>>
>> Why is it not default y if <PH1_LD4_SOC_THING>?
>>
>> So it is only turned on if the corresponding SoC is selected?
>>
>> Or don't you have symbols like that?
>>
>> ARM SoC folks: can you ACK this patch indicating that this is the way
>> you wanna handle this?
>
> Most other will have a "default MACH_<foo>", but Uniphier lacks those Kconfig
> symbols. Or even a def_bool for that platform such that it's not an option if
> the platform is enabled. It makes no sense to enable a platform but not the
> pinctrl on it, so that's a good way to do it.
>
> I would honestly rather have those in the mach makefile, and make the drivers
> select the right thing by default, than having to know exactly which drivers to
> enable for a specific SoC.

I have a question.


Most of sub-architectures define per-SoC options in their mach-<>/Kconfig,but
some of them enable DTBs per SoC-family.


For example,

arch/arm/mach-exynos/Kconfig define SoC options.


So,

dtb-$(CONFIG_ARCH_EXYNOS5) += \
        exynos5250-arndale.dtb \
        exynos5250-smdk5250.dtb \
        exynos5250-snow.dtb \
        exynos5250-spring.dtb \
        exynos5260-xyref5260.dtb \
        exynos5410-smdk5410.dtb \
        exynos5420-arndale-octa.dtb \
        exynos5420-peach-pit.dtb \
        exynos5420-smdk5420.dtb \
        exynos5422-odroidxu3.dtb \
        exynos5422-odroidxu3-lite.dtb \
        exynos5440-sd5v1.dtb \
        exynos5440-ssdk5440.dtb \
        exynos5800-peach-pi.dtb

should be like follows?

dtb-$(CONFIG_SOC_EXYNOS5250) += \
        exynos5250-arndale.dtb \
        exynos5250-smdk5250.dtb \
        exynos5250-snow.dtb \
        exynos5250-spring.dtb
dtb-$(CONFIG_SOC_EXYNOS5260) += \
        exynos5260-xyref5260.dtb
dtb-$(CONFIG_SOC_EXYNOS5410) += \
        exynos5410-smdk5410.dtb
dtb-$(CONFIG_SOC_EXYNOS5420) += \
        exynos5420-arndale-octa.dtb \
        exynos5420-peach-pit.dtb \
        exynos5420-smdk5420.dtb \
        exynos5422-odroidxu3.dtb \
        exynos5422-odroidxu3-lite.dtb
dtb-$(CONFIG_SOC_EXYNOS5440) += \
        exynos5440-sd5v1.dtb \
        exynos5440-ssdk5440.dtb
dtb-$(CONFIG_SOC_EXYNOS5800) += \
        exynos5800-peach-pi.dtb




Likewise for Mediatek DTBs?

dtb-$(CONFIG_ARCH_MEDIATEK) += \
        mt6580-evbp1.dtb \
        mt6589-aquaris5.dtb \
        mt6592-evb.dtb \
        mt8127-moose.dtb \
        mt8135-evbp1.dtb




-- 
Best Regards
Masahiro Yamada
