From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 25 Jun 2018 14:18:13 +0200
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <CAOMZO5DAbooRgA+sHJa5EmEGy-CHW3FPydcOFtK5AqpdJzD7MQ@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
 <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
 <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
 <CAHQ1cqHpNvZGAfFKrp-OiZevsha5CBwJsw8GT+uhgNSfEUejkw@mail.gmail.com>
 <CAOMZO5DAbooRgA+sHJa5EmEGy-CHW3FPydcOFtK5AqpdJzD7MQ@mail.gmail.com>
Message-ID: <20180625121813.rzqgzdbk6ue73eq4@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 24, 2018 at 08:51:20PM -0300, Fabio Estevam wrote:
> Hi Andrey,
> 
> On Sun, Jun 24, 2018 at 7:40 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
> 
> > It's definitely the bootloader, or more specifically whether or not it
> > initialized/used USB before booting the kernel. Some interesting
> > highlights:
> >
> >  - On your "good" 4.17.2 based image, if you interrupt U-Boot, do "usb
> > start" (optionally "usb stop") and then "boot", you'll get the hang
> > that I was trying to fix with my patch.
> >
> >  - Things are exact opposite with 4.18-rc1 and doing the above would
> > _prevent_ the hang and the image would boot fine.
> >
> >  - Disabling USB in Barebox based boot "stack" gets it to behave the
> > same way as U-boot from your image (hanging when booting 4.18-rc1)
> >
> > Digging more into code it seems that the reason for 4.18-rc1's
> > behavior is the fact that it's missing a call hw_phymode_configure()
> > after usb_phy_init() and, AFAICT, the only reason it is not happening
> > is because default image is being built without
> > CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS. Enabling those two
> > options on 4.18-rc1, seem to fix the problem on both your U-Boot based
> > image and my "special" Barebox setup.
> >
> > So AFAICT, this patch still fixes a valid issue (my use-case was net
> > booting via USB-Ethernet dongle), but an additional patch enabling
> > those two configuration options might be needed. Thoughts?
> 
> Yes, I can confirm that your suggested change avoids the kernel hang:
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> b/arch/arm/configs/imx_v6_v7_defconfig
> index d14de86..2da678c 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -300,6 +300,7 @@ CONFIG_USB_STORAGE=y
>  CONFIG_USB_CHIPIDEA=y
>  CONFIG_USB_CHIPIDEA_UDC=y
>  CONFIG_USB_CHIPIDEA_HOST=y
> +CONFIG_USB_CHIPIDEA_ULPI=y
>  CONFIG_USB_SERIAL=m
>  CONFIG_USB_SERIAL_GENERIC=y
>  CONFIG_USB_SERIAL_FTDI_SIO=m
> @@ -336,6 +337,7 @@ CONFIG_USB_GADGETFS=m
>  CONFIG_USB_FUNCTIONFS=m
>  CONFIG_USB_MASS_STORAGE=m
>  CONFIG_USB_G_SERIAL=m
> +CONFIG_USB_ULPI_BUS=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
> 
> > Also, I don't have any i.MX53 HW, so I wasn't able to test the effects
> > of enabling those two options there.
> 
> The imx53 board I have access to does not use ULPI.
> 
> Maybe Sebastian on Cc may help testing this on his imx53 board as he
> is the author of:
> be9cae2479f48 ("usb: chipidea: imx: Fix ULPI on imx53")

I still have access to the imx53 based PPD from General Electric.
But I don't understand what patch you want me to test. FWIW the
images I use(d) for testing already had CONFIG_USB_CHIPIDEA_ULPI
and CONFIG_USB_ULPI_BUS enabled.

> I am wondering if we need to force some kind of USB reset to put the
> USB controller into a known state independently of what the bootloader
> has done previously.

Makes sense to me.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180625/bcdea32f/attachment.sig>
