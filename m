From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 23 Oct 2013 17:04:44 +0800
Subject: [Patch v2 02/14] usb: phy-mxs: Add platform judgement code
In-Reply-To: <20131023064604.GE8534@shlinux1.ap.freescale.net>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
 <1382421528-17897-3-git-send-email-peter.chen@freescale.com>
 <20131023061322.GF2839@S2101-09.ap.freescale.net>
 <20131023064604.GE8534@shlinux1.ap.freescale.net>
Message-ID: <20131023090443.GR2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 02:46:04PM +0800, Peter Chen wrote:
> How about compare compatible string directly at probe?
> 
> 	if (of_device_is_compatible(np, "fsl,imx6q-usbphy"))
> 		mxs_phy->devtype = IMX6Q_USB_PHY;
> 	else if ((of_device_is_compatible(np, "fsl,imx6sl-usbphy"))
> 		mxs_phy->devtype = IMX6SL_USB_PHY;
> 	else if (...)
> 		...;

It can work, but in general, we should avoid unnecessary device tree
lookup.  I would suggest something like below.

#define MXS_FLAGS_SUSPEND_ISSUE_1	BIT(0)
#define MXS_FLAGS_SUSPEND_ISSUE_2	BIT(1)
#define MXS_FLAGS_LINE_DISCONNECT	BIT(2)

struct mxs_phy_data {
	unsigned int flags;
};

struct mxs_phy {
	...
	mxs_phy_data *data;
};

static struct mxs_phy_data imx6sl_usbphy_data = {
        .flags = MXS_FLAGS_LINE_DISCONNECT,
};

static struct mxs_phy_data imx6q_usbphy_data = {
        .flags = MXS_FLAGS_SUSPEND_ISSUE_2 | MXS_FLAGS_LINE_DISCONNECT,
};

static struct mxs_phy_data imx23_usbphy_data = {
        .flags = MXS_FLAGS_SUSPEND_ISSUE_1 | MXS_FLAGS_SUSPEND_ISSUE_2,
};

static const struct of_device_id mxs_phy_dt_ids[] = {
       { .compatible = "fsl,imx6sl-usbphy", .data = &imx6sl_usbphy_data, },
       { .compatible = "fsl,imx6q-usbphy", .data = &imx6q_usbphy_data, },
       { .compatible = "fsl,imx23-usbphy", .data = &imx23_usbphy_data, },
       { /* sentinel */ }
};
MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);

Then you can check the flags for handling different cases.  This would
be more flexible and future proof.

Shawn
