From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 25 Jul 2013 11:28:44 +0100
Subject: [PATCH] arm: l2x0: add support for prefetch and pwr control
 register configuration
In-Reply-To: <51EE8183.9010703@gmail.com>
References: <1374572345-5763-1-git-send-email-chander.kashyap@linaro.org>
 <20130723102212.GD4833@e106331-lin.cambridge.arm.com>
 <51EE8183.9010703@gmail.com>
Message-ID: <20130725102844.GA29742@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 02:13:39PM +0100, Rob Herring wrote:
> On 07/23/2013 05:22 AM, Mark Rutland wrote:
> > Hi,
> > 
> > [adding Rob Herring to Cc]
> 
> Thanks.
> 
> > On Tue, Jul 23, 2013 at 10:39:05AM +0100, Chander Kashyap wrote:
> >> This patch adds support to configure prefetch and pwr control registers
> >> of pl310 cache controllor.
> >>
> >> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/arm/l2cc.txt |    6 ++++
> >>  arch/arm/include/asm/hardware/cache-l2x0.h     |   23 +++++++++++++
> >>  arch/arm/mm/cache-l2x0.c                       |   44 ++++++++++++++++++++++++
> >>  3 files changed, 73 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> >> index cbef09b..66876b6 100644
> >> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> >> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> >> @@ -34,6 +34,12 @@ Optional properties:
> >>  - arm,filter-ranges : <start length> Starting address and length of window to
> >>    filter. Addresses in the filter window are directed to the M1 port. Other
> >>    addresses will go to the M0 port.
> >> +- arm,prefetch-control : Prefetch related configurations. Specifies 8 cells of
> >> +  prefetch-offset, not-same-ID-on-exclusive-sequence-en, incr-double-Linefill-en,
> >> +  prefetch-drop-en, data-prefetch-en, instruction-prefetch-en and
> >> +  double-linefill-en.
> > 
> > This looks like configuration rather than hardware specification. 
> 
> I think weigh whether this is configuration based on the h/w or just
> user preference. This would be the former, but...
> 
> > Is there any reason we couldn't have Linux configure this itself? I'm
> > not sure having a fixed configuration of these values makes sense - the
> > configuration values could interact badly with future changes to Linux
> > (e.g. performance improvements or errata workarounds), and then we'd
> > have to ignore the described values and/or decide on more suitable ones
> > dynamically anyway.
> 
> Does having a variable configuration for these make sense either? I mean
> other than an errata work-around, why would you ever turn off prefetch
> or double linefill?

I guess not.

> 
> None of these fields can be set in NS world. We've already laid down the
> law in regards to setting secure only bits for errata work-arounds. I
> think this is no different and we should move towards the kernel doesn't
> touch aux ctrl at all. There might be an exception with the event bus
> enable, but you would still have the secure vs. non-secure issue and no
> way to detect that.

I would certainly be much happier if we didn't have to touch aux ctrl at
all in the kernel.

Thanks,
Mark.

> 
> Rob
> 
> > 
> > I assume that these cells are meant to either be zero or one? If they're
> > necessary, they should be separate boolean properties rather than
> > grouped together by the register they're configured by (see the way
> > arm,tag-latency and arm,data-latency are handled). 
> > 
> > Also, I'd prefer "-enable" to "-en".
> > 
> >> +- arm,pwr-control : Operting mode clock and power mode selection. Specifies two
> > 
> > s/Operting/Operating/
> > 
> > I'd prefer "power" to "pwr" (though there's precedent for both in
> > bindings...).
> > 
> >> +  cells of standby-mode-en and dynamic_clk_gating_en.
> > 
> > More boolean properties.
> > 
> >>  - interrupts : 1 combined interrupt.
> >>  - cache-id-part: cache id part number to be used if it is not present
> >>    on hardware
> > 
> > No amendments to the example?
> > 
> >> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> >> index 3b2c40b..188f4da 100644
> >> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> >> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> >> @@ -106,6 +106,29 @@
> >>  
> >>  #define L2X0_WAY_SIZE_SHIFT		3
> >>  
> >> +#define L2X0_PREFETCH_CTRL_OFFSET_SHIFT			0
> >> +#define L2X0_PREFETCH_CTRL_NOT_SAME_ID_SHIFT		21
> >> +#define L2X0_PREFETCH_CTRL_INC_DOUBLE_LINEFILL_SHIFT	23
> >> +#define L2X0_PREFETCH_CTRL_PREFETCH_DROP_SHIFT		24
> >> +#define L2X0_PREFETCH_CTRL_DOUBLE_LINEFILL_WR_SHIFT	27
> >> +#define L2X0_PREFETCH_CTRL_DATA_PREFETCH_EN_SHIFT	28
> >> +#define L2X0_PREFETCH_CTRL_INSTR_PREFETCH_EN_SHIFT	29
> >> +#define L2X0_PREFETCH_CTRL_DOUBLE_LINEFILL_EN_SHIFT	30
> >> +
> >> +#define PREFETCH_R2P0_MASK	(~(1 << L2X0_PREFETCH_CTRL_OFFSET_SHIFT))
> >> +#define PREFETCH_R3P0_MASK \
> >> +		(~((1 << L2X0_PREFETCH_CTRL_NOT_SAME_ID_SHIFT) | \
> >> +		   (1 << L2X0_PREFETCH_CTRL_INC_DOUBLE_LINEFILL_SHIFT) | \
> >> +		   (1 << L2X0_PREFETCH_CTRL_PREFETCH_DROP_SHIFT) | \
> >> +		   (1 << L2X0_PREFETCH_CTRL_DATA_PREFETCH_EN_SHIFT) | \
> >> +		   (1 << L2X0_PREFETCH_CTRL_INSTR_PREFETCH_EN_SHIFT) | \
> >> +		   (1 << L2X0_PREFETCH_CTRL_DOUBLE_LINEFILL_EN_SHIFT)))
> >> +#define PREFETCH_R3P1_MASK \
> >> +		(~(1 << L2X0_PREFETCH_CTRL_DOUBLE_LINEFILL_WR_SHIFT))
> >> +
> >> +#define L2X0_PWR_CTRL_STANDBY_MODE_EN_SHIFT	0
> >> +#define L2X0_PWR_CTRL_DYNAMIC_CLK_GATE_EN_SHIFT	1
> >> +
> >>  #ifndef __ASSEMBLY__
> >>  extern void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask);
> >>  #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
> >> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> >> index c465fac..490e182 100644
> >> --- a/arch/arm/mm/cache-l2x0.c
> >> +++ b/arch/arm/mm/cache-l2x0.c
> >> @@ -563,6 +563,11 @@ static void __init pl310_of_setup(const struct device_node *np,
> >>  	u32 data[3] = { 0, 0, 0 };
> >>  	u32 tag[3] = { 0, 0, 0 };
> >>  	u32 filter[2] = { 0, 0 };
> >> +	u32 prefetch[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
> >> +	u32 prefetch_val;
> >> +	u32 pwr[2] = { 0, 0 };
> >> +	u32 l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
> >> +		L2X0_CACHE_ID_RTL_MASK;
> >>  
> >>  	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
> >>  	if (tag[0] && tag[1] && tag[2])
> >> @@ -589,6 +594,45 @@ static void __init pl310_of_setup(const struct device_node *np,
> >>  		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L2X0_ADDR_FILTER_EN,
> >>  			       l2x0_base + L2X0_ADDR_FILTER_START);
> >>  	}
> >> +
> >> +	if (l2x0_revision >= L2X0_CACHE_ID_RTL_R2P0) {
> > 
> > You didn't describe that some properties were dependent on a particular
> > revision.
> > 
> >> +		of_property_read_u32_array(np, "arm,prefetch-control",
> >> +						prefetch, ARRAY_SIZE(prefetch));
> >> +		prefetch_val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
> >> +		prefetch_val &= PREFETCH_R2P0_MASK;
> >> +		prefetch_val |= prefetch[0] << L2X0_PREFETCH_CTRL_OFFSET_SHIFT;
> >> +		if (l2x0_revision >= L2X0_CACHE_ID_RTL_R3P0) {
> >> +			prefetch_val &= PREFETCH_R3P0_MASK;
> >> +			prefetch_val |=
> >> +			 ((prefetch[1]) <<
> >> +			   L2X0_PREFETCH_CTRL_NOT_SAME_ID_SHIFT) |
> >> +			 ((prefetch[2]) <<
> >> +			   L2X0_PREFETCH_CTRL_INC_DOUBLE_LINEFILL_SHIFT) |
> >> +			 ((prefetch[3]) <<
> >> +			   L2X0_PREFETCH_CTRL_PREFETCH_DROP_SHIFT) |
> >> +			 ((prefetch[5]) <<
> >> +			   L2X0_PREFETCH_CTRL_DATA_PREFETCH_EN_SHIFT) |
> >> +			 ((prefetch[6]) <<
> >> +			   L2X0_PREFETCH_CTRL_INSTR_PREFETCH_EN_SHIFT) |
> >> +			 ((prefetch[7]) <<
> >> +			   L2X0_PREFETCH_CTRL_DOUBLE_LINEFILL_EN_SHIFT);
> > 
> > You've not sanity checked these properties. What If I typo a value as
> > something other than 0 or 1?
> > 
> > Use boolean properties and of_property_read_bool (or even better,
> > configure this dynamically based on revision rather than having a dt
> > description).
> > 
> >> +			if (l2x0_revision >= L2X0_CACHE_ID_RTL_R3P1) {
> >> +				prefetch_val &= PREFETCH_R3P1_MASK;
> >> +				prefetch_val |=
> >> +				 ((prefetch[4]) <<
> >> +				   L2X0_PREFETCH_CTRL_DOUBLE_LINEFILL_WR_SHIFT);
> >> +			}
> > 
> > Another undocumented revision dependency.
> > 
> >> +			writel_relaxed(prefetch_val,
> >> +					l2x0_base + L2X0_PREFETCH_CTRL);
> >> +
> >> +			of_property_read_u32_array(np, "arm,pwr-control",
> >> +						pwr, ARRAY_SIZE(pwr));
> >> +			writel_relaxed(
> >> +			 ((pwr[0]) << L2X0_PWR_CTRL_STANDBY_MODE_EN_SHIFT) |
> >> +			 ((pwr[1]) << L2X0_PWR_CTRL_DYNAMIC_CLK_GATE_EN_SHIFT),
> >> +			   l2x0_base + L2X0_POWER_CTRL);
> > 
> > Again, use boolean properties or do this dynamically.
> > 
> > Do none of these values need to be saved for the resume callback?
> > 
> > Thanks,
> > Mark.
> > 
> >> +		}
> >> +	}
> >>  }
> >>  
> >>  static void __init pl310_save(void)
> >> -- 
> >> 1.7.9.5
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>
> 
> 
