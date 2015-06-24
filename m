From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Wed, 24 Jun 2015 10:55:13 +0530
Subject: [RFC PATCH v6 2/2] nvmem: Add Vybrid OCOTP and OCROM support
In-Reply-To: <5589AD83.8050704@linaro.org>
References: <cover.1435066190.git.maitysanchayan@gmail.com>
 <b4a52f6c229bdabbfe9d21c03cb04593dde33ec4.1435066190.git.maitysanchayan@gmail.com>
 <5589AD83.8050704@linaro.org>
Message-ID: <20150624052513.GB11753@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Srinivas,

On 15-06-23 20:03:31, Srinivas Kandagatla wrote:
> Hi Sanchayan,
> 
> 
> On 23/06/15 14:44, Sanchayan Maity wrote:
> >The patch adds support for the On Chip One Time Programmable Peripheral
> >(OCOTP) and On Chip ROM (OCROM) support.
> >
> >On Vybrid OCOTP contain data like SoC ID, MAC address and OCROM has the
> >revision ID.
> >
> >Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> >---
> >  drivers/nvmem/Kconfig       | 11 +++++++++
> >  drivers/nvmem/Makefile      |  2 ++
> >  drivers/nvmem/vf610-ocotp.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 73 insertions(+)
> >  create mode 100644 drivers/nvmem/vf610-ocotp.c
> >
> 
> Fantastic! diff is already looking good, when compared to v5 patches,
> "drivers/soc/fsl/soc-vf610.c | 166
> +++++++++++++++++++++++++++++++++++++++++++"

Yes :)

> 
> I think, We could even do a better job by moving qfprom and this driver to a
> simple-mmio-nvmem provider, see below comments.
> 
> >diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> >index 17f1a57..557c1e0 100644
> >--- a/drivers/nvmem/Kconfig
> >+++ b/drivers/nvmem/Kconfig
> >@@ -33,4 +33,15 @@ config NVMEM_SUNXI_SID
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called eeprom-sunxi-sid.
> >
> >+config NVMEM_VF610_OCOTP
> >+	tristate "VF610 SoCs OCOTP support"
> >+	depends on SOC_VF610
> >+	select REGMAP_MMIO
> >+	help
> >+	  This is a driver for the 'OCOTP' available on various Vybrid
> >+	  devices.
> >+
> >+	  This driver can also be built as a module. If so, the module
> >+	  will be called nvmem-vf610-ocotp.
> >+
> >  endif
> >diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> >index cc46791..a9ed113 100644
> >--- a/drivers/nvmem/Makefile
> >+++ b/drivers/nvmem/Makefile
> >@@ -11,3 +11,5 @@ obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
> >  nvmem_qfprom-y			:= qfprom.o
> >  obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem-sunxi-sid.o
> >  nvmem-sunxi-sid-y		:= sunxi-sid.o
> >+obj-$(CONFIG_NVMEM_VF610_OCOTP)	+= nvmem-vf610-ocotp.o
> >+nvmem-vf610-ocotp-y		:= vf610-ocotp.o
> >diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
> >new file mode 100644
> >index 0000000..d98772d
> >--- /dev/null
> >+++ b/drivers/nvmem/vf610-ocotp.c
> >@@ -0,0 +1,60 @@
> >+/*
> >+ * Copyright (C) 2015 Sanchayan Maity <sanchayan.maity@toradex.com>
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify
> >+ * it under the terms of the GNU General Public License version 2 and
> >+ * only version 2 as published by the Free Software Foundation.
> >+ *
> >+ * This program is distributed in the hope that it will be useful,
> >+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+ * GNU General Public License for more details.
> >+ */
> >+
> >+#include <linux/module.h>
> >+#include <linux/of.h>
> >+#include "nvmem-mmio.h"
> >+
> >+static struct regmap_config regmap_config = {
> >+	.reg_bits = 32,
> >+	.val_bits = 32,
> >+	.reg_stride = 4,
> 
> Any particular reason why it cant support byte reads?
> 
> This driver looks exactly same as qcom,qfprom driver, except the
> regmap_config.

It does support byte reads. This works as well

static struct regmap_config regmap_config = {
	   .reg_bits = 32,
	   .val_bits = 8,
	   .reg_stride = 1,
	};
}

Hmm can't recall why I went with that. Yes it is more or less the
same as qcom,qfprom driver, that's what I referred.

> 
> >+};
> >+
> >+static struct nvmem_config ocotp_config = {
> >+	.name = "soc_id",
> >+};
> >+
> >+static struct nvmem_config rom_config = {
> >+	.name = "rom_rev",
> >+};
> >+
> >+static struct nvmem_mmio_data ocotp_data = {
> >+	.nvmem_config = &ocotp_config,
> >+	.regmap_config = &regmap_config,
> >+};
> >+
> >+static struct nvmem_mmio_data rom_data = {
> >+	.nvmem_config = &rom_config,
> >+	.regmap_config = &regmap_config,
> >+};
> >+
> >+static const struct of_device_id ocotp_of_match[] = {
> >+	{ .compatible = "fsl,vf610-ocotp", .data = &ocotp_data},
> >+	{ .compatible = "fsl,vf610-ocrom", .data = &rom_data},
> >+	{/* sentinel */},
> >+};
> >+MODULE_DEVICE_TABLE(of, ocotp_of_match);
> >+
> >+static struct platform_driver vf610_ocotp_driver = {
> >+	.probe = nvmem_mmio_probe,
> >+	.remove = nvmem_mmio_remove,
> >+	.driver = {
> >+		.name = "vf610-nvmem",
> >+		.of_match_table = ocotp_of_match,
> >+	},
> >+};
> >+module_platform_driver(vf610_ocotp_driver);
> >+MODULE_AUTHOR("Sanchayan Maity <sanchayan.maity@toradex.com>");
> >+MODULE_DESCRIPTION("Vybrid NVMEM driver");
> >+MODULE_LICENSE("GPL v2");
> >
> 
> 
> I moved the nvmem_mmio to qfprom as I did not any other user for that in v6
> patches.
> 
> Now that Vybrid can be another user I should probably put it back, or may be
> I should create a simple-mmio-nvmem driver which both qcom,qfprom and Vybrid
> can use.

Nice, then that would simplify things further from what I understand at the moment.

- Sanchayan.
