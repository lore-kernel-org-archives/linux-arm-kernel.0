From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 05 Oct 2017 14:28:24 +0200
Subject: [PATCHv3 2/2] phy: exynos5-usbdrd: Calibrate LOS levels for
 exynos5420/5800
In-Reply-To: <1507205511-23048-3-git-send-email-andrzej.p@samsung.com>
References: <6935498c-9788-14e6-844f-f9e8288026dc@samsung.com>
 <1507205511-23048-1-git-send-email-andrzej.p@samsung.com>
 <CGME20171005121202eucas1p249a72bb6d8dde4a61134ffb49216d4c5@eucas1p2.samsung.com>
 <1507205511-23048-3-git-send-email-andrzej.p@samsung.com>
Message-ID: <88cf66cc-0bca-3ad9-183b-d55f7f258028@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2017 02:11 PM, Andrzej Pietrasiewicz wrote:
> +static int crport_handshake(struct exynos5_usbdrd_phy *phy_drd,
> +						u32 val, u32 cmd)
> +{
> +	u32 usec = 100;
> +	unsigned int result;
> +
> +	writel(val | cmd, phy_drd->reg_phy + EXYNOS5_DRD_PHYREG0);
> +
> +	do {
> +		result = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1);
> +		if (result & PHYREG1_CR_ACK)
> +			break;
> +
> +		udelay(1);
> +	} while (usec-- > 0);

It looks like you could use readl_poll_timeout_atomic() macro 
instead of these polling loops.

-- 
Regards,
Sylwester
