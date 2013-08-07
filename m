From: gerg@uclinux.org (Greg Ungerer)
Date: Wed, 07 Aug 2013 17:25:36 +1000
Subject: [PATCH] mach-ks8695/Kconfig: Make MACH_KS8695 depends on PCI
In-Reply-To: <CAJFYCKErP_epEY6EbcK3trBWOHGW_EU6usuAwwnaDXk_maHsCA@mail.gmail.com>
References: <1375693624-21548-1-git-send-email-manjunath.goudar@linaro.org>
 <CAKohpomo-J1Y_Zf8OLCCvrgfqi7m7tBju=rPp9+wuDAYL_-x7g@mail.gmail.com>
 <CAJFYCKHVb7EXiYPDBACotSc8bwnBM4bTXvtV-Fr=F2MonV7rKg@mail.gmail.com>
 <52005A46.4090306@uclinux.org>
 <CAJFYCKErP_epEY6EbcK3trBWOHGW_EU6usuAwwnaDXk_maHsCA@mail.gmail.com>
Message-ID: <5201F670.4040409@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manjunath,

On 06/08/13 20:43, Manjunath Goudar wrote:
> On 6 August 2013 07:37, Greg Ungerer <gerg at uclinux.org <mailto:gerg@uclinux.org>> wrote:
>     On 05/08/13 20:31, Manjunath Goudar wrote:
>     > On 5 August 2013 14:47, Viresh Kumar <viresh.kumar at linaro.org <mailto:viresh.kumar@linaro.org> <mailto:viresh.kumar at linaro.org <mailto:viresh.kumar@linaro.org>>> wrote:
>     >
>     >     On 5 August 2013 14:37, Manjunath Goudar <manjunath.goudar at linaro.org <mailto:manjunath.goudar@linaro.org> <mailto:manjunath.goudar at linaro.org <mailto:manjunath.goudar@linaro.org>>> wrote:
>     >     > From: root <root at si-cspbld63.lge.net <mailto:root@si-cspbld63.lge.net> <mailto:root at si-cspbld63.lge.net <mailto:root@si-cspbld63.lge.net>>>
>     >
>     >     :)
>     >
>     >     > This patch adds a Kconfig dependency on MACH_KS8695,MACH_CM* or MACH_IM*
>     >     > being available before PCI can be enabled. Without this patch,build system
>     >
>     >     Add Space after ','
>     >
>     >     > can lead to issues. This was discovered during randconfig testing,
>     >     > without PCI if any one of MACH_KS8695,MACH_CM* or MACH_IM* being enabled,
>     >
>     >     Same here.
>     >
>     >     > leading to the following error:
>     >     >
>     >     > LD      init/built-in.o
>     >     > arch/arm/mach-ks8695/built-in.o: In function `og_register_pci':
>     >     > arch/arm/mach-ks8695/board-og.c:47:undefined reference to `ks8695_init_pci'
>     >     > make: *** [vmlinux] Error 1
>     >     >
>     >     > Signed-off-by: Manjunath Goudar <manjunath.goudar at linaro.org <mailto:manjunath.goudar@linaro.org> <mailto:manjunath.goudar at linaro.org <mailto:manjunath.goudar@linaro.org>>>
>     >     > Cc: Arnd Bergmann <arnd at arndb.de <mailto:arnd@arndb.de> <mailto:arnd at arndb.de <mailto:arnd@arndb.de>>>
>     >     > Cc: Deepak Saxena <dsaxena at linaro.org <mailto:dsaxena@linaro.org> <mailto:dsaxena at linaro.org <mailto:dsaxena@linaro.org>>>
>     >     > Cc: Greg Ungerer <gerg at uclinux.org <mailto:gerg@uclinux.org> <mailto:gerg at uclinux.org <mailto:gerg@uclinux.org>>>
>     >     > Cc: linux-arm-kernel at lists.infradead.org <mailto:linux-arm-kernel@lists.infradead.org> <mailto:linux-arm-kernel at lists.infradead.org <mailto:linux-arm-kernel@lists.infradead.org>>
>     >     > ---
>     >     >  arch/arm/mach-ks8695/Kconfig | 5 +++++
>     >     >  1 file changed, 5 insertions(+)
>     >     >
>     >     > diff --git a/arch/arm/mach-ks8695/Kconfig b/arch/arm/mach-ks8695/Kconfig
>     >     > index a545976..29d7d9f 100644
>     >     > --- a/arch/arm/mach-ks8695/Kconfig
>     >     > +++ b/arch/arm/mach-ks8695/Kconfig
>     >     > @@ -5,6 +5,7 @@ menu "Kendin/Micrel KS8695 Implementations"
>     >     >  config MACH_KS8695
>     >     >         bool "KS8695 development board"
>     >     >         select MIGHT_HAVE_PCI
>     >     > +       depends on PCI
>     >
>     >     You need both PCI and MIGHT_HAVE_PCI? Don't know but it looks
>     >     like defconfig is missing PCI stuff.. and MIGHT_HAVE_PCI is enough
>     >     here?
>     >
>     >
>     >  PCI is needed here because board-og.c file depends on pci.o.
> 
>     It shouldn't though, thus the original use of MIGHT_HAVE_PCI.
>     The board-og.c machine code supports a number of boards, some of
>     which don't have a PCI bus (that is they use the KS8695 CPU that
>     doesn't contain the PCI bus silicon).
> 
>     I think you want a fix that makes the pci support code in this file
>     conditional on CONFIG_PCI.
> 
> You are suggesting me,as below
> 
>  +#ifdef CONFIG_PCI      
>         ks8695_init_pci(&og_pci);
> +#endif

Yes, in this case I think you will need something like this.

Regards
Greg
