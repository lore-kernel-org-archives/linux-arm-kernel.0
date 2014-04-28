From: javi.merino@arm.com (Javi Merino)
Date: Mon, 28 Apr 2014 11:55:11 +0100
Subject: [PATCH] ARM: dts: Remove vmmc-supply for mmc@12220000 on
 arndale-octa board
In-Reply-To: <CAK9yfHz5bkyTUr3Y=q8msuY_ciAjv5=n7dtf7DhTwgDxntOMNQ@mail.gmail.com>
References: <1398456672-3936-1-git-send-email-javi.merino@arm.com>
 <535AC29E.8010905@gmail.com>
 <20140425203051.GD3027@e102654-lin.cambridge.arm.com>
 <535AC717.40805@gmail.com>
 <20140425204135.GF3027@e102654-lin.cambridge.arm.com>
 <0b5c01cf6141$687f5ea0$397e1be0$@samsung.com>
 <CAK9yfHz5bkyTUr3Y=q8msuY_ciAjv5=n7dtf7DhTwgDxntOMNQ@mail.gmail.com>
Message-ID: <20140428105511.GA17293@e102654-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On Mon, Apr 28, 2014 at 05:30:19AM +0100, Sachin Kamat wrote:
> On 26 April 2014 16:49, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Javi Merino wrote:
> >>
> >> On Fri, Apr 25, 2014 at 09:35:35PM +0100, Tomasz Figa wrote:
> >> > On 25.04.2014 22:30, Javi Merino wrote:
> >> > > On Fri, Apr 25, 2014 at 09:16:30PM +0100, Tomasz Figa wrote:
> >> > >> On 25.04.2014 22:11, Javi Merino wrote:
> >> > >>> d726ca2d3316 (ARM: dts: Add vmmc-supply to MMC on arndale-octa board)
> >> > >>> added the vmmc-supply to nodes mmc at 12200000 and mmc at 12220000 of the
> >> > >>> DT.  However, this makes the kernel fail to boot on the arndale-octa
> >> > >>> spews:
> >> > >>>
> >> > >>> [    5.060000] dwmmc_exynos 12200000.mmc: num-slots property not
> >> found, assuming 1 slot is available
> >> > >>> [    5.065000] platform 12200000.mmc: Driver dwmmc_exynos requests
> >> probe deferral
> >> > >>> [    5.075000] dwmmc_exynos 12220000.mmc: num-slots property not
> >> found, assuming 1 slot is available
> >> > >>> [    5.085000] platform 12220000.mmc: Driver dwmmc_exynos requests
> >> probe deferral
> >> > >>>
> >> > >>> And eventually hangs.  Without the vmmc-supply property in the
> >> > >>> mmc at 12220000 node, the kernel boots again.
> >> > >>>
> >> > >>> Signed-off-by: Javi Merino <javi.merino@arm.com>
> >> > >>> ---
> >> > >>>
> >> > >>> Hi,
> >> > >>>
> >> > >>> Note that I don't know *why* removing the property works, all I know
> >> > >>> is that 3.15-rc2 fails to boot on my Arndale Octa unless I apply
> >> this
> >> > >>> patch.
> >> > >>
> >> > >> Are you sure you have the required PMIC driver enabled in your kernel
> >> > >> config?
> >> > >
> >> > > I configured the kernel using exynos_defconfig and that gives me:
> >> > >
> >> > > # CONFIG_PMIC_ADP5520 is not set
> >> > > # CONFIG_PMIC_DA903X is not set
> >> > >
> >> > > Should I be using other defconfig for this board?  exynos_defconfig
> >> > > used to work in 3.14.  Cheers,
> >> >
> >> > Well, unfortunately exynos_defconfig is known to be far from being
> >> > reasonable. Right now it should be considered just as a base to
> >> > configure the kernel for Exynos SoCs. Most of board specific options
> >> > (and many of SoC-wide ones) need to be selected manually.
> >> >
> >> > Anyway, with the number of Exynos boards supported in mainline, I don't
> >> > think we will be ever going to enable all options for all the supported
> >> > boards by default in defconfig, especially considering the fact that we
> >> > will be moving to generic multi_v7_defconfig and likely dropping
> >> > exynos_defconfig completely.
> >
> > Well, keeping exynos_defconfig would be helpful even if exynos multiplatform is available. Please see the case of omap2plus_defconfig?
> >
> >> >
> >> > As for now, I believe you should just make sure yourself that any
> >> > options relevant to your board are enabled.
> >>
> >> Great.  And I assume that there isn't a list of those options in the
> >> web.  So how do I know what options are relevant to my board?  By
> >> sending emails to linux-samsung-soc whenever it fails to boot?
> >>
> > I think, we need to enable all of regarding configs for each exynos boards so that exynos_defconfig can cover whenever.
> 
> You need the following patch to mount the MMC. Without this the regulator will
> not be enabled which is required by MMC.
> 
> ARM: exynos_defconfig: Enable HS-I2C
> http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/27527

Yes, that's the bit that I was missing.  With that patch 3.15-rc2
boots on my Arndale Octa.

> Kukjin, can you please apply this patch?

You can add my Tested-by for Arndale Octa.

Thanks!
Javi
