From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Jun 2018 19:22:55 -0300
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
Message-ID: <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 7:07 PM, Fabio Estevam <festevam@gmail.com> wrote:

> This patches causes a regression on a imx51-babbage running 4.18-rc1:
> I get a kernel hang.
>
> If I revert it on top of 4.18-rc1, then it boots fine and USB host is
> functional.
>
> I understand this patch fixes a kernel hang for you, so which commit
> is responsible for the hang you observe?
>
> It seems this commit fixes a hang for you and causes another hang for me :-)
>
> Any ideas?

I am able to boot again if I skip passing the CI_HDRC_OVERRIDE_PHY_CONTROL flag:

--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -294,7 +294,6 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
        if ((of_device_is_compatible(np, "fsl,imx53-usb") ||
             of_device_is_compatible(np, "fsl,imx51-usb")) && pdata.usb_phy &&
            of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
-               pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
                data->override_phy_control = true;
                usb_phy_init(pdata.usb_phy);
        }
