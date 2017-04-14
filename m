From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 14 Apr 2017 11:06:54 +0800
Subject: [PATCH] ARM: dts: imx53-qsrb: Pulldown PMIC IRQ pin
In-Reply-To: <1492020275-29654-1-git-send-email-fabio.estevam@nxp.com>
References: <1492020275-29654-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170414030652.GC14915@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 03:04:35PM -0300, Fabio Estevam wrote:
> Currently the following errors are seeing:
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
> missed to update the IOMUX of the PMIC GPIO to pull down.
> 
> Fixes: e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
