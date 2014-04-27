From: gnurou@gmail.com (Alexandre Courbot)
Date: Sun, 27 Apr 2014 19:09:31 +0900
Subject: randconfig failures - MMC + trusted foundations
In-Reply-To: <20140427093250.GA26756@n2100.arm.linux.org.uk>
References: <20140427093250.GA26756@n2100.arm.linux.org.uk>
Message-ID: <CAAVeFuJ2=fWamF6xBAJLv1kEEhBVgWMj-PY0gxouo6-NOE9OfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sun, Apr 27, 2014 at 6:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Last night's omap4430-sdp randconfig build:
>
> In file included from arch/arm/mach-tegra/tegra.c:43:0:
> arch/arm/include/asm/trusted_foundations.h: In function 'register_trusted_foundations':
> arch/arm/include/asm/trusted_foundations.h:57:2: error: 'setup_max_cpus' undeclared (first use in this function)

Just sent you a patch to fix this. Thanks for reporting.

> Last night's versatile randconfig build:
>
> drivers/mmc/core/core.c: In function 'mmc_card_power_up':
> drivers/mmc/core/core.c:1517:4: error: implicit declaration of function 'gpiod_set_value'
>
> This one appears to be a regular feature of failure, and is as I'm
> carrying Olof's "mmc: add support for power-on sequencing through DT"
> patch for CuBox wireless - see the 222 patch set.  It probably points
> at something not being right with GPIO stuff.

I had a quick look at the patch and I would say this is happening
because drivers/mmc/core/core.c does not include
<linux/gpio/consumer.h> despite using the gpiod_* functions. The error
will only happen if CONFIG_GPIOLIB is not defined. Olof, if it is not
too late can you fix this in your patch series?

Cheers,
Alex.
