From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 Jul 2016 23:35:06 +0200
Subject: [PATCH v3 13/14] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <146785878822.73491.15164592643568518865@resonance>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
 <20160629190535.11855-14-maxime.ripard@free-electrons.com>
 <146785878822.73491.15164592643568518865@resonance>
Message-ID: <20160708213506.GD4522@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, Jul 06, 2016 at 07:33:08PM -0700, Michael Turquette wrote:
> Hi Maxime,
> 
> Quoting Maxime Ripard (2016-06-29 12:05:34)
> > +static void __init sun8i_h3_ccu_setup(struct device_node *node)
> > +{
> > +       void __iomem *reg;
> > +       u32 val;
> > +
> > +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> > +       if (IS_ERR(reg)) {
> > +               pr_err("%s: Could not map the clock registers\n",
> > +                      of_node_full_name(node));
> > +               return;
> > +       }
> > +
> > +       /* Force the PLL-Audio-1x divider to 4 */
> > +       val = readl(reg + SUN8I_H3_PLL_AUDIO_REG);
> > +       val &= ~GENMASK(4, 0);
> > +       writel(val | 3, reg + SUN8I_H3_PLL_AUDIO_REG);
> > +
> > +       sunxi_ccu_probe(node, reg, &sun8i_h3_ccu_desc);
> > +}
> > +CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
> > +              sun8i_h3_ccu_setup);
> 
> There are several examples of drivers that split the clocks between
> "early" CLK_OF_DECLARE clocks and "late" module clocks. If you really
> need early clocks (which is less likely on a 64-bit platform with
> architected timers), it would be nice to pair that with a proper
> platform_driver (using builtin_platform_driver most likely).

I think we discussed that already, but yeah, we do have timers that
are not the architected ones (and this is a ARMv7 platform). I have
the feeling that splitting the two doesn't really bring any benefit,
but complexify a lot the driver.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160708/23fdd4dc/attachment.sig>
