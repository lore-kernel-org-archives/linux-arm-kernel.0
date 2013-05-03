From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 10:14:28 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <1367528578-518090-10-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1367528578-518090-10-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdY+5gdh1G7N+_Spg=iNZ0QMZ=ZXuhsVPuMEt62NxPhRxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 2, 2013 at 11:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The use of 'select' in the ux500 platform is a huge mess, we should
> not be selecting most of the drivers that are currently selected
> there, but rather enable them from the defconfig.
>
> As a fixup for 3.10, let's at least select the dependencies for
> the other drivers we already select, to make it consistent.
>
> warning: (UX500_SOC_COMMON) selects AB8500_CORE which has unmet direct dependencies (HAS_IOMEM && GENERIC_HARDIRQS && ABX500_CORE && MFD_DB8500_PRCMU)
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I do not necessarily agree with this commit message.

The only mess I see is that this very patch is missing...

If we look at this:

config UX500_SOC_DB8500
        bool
        select CPU_FREQ_TABLE if CPU_FREQ
        select MFD_DB8500_PRCMU
        select PINCTRL_DB8500
        select PINCTRL_DB8540
        select PINCTRL_AB8500
        select PINCTRL_AB8505
        select PINCTRL_AB9540
        select PINCTRL_AB8540
        select REGULATOR
        select REGULATOR_DB8500_PRCMU

The PRCMU, the PINCTRL drivers, and the PRCMU regulators
are necessary to boot the system correctly, by which I mean
necessary so as not to cause potential damage to the hardware.

The PRCMU is a system controller without which the system
cannot really be brought up, and the ABx500's are the PMICs
which are developed in pair with the SoC and they are in practice
Siamese twins, there is no chance you can build a Ux500 system
without both of them. It just won't even start. There are deep
dependencies between the PRCMU and the ABx500, as the
PRCMU firmware will talk directly to the ABx500 without the
kernel intervening. I.e. the whole set of hardware has to be
there.

While I understand that from a compile-time point of view it does
not seem nice, and all things would be separate units that you
plug in, from a run-time and system architecture point of view it
makes a lot of sense to select these. Worlds collide...

Apart from that:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
