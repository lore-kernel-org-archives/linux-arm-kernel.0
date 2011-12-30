From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 30 Dec 2011 19:08:43 +0800
Subject: [PATCH 1/1] regulator/fixed: set constraints.apply_uV to 0
In-Reply-To: <20111230104850.GE2766@opensource.wolfsonmicro.com>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
 <20111230103026.GA2766@opensource.wolfsonmicro.com>
 <20111230103830.GD2414@b20223-02.ap.freescale.net>
 <20111230104850.GE2766@opensource.wolfsonmicro.com>
Message-ID: <20111230110842.GE2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 10:48:50AM +0000, Mark Brown wrote:
> On Fri, Dec 30, 2011 at 06:38:31PM +0800, Richard Zhao wrote:
> 
> > So what's your suggestion of the issue? Below fixed regulator failed
> > to register.
> 
> It shouldn't actually be passing on the constraint setting the voltage
> when it constructs the constraints.
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -34,9 +34,6 @@ static void of_get_regulation_constraints(struct device_node *np,
        /* Voltage change possible? */
        if (constraints->min_uV != constraints->max_uV)
                constraints->valid_ops_mask |= REGULATOR_CHANGE_VOLTAGE;
-       /* Only one voltage?  Then make sure it's set. */
-       if (constraints->min_uV == constraints->max_uV)
-               constraints->apply_uV = true;
 
        uV_offset = of_get_property(np, "regulator-microvolt-offset", NULL);
        if (uV_offset)


Make sense?

Thanks
Richard
