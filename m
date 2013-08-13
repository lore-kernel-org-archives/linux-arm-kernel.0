From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 13 Aug 2013 12:36:50 -0400
Subject: [PATCH 2/8] clk: keystone: Add gate control clock driver
In-Reply-To: <20130813161314.GR27165@e106331-lin.cambridge.arm.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
 <1375719147-7578-3-git-send-email-santosh.shilimkar@ti.com>
 <20130813161314.GR27165@e106331-lin.cambridge.arm.com>
Message-ID: <520A60A2.2030104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 August 2013 12:13 PM, Mark Rutland wrote:
> [adding dt maintainers]
> 
> On Mon, Aug 05, 2013 at 05:12:21PM +0100, Santosh Shilimkar wrote:
>> Add the driver for the clock gate control which uses PSC (Power Sleep
>> Controller) IP on Keystone 2 based SOCs. It is responsible for enabling and
>> disabling of the clocks for different IPs present in the SoC.
>>
>> Cc: Mike Turquette <mturquette@linaro.org>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  .../devicetree/bindings/clock/keystone-gate.txt    |   30 ++
>>  drivers/clk/keystone/gate.c                        |  306 ++++++++++++++++++++
>>  include/linux/clk/keystone.h                       |    1 +
>>  3 files changed, 337 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/keystone-gate.txt
>>  create mode 100644 drivers/clk/keystone/gate.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/keystone-gate.txt b/Documentation/devicetree/bindings/clock/keystone-gate.txt
>> new file mode 100644
>> index 0000000..40afef5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/keystone-gate.txt
>> @@ -0,0 +1,30 @@
>> +Binding for Keystone gate control driver which uses PSC controller IP.
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible : shall be "keystone,psc-clk".
> 
> Similarly to my comments on patch 1, this should probably be something
> more like "ti,keystone-psc-clock"
> 
>> +- #clock-cells : from common clock binding; shall be set to 0.
>> +- clocks : parent clock phandle
>> +- reg :        psc address address space
>> +
>> +Optional properties:
>> +- clock-output-names : From common clock binding to override the
>> +                       default output clock name
>> +- status : "enabled" if clock is always enabled
> 
> Huh? This is a standard property, for which ePAPR defines "okay",
> "disabled", "fail", and "fail-sss", and not "enabled". This also doesn't
> seem to follow the standard meaning judging by the code.
> 
> It looks like this could be a boolean property
> ("clock-always-enabled"?), but that assumes it's necessary.
> 
> Why do you need this?
> 
I dropped this already. Forgot to update the documentation.

>> +- lpsc : lpsc module id, if not set defaults to zero
> 
> What's that needed for? Are there multiple clocks sharing a common
> register bank?
> 
>> +- pd : power domain number, if not set defaults to zero (always ON)
> 
> Please don't use abbreviations unnecessarily. "power-domain-id" or
> similar would be far better. What exactly does this represent? Does the
> clock IP itself handle power domains, or is there some external unit
> that controls power domains?
> 
pd is commonly used but I can expand it. This represent the power
domain number.

>> +- gpsc : gpsc number, if not set defaults to zero
> 
> How does that interact with the lpsc property? When are these necessary?
> 
lpsc is local clock/module control where as gpsc sits on top of it. 

>> diff --git a/drivers/clk/keystone/gate.c b/drivers/clk/keystone/gate.c
>> new file mode 100644
>> index 0000000..72ac478
>> --- /dev/null
>> +++ b/drivers/clk/keystone/gate.c

[..]

>> +/**
>> + * clk_register_psc - register psc clock
>> + * @dev: device that is registering this clock
>> + * @name: name of this clock
>> + * @parent_name: name of clock's parent
>> + * @psc_data: platform data to configure this clock
>> + * @lock: spinlock used by this clock
>> + */
>> +static struct clk *clk_register_psc(struct device *dev,
>> +                       const char *name,
>> +                       const char *parent_name,
>> +                       struct clk_psc_data *psc_data,
>> +                       spinlock_t *lock)
>> +{
>> +       struct clk_init_data init;
>> +       struct clk_psc *psc;
>> +       struct clk *clk;
>> +
>> +       psc = kzalloc(sizeof(*psc), GFP_KERNEL);
>> +       if (!psc)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name = name;
>> +       init.ops = &clk_psc_ops;
>> +       init.flags = psc_data->flags;
>> +       init.parent_names = (parent_name ? &parent_name : NULL);
> 
> Is &parent_name not a pointer to a pointer on the stack? Is this only
> used once?
> 
>> +       init.num_parents = (parent_name ? 1 : 0);
>> +
>> +       psc->psc_data = psc_data;
>> +       psc->lock = lock;
>> +       psc->hw.init = &init;
> 
> That's definitely a pointer to some data on the stack, and that seems to
> be kept around. Is this only used for one-time initialisation, or might
> it be used later?
> 
Its init only.

>> +       data->base = psc_addr[gpsc].io_base;
>> +       data->lpsc = lpsc;
>> +       data->gpsc = gpsc;
>> +       data->domain = pd;
>> +
>> +       if (of_property_read_bool(node, "ti,psc-lreset"))
>> +               data->psc_flags |= PSC_LRESET;
>> +       if (of_property_read_bool(node, "ti,psc-force"))
>> +               data->psc_flags |= PSC_FORCE;
> 
> Neither of these were defined in the binding, and they don't appear to
> have been inherited form another binding. What are they for? Why are
> they needed?
> 
They represent the hardware support transition method needed to have
proper clock enable/disable sequence to work. Will update the binding
along with other comments which I agree.

>> +
>> +       clk = clk_register_psc(NULL, clk_name, parent_name,
>> +                               data, lock);
>> +
>> +       if (clk) {
>> +               of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +
>> +               rc = of_property_read_string(node, "status", &status);
>> +               if (status && !strcmp(status, "enabled"))
>> +                       clk_prepare_enable(clk);
>> +               return;
>> +       }
> 
> As mentioned above, this abuses the standard status property, and it's
> not clear why this is necessary.
> 
Actually I have removed this one from dt nodes. Looks like missed
to pick the right patch while posting. Have dropped this change
already.

Regards,
Santosh
