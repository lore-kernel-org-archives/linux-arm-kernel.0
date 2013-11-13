From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 13 Nov 2013 15:18:02 +0100
Subject: [PATCH] clk: add specified-rate clock
In-Reply-To: <52838834.4010104@imgtec.com>
References: <1368189862-17119-1-git-send-email-james.hogan@imgtec.com>
 <20130529173938.6058.96646@quantum> <52838834.4010104@imgtec.com>
Message-ID: <5867382.IN2EZ2ivg4@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James, Mike,

On Wednesday 13 of November 2013 14:09:56 James Hogan wrote:
> On 29/05/13 18:39, Mike Turquette wrote:
> > Quoting James Hogan (2013-05-10 05:44:22)
> >> The frequency of some SoC's external oscillators (for example TZ1090's
> >> XTAL1) are configured by the board using pull-ups/pull-downs of
> >> configuration pins, the logic values of which are automatically latched
> >> on reset and available in an SoC register. Add a generic clock component
> >> and DT bindings to handle this.
> >>
> >> It behaves similar to a fixed rate clock (read-only), except it needs
> >> information about a register field (reg, shift, width), and the
> >> clock-frequency is a mapping from register field values to clock
> >> frequencies.
> >>
> > 
> > James,
> > 
> > Thanks for sending this!  It looks mostly good and is a useful clock
> > type to support.  Comments below.
> 
> Hi Mike,
> 
> Sorry for slight delay getting back to you. I had another think about
> this stuff yesterday...
> 

Just a random idea that came to my mind while reading this thread:

What about modelling this as a set of fixed rate clocks fed into
a read-only mux?

Best regards,
Tomasz

> > 
> > <snip>
> >> diff --git a/Documentation/devicetree/bindings/clock/specified-clock.txt b/Documentation/devicetree/bindings/clock/specified-clock.txt
> >> new file mode 100644
> >> index 0000000..b36ccf9
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/specified-clock.txt
> >> @@ -0,0 +1,39 @@
> >> +Binding for fixed-rate clock sources with readable configuration.
> >> +
> >> +This binding uses the common clock binding[1].
> >> +
> >> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> +
> >> +Required properties:
> >> +- compatible         : Shall be "specified-clock".
> >> +- #clock-cells       : From common clock binding; shall be set to 0.
> >> +- reg                : Address of configuration register.
> >> +- shift              : Shift of config value field in configuration register.
> >> +- width              : Width of config value field in configuration register.
> > 
> > It might be better to make this a mask instead of the width.  We have
> > already hit this issue with the mux table on Nvidia where arbitrary
> > masks are necessary.  Mask + shift probably helps future-proof us a bit.
> 
> Yes, thanks. I've now borrowed the bit-mask and bit-shift from your mux
> binding proposals (including defaulting shift to ffs(mask)-1 ... nice).
> 
> > 
> > The rest of the binding looks good.
> > 
> > <snip>
> >> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> >> index e7f7fe9..1343179 100644
> >> --- a/drivers/clk/Makefile
> >> +++ b/drivers/clk/Makefile
> >> @@ -8,6 +8,7 @@ obj-$(CONFIG_COMMON_CLK)        += clk-fixed-rate.o
> >>  obj-$(CONFIG_COMMON_CLK)       += clk-gate.o
> >>  obj-$(CONFIG_COMMON_CLK)       += clk-mux.o
> >>  obj-$(CONFIG_COMMON_CLK)       += clk-composite.o
> >> +obj-$(CONFIG_COMMON_CLK)       += clk-specified-rate.o
> > 
> > One thing that does occur to me is that this could potentially be
> > combined with the fixed-rate clock.  If the properties for a specified
> > rate existing in the DT data then this code applies, otherwise the
> > existing fixed-rate code is used.  I don't have a strong opinion about
> > combining the code, but something to consider.
> 
> That's actually a much neater solution. Because the clock is still
> fixed, the register value can be read once while processing the DT node,
> and an otherwise normal fixed rate clock created at the right frequency.
> It doesn't even need to allocate memory to store the table.
> 
> The remaining question is whether to extend the fixed-clock binding or
> have a separate one. I'm in two minds. On the one hand it is a
> fixed-rate clock, on the other hand the only shared properties at the
> moment would be standard clock properties (clock-output-names etc), so
> I'm probably leaning towards a separate binding. I'll send an updated
> patchset soon.
> 
> > 
> > <snip>
> >> +#ifdef CONFIG_OF
> >> +/**
> >> + * of_specified_clk_setup() - Setup function for specified fixed rate clock
> >> + */
> >> +void __init of_specified_clk_setup(struct device_node *node)
> >> +{
> >> +       struct clk *clk;
> >> +       const char *clk_name = node->name;
> >> +       u32 shift, width, rate;
> >> +       void __iomem *reg;
> >> +       int len, num_rates, i;
> >> +       struct property *prop;
> >> +       struct clk_specified_rate_entry *rates;
> >> +       const __be32 *p;
> >> +
> >> +       of_property_read_string(node, "clock-output-names", &clk_name);
> >> +
> >> +       if (of_property_read_u32(node, "shift", &shift)) {
> >> +               pr_err("%s(%s): could not read shift property\n",
> >> +                      __func__, clk_name);
> >> +               return;
> >> +       }
> >> +
> >> +       if (of_property_read_u32(node, "width", &width)) {
> >> +               pr_err("%s(%s): could not read width property\n",
> >> +                      __func__, clk_name);
> >> +               return;
> >> +       }
> >> +
> >> +       reg = of_iomap(node, 0);
> >> +       if (!reg) {
> >> +               pr_err("%s(%s): of_iomap failed\n",
> >> +                      __func__, clk_name);
> >> +               return;
> >> +       }
> >> +
> >> +       /* check clock-frequency exists */
> >> +       prop = of_find_property(node, "clock-frequency", &len);
> >> +       if (!prop) {
> >> +               pr_err("%s(%s): could not find clock-frequency property\n",
> >> +                      __func__, clk_name);
> >> +               goto err_iounmap;
> >> +       }
> >> +
> >> +       if (len & (sizeof(u32)*2 - 1)) {
> >> +               pr_err("%s(%s): clock-frequency has invalid size of %d bytes\n",
> >> +                      __func__, clk_name, len);
> >> +               goto err_iounmap;
> >> +       }
> >> +       num_rates = len / (sizeof(*rates)*2);
> > 
> > This tripped me up for a few minutes.  I think it is a bit weird to
> > count bytes as a way to validate length and determine the number of
> > pairs.
> 
> Yes, and I actually recently discovered that this is wrong anyway. rates
> is a struct of two elements so it ends up dividing twice, and it just so
> happened that all the boards I have (until I hacked up qemu to report a
> different frequency) specify a value in the first half of those defined. :)
> 
> Thanks
> James
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
