From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 23 Oct 2018 11:06:34 +0200
Subject: [PATCH RESEND v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
In-Reply-To: <1540284888-32307-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1540284888-32307-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20181023110634.26ff2629@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018 08:56:46 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> +struct nxp_fspi {
> +	void __iomem *iobase;
> +	void __iomem *ahb_addr;
> +	u32 memmap_phy;
> +	u32 memmap_phy_size;
> +	struct clk *clk, *clk_en;
> +	struct device *dev;
> +	struct completion c;
> +	const struct nxp_fspi_devtype_data *devtype_data;
> +	struct mutex lock;
> +	struct pm_qos_request pm_qos_req;
> +	int selected;
> +	void (*write)(u32 val, void __iomem *addr);
> +	u32 (*read)(void __iomem *addr);

I think I already commented on this aspect, and I keep thinking having a
function pointer is overkill here.
Just declare 2 functions and do the f->devtype_data->little_endian
check in there:

static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr)
{
	if (f->devtype_data->little_endian)
		return ioread32(addr);

	return ioread32be(addr);
}

static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem *addr)
{
	if (f->devtype_data->little_endian)
		iowrite32(val, addr);

	iowrite32be(val, addr);
}
