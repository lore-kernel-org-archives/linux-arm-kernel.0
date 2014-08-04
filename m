From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 4 Aug 2014 09:08:23 +0100
Subject: [PATCH 1/9] ARM: sunxi: introduce SoC identification support
In-Reply-To: <53DEAD81.9020604@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-2-git-send-email-emilio@elopez.com.ar>
 <20140803124036.GS3952@lukather> <53DEAD81.9020604@elopez.com.ar>
Message-ID: <20140804080823.GA3935@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 03 Aug 2014, Emilio L?pez wrote:
> El 03/08/14 a las 09:40, Maxime Ripard escibi?:
> >On Thu, Jul 31, 2014 at 06:28:04PM -0300, Emilio L?pez wrote:
> >>This commit adds SoC bus support on the sunxi platform, and exposes
> >>information such as the hardware revision to userspace and other kernel
> >>clients during init. A message with this information is also printed to
> >>the kernel log to ease future bug triaging.
> >>
> >>Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> >>---
> >>  arch/arm/mach-sunxi/Kconfig        |   1 +
> >>  arch/arm/mach-sunxi/Makefile       |   2 +-
> >>  arch/arm/mach-sunxi/sunxi-soc-id.c | 226 +++++++++++++++++++++++++++++++++++++
> >>  arch/arm/mach-sunxi/sunxi-soc-id.h |   6 +
> >>  4 files changed, 234 insertions(+), 1 deletion(-)
> >>  create mode 100644 arch/arm/mach-sunxi/sunxi-soc-id.c
> >>  create mode 100644 arch/arm/mach-sunxi/sunxi-soc-id.h

[...]

> >>+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> >>+	if (!soc_dev_attr)
> >>+		goto exit;
> >>+
> >>+	/* Read the machine name if available */
> >>+	of_property_read_string(root, "model", &soc_dev_attr->machine);
> >>+
> >>+	soc_dev_attr->family = kstrdup("Allwinner A Series", GFP_KERNEL);
> >
> >I think the family should be sun*i
> 
> Here is a list of the ones currently in use for family
> 
> "Cirrus Logic EP93xx"
> "Freescale i.MX"
> "Integrator"
> "Marvell"
> "Freescale MXS Family"
> "Tegra"
> "Xilinx Zynq"
> 
> There does not seem to be a real consensus on what these mean.
> There's a binding document on
> Documentation/ABI/testing/sysfs-devices-soc but it's not really
> detailed.
> 
> >
> >>+	soc_dev_attr->soc_id = kstrdup(match->data, GFP_KERNEL);
> >
> >And soc_id would be just the name of the SoC.
> 
> According to the binding this is a serial number. Lee, could you
> help us decide what these fields should look like?
> 
> I'm now inclining to have eg. family=sun5i, machine=A13, keep
> revision the same and drop soc_id.

Voila: Documentation/ABI/testing/sysfs-devices-soc

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
