From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 29 May 2018 17:02:31 +0300
Subject: [PATCH] soc: imx: gpcv2: correct PGC offset
In-Reply-To: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
References: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <0e0690c89b24b4b028e4a0dab63334af4b37fdd3.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-05-29 at 16:02 +0800, Anson Huang wrote:
> Correct MIPI/PCIe/USB_HSIC's PGC offset based on
> design RTL, the value on Reference Manual are incorrect.
> 
> The correct offset should be as below: 
>  
> -#define PGC_MIPI			4
> -#define PGC_PCIE			5
> -#define PGC_USB_HSIC			8
> +#define PGC_MIPI			16
> +#define PGC_PCIE			17
> +#define PGC_USB_HSIC			20
>  #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
>  #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)

This gpcv2 driver is currently only used for PCI, it probably only
works because domains happen to be turned on by default?

On imx7d upstream platform suspend is not yet supported but even doing
device-level suspend causes a hang on resume somewhere in PCI on first
read. This patch fixes that immediate hang.

After suspend/resume lspci is broken (device doesn't properly resume),
that probably requires more imx pci patches and unrelated to pgc.

--
Regards,
Leonard
