From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jan 2011 10:29:44 +0900
Subject: [PATCH/RFC 1/3] ARM: S5P: Add a platform callback for MIPI CSIS
	PHY control
In-Reply-To: <1294153764-25006-2-git-send-email-s.nawrocki@samsung.com>
References: <1294153764-25006-1-git-send-email-s.nawrocki@samsung.com>
	<1294153764-25006-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <020301cbb2c1$5ed9dec0$1c8d9c40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> The phy_enable callback in struct s5p_platform_mipi_csis is added
> to allow the CSIS driver to control its PHY enable and reset signals.
> This allows to use same MIPI CSIS driver across various SoCs.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/dev-csis0.c              |    2 +-
>  arch/arm/plat-s5p/dev-csis1.c              |    2 +-
>  arch/arm/plat-s5p/include/plat/csis.h      |   28 --------------------
>  arch/arm/plat-s5p/include/plat/mipi_csis.h |   39
> ++++++++++++++++++++++++++++
>  4 files changed, 41 insertions(+), 30 deletions(-)
>  delete mode 100644 arch/arm/plat-s5p/include/plat/csis.h
>  create mode 100644 arch/arm/plat-s5p/include/plat/mipi_csis.h
> 
> diff --git a/arch/arm/plat-s5p/dev-csis0.c b/arch/arm/plat-s5p/dev-csis0.c
> index dfab1c8..57efe9c 100644j
> --- a/arch/arm/plat-s5p/dev-csis0.c
> +++ b/arch/arm/plat-s5p/dev-csis0.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2010 Samsung Electronics
> + * Copyright (C) 2010 Samsung Electronics Co., Ltd
>   *
>   * S5P series device definition for MIPI-CSIS channel 0
>   *
> diff --git a/arch/arm/plat-s5p/dev-csis1.c b/arch/arm/plat-s5p/dev-csis1.c
> index e3053f2..c61b46b 100644
> --- a/arch/arm/plat-s5p/dev-csis1.c
> +++ b/arch/arm/plat-s5p/dev-csis1.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2010 Samsung Electronics
> + * Copyright (C) 2010 Samsung Electronics Co., Ltd
>   *
>   * S5P series device definition for MIPI-CSIS channel 1
>   *
> diff --git a/arch/arm/plat-s5p/include/plat/csis.h b/arch/arm/plat-
> s5p/include/plat/csis.h
> deleted file mode 100644
> index 51e308c..0000000
> --- a/arch/arm/plat-s5p/include/plat/csis.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/*
> - * Copyright (C) 2010 Samsung Electronics
> - *
> - * S5P series MIPI CSI slave device support
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#ifndef PLAT_S5P_CSIS_H_
> -#define PLAT_S5P_CSIS_H_ __FILE__
> -
> -/**
> - * struct s5p_platform_mipi_csis - platform data for MIPI-CSIS
> - * @clk_rate: bus clock frequency
> - * @lanes: number of data lanes used
> - * @alignment: data alignment in bits
> - * @hs_settle: HS-RX settle time
> - */
> -struct s5p_platform_mipi_csis {
> -	unsigned long clk_rate;
> -	u8 lanes;
> -	u8 alignment;
> -	u8 hs_settle;
> -};
> -
> -#endif /* PLAT_S5P_CSIS_H_ */
> diff --git a/arch/arm/plat-s5p/include/plat/mipi_csis.h b/arch/arm/plat-
> s5p/include/plat/mipi_csis.h
> new file mode 100644
> index 0000000..0b22065
> --- /dev/null
> +++ b/arch/arm/plat-s5p/include/plat/mipi_csis.h
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (C) 2010 Samsung Electronics, Co. Ltd
> + *
> + * S5P series MIPI CSI slave device support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef PLAT_S5P_MIPI_CSIS_H_
> +#define PLAT_S5P_MIPI_CSIS_H_ __FILE__
> +
> +struct platform_device;
> +
> +/**
> + * struct s5p_platform_mipi_csis - platform data for MIPI-CSIS
> + * @clk_rate: bus clock frequency
> + * @lanes: number of data lanes used
> + * @alignment: data alignment in bits
> + * @hs_settle: HS-RX settle time
> + */
> +struct s5p_platform_mipi_csis {
> +	unsigned long clk_rate;
> +	u8 lanes;
> +	u8 alignment;
> +	u8 hs_settle;
> +	int (*phy_enable)(struct platform_device *pdev, bool on);
> +};
> +
> +/**
> + * struct s5p_csis_phy_control - global MIPI-CSIS PHY control
> + * @pdev: platform device the mipi phy state is to be changed for
> + * @on: true to enable CSIS PHY and assert its reset,
> + *	false will disable the PHY and put into reset state
> + */
> +int s5p_csis_phy_enable(struct platform_device *pdev, bool on);
> +
> +#endif /* PLAT_S5P_MIPI_CSIS_H_ */
> --
> 1.7.3.4

I think should be separated like following.

If required, ...

1. change copyright
2. rename csis.h to mipi_csis.h
3. add phy enable feature

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
