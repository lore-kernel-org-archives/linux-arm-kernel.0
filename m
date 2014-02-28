From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 28 Feb 2014 12:22:33 -0800
Subject: [PATCH v2 1/9] ARM: centralize common multi-platform kconfig
 options
In-Reply-To: <201402282115.55948.arnd@arndb.de> (Arnd Bergmann's message of
 "Fri, 28 Feb 2014 21:15:55 +0100")
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-2-git-send-email-robherring2@gmail.com>
 <CAGa+x84M++1vetN1fQJYVCc9fBL5HQWc4WJ_6y9Nmst0XHXK8w@mail.gmail.com>
 <201402282115.55948.arnd@arndb.de>
Message-ID: <7h38j3t2ba.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Friday 28 February 2014, Kevin Hilman wrote:
>> On Tue, Feb 11, 2014 at 1:11 PM, Rob Herring <robherring2@gmail.com> wrote:
>> > From: Rob Herring <robh@kernel.org>
>> >
>> > Multi-platform requires various kconfig options to be selected, so
>> > platforms don't need to select them individually.
>> >
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > Cc: Linus Walleij <linus.walleij@linaro.org>
>> > Cc: Russell King <linux@arm.linux.org.uk>
>> 
>> FYI... this recently hit arm-soc/for-next and according to my bisect,
>> is the cause for two new boot failures[1] for sunxi_defconfig on
>> cubieboard and cubie2.  The previous build/boot passed on both
>> boards[2].   Interestingly, both boards boot fine with
>> multi_v7_defconfig though.
>> 
>> There's zero console output on the boards, and I haven't dug further
>> since I still have to pack for a trip tomorrow.
>> 
>> Kevin
>> 
>> [1] http://lists.linaro.org/pipermail/kernel-build-reports/2014-February/002615.html
>> [2] http://lists.linaro.org/pipermail/kernel-build-reports/2014-February/002613.html
>
> I suspect we want this one:
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 7d1588e..cf35d18 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -304,6 +304,7 @@ config ARCH_MULTIPLATFORM
>  	bool "Allow multiple platforms to be selected"
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select AUTO_ZRELADDR
> +	select CLKSRC_OF
>  	select COMMON_CLK
>  	select GENERIC_CLOCKEVENTS
>  	select MULTI_IRQ_HANDLER

Yup, that's it.  With that, sunxi_defconfig is booting again.

Tested-by: Kevin Hilman <khilman@linaro.org>
