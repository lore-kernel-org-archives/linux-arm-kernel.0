From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 7 Nov 2018 22:47:35 -0800
Subject: [PATCH 2/5] hwspinlock: add STM32 hwspinlock device
In-Reply-To: <20181031093032.20386-3-benjamin.gaignard@st.com>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
 <20181031093032.20386-3-benjamin.gaignard@st.com>
Message-ID: <20181108064735.GB12063@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 31 Oct 02:30 PDT 2018, Benjamin Gaignard wrote:
> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> index e895d29500ee..e1a20b460590 100644
> --- a/drivers/hwspinlock/Kconfig
> +++ b/drivers/hwspinlock/Kconfig
> @@ -59,3 +59,12 @@ config HSEM_U8500
>  	  SoC.
>  
>  	  If unsure, say N.
> +
> +config HWSPINLOCK_STM32

Please keep these alphabetically sorted.

> +	tristate "STM32 Hardware Spinlock device"
> +	depends on MACH_STM32MP157
> +	depends on HWSPINLOCK
> +	help
> +	  Say y here to support the STM32 Hardware Spinlock device.
> +
> +	  If unsure, say N.
> diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
> index b87c01a506a4..c0a9505b4dcf 100644
> --- a/drivers/hwspinlock/Makefile
> +++ b/drivers/hwspinlock/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
>  obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
> +obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o

Ditto.

> diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
> new file mode 100644
> index 000000000000..6a0fafac7389
> --- /dev/null
> +++ b/drivers/hwspinlock/stm32_hwspinlock.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics SA 2018
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + * License terms:  GNU General Public License (GPL), version 2

Didn't you already state your license terms with the SPDX header above?

> + */
[..]
> +static int stm32_hwspinlock_remove(struct platform_device *pdev)
> +{
> +	struct stm32_hwspinlock *hw = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = hwspin_lock_unregister(&hw->bank);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
> +		return ret;

The return value of platform_device is ignored, so printing an error
message is fine, but don't "abort".

> +	}
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}

Regards,
Bjorn
