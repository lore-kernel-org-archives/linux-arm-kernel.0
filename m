From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 10:42:47 +0100
Subject: [PATCH 3/6] reset: hisilicon: add reset-hi3660
In-Reply-To: <d6e602c0-70e9-0309-86b5-bfd006d86028@linaro.org>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
 <2220300.Yj4lYzeH2z@wuerfel>
 <d6e602c0-70e9-0309-86b5-bfd006d86028@linaro.org>
Message-ID: <3166877.sQekoU5ezv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 5:34:05 PM CET zhangfei wrote:
> On 2016?11?22? 16:50, Arnd Bergmann wrote:
> > On Tuesday, November 22, 2016 3:49:18 PM CET Zhangfei Gao wrote:
> >> +static const struct hisi_reset_channel_data hi3660_iomcu_rst[] = {
> >> +       [HI3660_RST_I2C0] = HISI_RST_SEP(0x20, 3),
> >> +       [HI3660_RST_I2C1] = HISI_RST_SEP(0x20, 4),
> >> +       [HI3660_RST_I2C2] = HISI_RST_SEP(0x20, 5),
> >> +       [HI3660_RST_I2C6] = HISI_RST_SEP(0x20, 27),
> >> +};
> >> +
> >> +static struct hisi_reset_controller_data hi3660_iomcu_controller = {
> >> +       .nr_channels = ARRAY_SIZE(hi3660_iomcu_rst),
> >> +       .channels = hi3660_iomcu_rst,
> >> +};
> >> +
> >> +static const struct hisi_reset_channel_data hi3660_crgctrl_rst[] = {
> >> +       [HI3660_RST_I2C3] = HISI_RST_SEP(0x78, 7),
> >> +       [HI3660_RST_I2C4] = HISI_RST_SEP(0x78, 27),
> >> +       [HI3660_RST_I2C7] = HISI_RST_SEP(0x60, 14),
> >> +       [HI3660_RST_SD] = HISI_RST_SEP(0x90, 18),
> >> +       [HI3660_RST_SDIO] = HISI_RST_SEP(0x90, 20),
> >> +       [HI3660_RST_UFS] = HISI_RST_SEP(0x84, 12),
> >> +       [HI3660_RST_UFS_ASSERT] = HISI_RST_SEP(0x84, 7),
> >> +       [HI3660_RST_PCIE_SYS] = HISI_RST_SEP(0x84, 26),
> >> +       [HI3660_RST_PCIE_PHY] = HISI_RST_SEP(0x84, 27),
> >> +       [HI3660_RST_PCIE_BUS] = HISI_RST_SEP(0x84, 31),
> >> +       [HI3660_RST_USB3OTG_PHY] = HISI_RST_SEP(0x90, 3),
> >> +       [HI3660_RST_USB3OTG] = HISI_RST_SEP(0x90, 5),
> >> +       [HI3660_RST_USB3OTG_32K] = HISI_RST_SEP(0x90, 6),
> >> +       [HI3660_RST_USB3OTG_AHB] = HISI_RST_SEP(0x90, 7),
> >> +       [HI3660_RST_USB3OTG_MUX] = HISI_RST_SEP(0x90, 8),
> >> +};
> > I think you can avoid the trap of the ABI incompatibility if
> > you just define those as in the binding as tuples, using #reset-cells=2.
> >
> > In particular for the first set, it seems really silly to redefine
> > the numbers when there is just a simple integer number.
> 
> Could you clarify more, still not understand.
> The number is index of the arrays, and the index will be used in dts.
> The arrays lists the registers offset and bit shift.
> For example:
> 
> [HI3660_RST_I2C0] = HISI_RST_SEP(0x20, 3), means register offset : 0x20, and bit shift = 3.
> 
> And Documentation/devicetree/bindings/reset/reset.txt
> Required properties:
> #reset-cells:   Number of cells in a reset specifier; Typically 0 for nodes
>                  with a single reset output and 1 for nodes with multiple
>                  reset outputs.

You can easily enumerate the registers that contain reset bits here,
so just use one cell for the register and another one for the index.

	Arnd
