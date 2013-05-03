From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 May 2013 13:28:38 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <CACRpkdY+5gdh1G7N+_Spg=iNZ0QMZ=ZXuhsVPuMEt62NxPhRxA@mail.gmail.com>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1367528578-518090-10-git-send-email-arnd@arndb.de>
 <CACRpkdY+5gdh1G7N+_Spg=iNZ0QMZ=ZXuhsVPuMEt62NxPhRxA@mail.gmail.com>
Message-ID: <15723843.9mConxltov@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013 10:14:28 Linus Walleij wrote:
> 
> I do not necessarily agree with this commit message.
> 
> The only mess I see is that this very patch is missing...
> 
> If we look at this:
> 
> config UX500_SOC_DB8500
>         bool
>         select CPU_FREQ_TABLE if CPU_FREQ
>         select MFD_DB8500_PRCMU
>         select PINCTRL_DB8500
>         select PINCTRL_DB8540
>         select PINCTRL_AB8500
>         select PINCTRL_AB8505
>         select PINCTRL_AB9540
>         select PINCTRL_AB8540
>         select REGULATOR
>         select REGULATOR_DB8500_PRCMU
> 
> The PRCMU, the PINCTRL drivers, and the PRCMU regulators
> are necessary to boot the system correctly, by which I mean
> necessary so as not to cause potential damage to the hardware.
> 
> The PRCMU is a system controller without which the system
> cannot really be brought up, and the ABx500's are the PMICs
> which are developed in pair with the SoC and they are in practice
> Siamese twins, there is no chance you can build a Ux500 system
> without both of them. It just won't even start. There are deep
> dependencies between the PRCMU and the ABx500, as the
> PRCMU firmware will talk directly to the ABx500 without the
> kernel intervening. I.e. the whole set of hardware has to be
> there.
> 
> While I understand that from a compile-time point of view it does
> not seem nice, and all things would be separate units that you
> plug in, from a run-time and system architecture point of view it
> makes a lot of sense to select these. Worlds collide...
> 
> Apart from that:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>


If they are completely essential, we should not have an entry
like 

config AB8500_CORE
        bool "ST-Ericsson AB8500 Mixed Signal Power Management chip"
        depends on GENERIC_HARDIRQS && ABX500_CORE && MFD_DB8500_PRCMU
        select POWER_SUPPLY
        select MFD_CORE
        select IRQ_DOMAIN
        help
          Select this option to enable access to AB8500 power management
          chip. This connects to U8500 either on the SSP/SPI bus (deprecated
          since hardware version v1.0) or the I2C bus via PRCMU. It also adds
          the irq_chip parts for handling the Mixed Signal chip events.
          This chip embeds various other multimedia funtionalities as well.

(and more of the same) in drivers/mfd/Kconfig. The rule is that you either
make a Kconfig option user-selectable or make it always selected by another
option.

My preference would be to make it user-selectable and enable it only in
the defconfig, but if that can damage the hardware, we should not actually
provide a named option.

	Arnd
