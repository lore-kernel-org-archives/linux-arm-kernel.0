From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 14 Apr 2017 11:08:42 +0800
Subject: [PATCH v2] ARM: dts: imx53-qsrb: Pulldown PMIC IRQ pin
In-Reply-To: <1492032678-29572-1-git-send-email-festevam@gmail.com>
References: <1492032678-29572-1-git-send-email-festevam@gmail.com>
Message-ID: <20170414030841.GD14915@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 06:31:18PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Currently the following errors are seen:
> 
> [   14.015056] mc13xxx 0-0008: Failed to read IRQ status: -6
> [   27.321093] mc13xxx 0-0008: Failed to read IRQ status: -6
> [   27.411681] mc13xxx 0-0008: Failed to read IRQ status: -6
> [   27.456281] mc13xxx 0-0008: Failed to read IRQ status: -6
> [   30.527106] mc13xxx 0-0008: Failed to read IRQ status: -6
> [   36.596900] mc13xxx 0-0008: Failed to read IRQ status: -6
> 
> Also when reading the interrupts via 'cat /proc/interrupts' the
> PMIC GPIO interrupt counter does not stop increasing.
> 
> The reason for the storm of interrupts is that the PUS field of
> register IOMUXC_SW_PAD_CTL_PAD_CSI0_DAT5 is currently configured as:
> 10 : 100k pullup
> 
> and the PMIC interrupt is being registered as IRQ_TYPE_LEVEL_HIGH type,
> which is the correct type as per the MC34708 datasheet.
> 
> Use the default power on value for the IOMUX, which sets PUS field as:
> 00: 360k pull down
> 
> This prevents the spurious PMIC interrupts from happening.
> 
> Commit e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
> correctly described the irq type as IRQ_TYPE_LEVEL_HIGH, but
> missed to update the IOMUX of the PMIC GPIO as pull down.
> 
> Fixes: e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v1:
> - Fix typo: s/seeing/seen in the commit log

Okay, replaced with this one.
