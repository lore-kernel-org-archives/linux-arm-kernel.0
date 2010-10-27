From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 27 Oct 2010 14:46:24 +0200
Subject: [PATCH 2/2] [ARM] Dove: add support for multi-purpose pins
	configuration
In-Reply-To: <63829134f147c923e9785f62482183efcbe62cc0.1288166961.git.mike@compulab.co.il>
References: <cover.1288166960.git.mike@compulab.co.il>
	<63829134f147c923e9785f62482183efcbe62cc0.1288166961.git.mike@compulab.co.il>
Message-ID: <AANLkTin1SR2xm7o18uF9vOOAnNJvvjnUxjUPDvifMGp8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> + ? ? ? ? ? ? ? shift = (num & 7) << 2;
> + ? ? ? ? ? ? ? if (*mpp_list & MPP_PMU_MASK) {
> + ? ? ? ? ? ? ? ? ? ? ? pmu_mpp_ctrl |= (0x1 << num);
> + ? ? ? ? ? ? ? ? ? ? ? pmu_sig_ctrl[num / 8] &= ~(0xf << shift);
> + ? ? ? ? ? ? ? ? ? ? ? pmu_sig_ctrl[num / 8] |= ~(0xf << shift);
the  ~ in line hints something wrong

> diff --git a/arch/arm/mach-dove/mpp.h b/arch/arm/mach-dove/mpp.h
> new file mode 100644
> index 0000000..c7b8acf
> --- /dev/null
> +++ b/arch/arm/mach-dove/mpp.h
> @@ -0,0 +1,214 @@
> +#ifndef __ARCH_DOVE_MPP_CODED_H
> +#define __ARCH_DOVE_MPP_CODED_H
> +
> +#define MPP(_num, _mode, _pmu, _grp, _au1, _nfc) ( ? ? \
> +/* MPP/group number */ ? ? ? ? ((_num) & 0xff) | ? ? ? ? ? ? ? \
> +/* MPP select value */ ? ? ? ? (((_mode) & 0xf) << 8) | ? ? ? ?\
> +/* MPP PMU */ ? ? ? ? ? ? ? ? ?((!!(_pmu)) << 12) | ? ? ? ? ? ?\
> +/* group flag */ ? ? ? ? ? ? ? ((!!(_grp)) << 13) | ? ? ? ? ? ?\
> +/* AU1 flag */ ? ? ? ? ? ? ? ? ((!!(_au1)) << 14) | ? ? ? ? ? ?\
> +/* NFCE flag */ ? ? ? ? ? ? ? ? ? ? ? ?((!!(_nfc)) << 15))
in order to make these defines readable, I suggest to add defines for
the flags, for example:
#define GROUP   (1 << 13)
then MPP defines look like:

#define MPPX_GPIO          MPP(MPP_X, 0x1, GROUP|AU1)

> +
> +#define MPP20_GPIO20 ? ? ? ? ? MPP(20, 0x0, 0, 0, 0, 0)
> +#define MPP20_AC97_SYSCLK_OUT ?MPP(20, 0x1, 0, 0, 0, 0)
> +#define MPP20_SPI_2_MISO ? ? ? MPP(20, 0x2, 0, 0, 0, 0)
I'ld rather call this LCD_SPI instead of SPI_2 to make it clear that
this SPI is different
