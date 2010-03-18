From: konkers@google.com (Erik Gilling)
Date: Wed, 17 Mar 2010 19:19:48 -0700
Subject: [RFC/PATCH 06/10] [ARM] tegra: add GPIO support
In-Reply-To: <4BA08F98.4050904@compulab.co.il>
References: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
	<1268721688-27550-1-git-send-email-konkers@google.com>
	<1268721688-27550-2-git-send-email-konkers@google.com>
	<1268721688-27550-3-git-send-email-konkers@google.com>
	<1268721688-27550-4-git-send-email-konkers@google.com>
	<1268721688-27550-5-git-send-email-konkers@google.com>
	<1268721688-27550-6-git-send-email-konkers@google.com>
	<1268721688-27550-7-git-send-email-konkers@google.com>
	<4BA08F98.4050904@compulab.co.il>
Message-ID: <4344f3c71003171919p5aa841d9k17205eee067f3109@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 1:15 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> konkers at google.com wrote:
>> +void tegra_gpio_enable(int gpio)
>> +{
>> + ? ? ? tegra_gpio_mask_write(GPIO_MSK_CNF(gpio), gpio, 1);
>> +}
>> +
>> +void tegra_gpio_disable(int gpio)
>> +{
>> + ? ? ? tegra_gpio_mask_write(GPIO_MSK_CNF(gpio), gpio, 0);
>> +}
>
> Can you please elaborate why these two are required? They are not referenced
> anywhere ...

These are needed to switch a pin/pad from peripheral mode to gpio
mode.  Since tegra does peripheral muxing by pingroup but gpio muxing
by pin this does not fit into the pinmux code.  It's intended to be
used in board files much like pin muxing.

>> +++ b/arch/arm/mach-tegra/include/mach/gpio-names.h
>
> I'm still not convinced that gpio-names.h is needed, although it may be
> hadny for board gpio defines. Anyway, I'd put it into arch/arm/mach-tegra
> rather than arch/arm/mach-tegra/include/mach because ?it shouldn't be
> available for anything except arch/arm/mach-tegra.

The tegra architecture does not define GPIOs numerically so treating
them as integers has no useful meaning.  It's true that these should
only be used in the board files.  I'll move the file into
arch/arm/mach-tegra.

-Erik
