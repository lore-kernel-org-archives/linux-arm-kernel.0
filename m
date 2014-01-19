From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Jan 2014 12:25:40 +0000
Subject: [RFC v3 11/13] ahci-imx: Don't create a nested platform device
 from probe
In-Reply-To: <1390088935-7193-12-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-12-git-send-email-hdegoede@redhat.com>
Message-ID: <20140119122540.GN15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 12:48:53AM +0100, Hans de Goede wrote:
> Instead only provide platform_data through of_device_id, like the ahci-sunxi
> driver does.

It looks like the whole of ahci_imx.c (apart from the inclues) is
enclosed in a big ifdef.  You can avoid that by using this in the
Makefile:

> @@ -10,9 +10,8 @@ obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
>  obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
>  obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
>  obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
> -obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o
>  
> -ahci_plat-objs := ahci_platform.o ahci_sunxi.o
> +ahci_plat-objs := ahci_platform.o ahci_imx.o ahci_sunxi.o

ahci_plat-y := ahci_platform.o ahci_sunxi.o
ahci_plat-$(CONFIG_AHCI_IMX) += ahci_imx.o

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
