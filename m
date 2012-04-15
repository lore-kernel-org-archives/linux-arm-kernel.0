From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 15 Apr 2012 15:01:35 +0800
Subject: [PATCH 4/7] dt/clock: Add handling for fixed clocks and a clock
 node setup iterator
In-Reply-To: <4F8A3ABA.2080201@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-5-git-send-email-robherring2@gmail.com>
 <20120314075930.GF21337@S2101-09.ap.freescale.net>
 <4F81A53B.7020804@gmail.com>
 <20120409084930.GA18692@S2101-09.ap.freescale.net>
 <4F82EFB3.80402@gmail.com>
 <20120409232723.GD18692@S2101-09.ap.freescale.net>
 <4F8A3ABA.2080201@gmail.com>
Message-ID: <20120415070132.GE24997@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2012 at 10:04:26PM -0500, Rob Herring wrote:
...
> So you want to have generic bindings for every clock which implies a
> bunch of nodes if not a node per clock anyway, but then object to 3
> nodes for fixed clocks.
> 
I do not really care about that now, as long as you clearly document
in fixed clock binding that there is no multiple outputs support for
fixed-clock, and #clock-cells has to be 0.

...
> I'm talking about the bindings and you are pointing me to an
> implementation with no bindings. It's 2 different things. The
> implementation can fully be the generic clk implementations, but the
> clock bindings can still be either a node per clock or a monolithic
> clock module node. There is no fixed rule here and there should not be.
> We can each chose what works best for us.
> 
It will be a pity if we can not have a generic binding for a generic
implementation.

> I see a couple of examples that your clocks are still SoC specific
> despite your claims.
> 
> Your clock gates may reuse clk_gate struct, but they still have custom
> ops to handle the 2-bit field. Obviously, you decided not to merge 2-bit
> field support into the existing clk gate code (the correct decision
> IMHO). I made a similar decision.
> 
Actually, Sascha decided.

> For practically every clock, you need to set the spinlock to
> imx_ccm_lock. How are you going to know which clocks to set this lock
> for with a "generic" binding? You have to distinguish those from IPU
> clocks for example.
> 
Something like this:

void __init of_clk_divider_setup(struct device_node *node, spinlock_t *lock)
{
        [ parse clock-divider properties from node ]

        clk = clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
                        reg, shift, width, 0, &lock);
        if (clk)
                of_clk_add_provider(node, NULL, clk);
}

void __init imx_clk_divider_init(struct device_node *node)
{
        return of_clk_divider_setup(node, &imx_ccm_lock);
}

static const struct of_device_id imx_clk_match[] __initconst = {
        { .compatible = "fsl,clock-divider", .data = imx_clk_divider_init, },
        {}
};

void __init imx_clocks_init(void)
{
        of_clk_init(imx_clk_match);
}

When I say generic binding, it does not necessarily mean the generic
compatible string, but the property definition and generic DT setup
code for them, something similar as generic regulator binding
Documentation/devicetree/bindings/regulator/regulator.txt and the
setup/parse function of_get_regulator_init_data.

Honestly, I'm losing my interest on clock binding.  I will stay with
clk_lookup before I see a solution to how we represent part of the
clock tree in DT while their input/parent clocks in the clock code.

-- 
Regards,
Shawn
