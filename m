From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Nov 2016 22:45:52 +0100
Subject: [PATCH 6/10] clk: sunxi-ng: Add A10s CCU driver
In-Reply-To: <CAGb2v64cft9nWh13c+8jG8qhrD_RnVFc+s8btMTHbdDS155eQA@mail.gmail.com>
References: <cover.326f50aecc25fbe292184527b52a1e3172aba9cf.1478625788.git-series.maxime.ripard@free-electrons.com>
 <2110deed00d33bdb557efebe8f988976fbf5a440.1478625788.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64cft9nWh13c+8jG8qhrD_RnVFc+s8btMTHbdDS155eQA@mail.gmail.com>
Message-ID: <20161121214552.yvt7r4jntusb5vx3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2016 at 05:34:44PM +0800, Chen-Yu Tsai wrote:
> > +static struct ccu_nkmp pll_ve_clk = {
> > +       .enable         = BIT(31),
> > +       .n              = _SUNXI_CCU_MULT_OFFSET(8, 5, 0),
> > +       .k              = _SUNXI_CCU_MULT(4, 2),
> > +       .m              = _SUNXI_CCU_DIV(0, 2),
> > +       .p              = _SUNXI_CCU_DIV(16, 2),
> 
> Any chance we'll support the bypass switch on this one?

I'm not sure this will be useful to have it running at 24MHz.

> > +static SUNXI_CCU_M(pll_ddr_clk, "pll-ddr", "pll-ddr-base", 0x020, 0, 2, 0);
> 
> Maybe we should set CLK_IS_CRITICAL on this one as well... in case the
> bootloader uses pll-periph for mbus, and none of the dram gates are enabled.

Ack.

> > +static SUNXI_CCU_GATE(hosc_clk,        "hosc", "osc24M", 0x050, BIT(0), 0);
> 
> Why the extra "hosc" clock here? You should probably just internalize "osc24M".

I'd prefer to model it as it is modelled in hardware: you have two
crystals, and then a gate within the CCU.

> > +static const char * const csi_parents[] = { "hosc", "pll-video0", "pll-video1",
> > +                                           "pll-video0-2x", "pll-video1-2x" };
> > +static const u8 csi_table[] = { 0, 1, 2, 5, 6 };
> > +static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(csi_clk, "csi",
> > +                                      csi_parents, csi_table,
> > +                                      0x134, 0, 5, 24, 2, BIT(31), 0);
> 
> Do you know if CSI needs to change the module clock?

Apparently not.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161121/bb431cdc/attachment.sig>
