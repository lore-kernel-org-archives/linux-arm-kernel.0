From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 31 Jan 2013 11:08:54 +0800
Subject: [PATCH 4/6] usb: chipidea: add PTW and PTS handling
In-Reply-To: <1359559782-14552-5-git-send-email-s.hauer@pengutronix.de>
References: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
 <1359559782-14552-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130131030853.GG9777@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 04:29:40PM +0100, Sascha Hauer wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> +static void hw_phymode_configure(struct ci13xxx *ci)
> +{
> +	u32 portsc;
> +
> +	/*
> +	 * The lpm version has the corresponding bits in the devlc register.
> +	 * Currently not implemented.
> +	 */
> +	if (ci->hw_bank.lpm)
> +		return;
> +
> +	switch (ci->platdata->phy_mode) {
> +	case USBPHY_INTERFACE_MODE_UTMI:
> +		portsc = PORTSC_PTS_PTW_UTMI;
> +		break;
> +	case USBPHY_INTERFACE_MODE_UTMIW:
> +		portsc = PORTSC_PTS_PTW_UTMIW;
> +		break;
> +	case USBPHY_INTERFACE_MODE_ULPI:
> +		portsc = PORTSC_PTS_PTW_ULPI;
> +		break;
> +	case USBPHY_INTERFACE_MODE_SERIAL:
> +		portsc = PORTSC_PTS_PTW_SERIAL;
> +		break;
> +	case USBPHY_INTERFACE_MODE_HSIC:
> +		portsc = PORTSC_PTS_PTW_HSIC;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	hw_write(ci, OP_PORTSC, PORTSC_PTS_PTW, portsc);
> +
> +	mdelay(10);
Please use usleep_range, can we recall which platform needs it?
As we as I know, there is no such delay at FSL internal release
code.
-- 

Best Regards,
Peter Chen
