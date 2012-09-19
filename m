From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 19 Sep 2012 17:58:25 +0100
Subject: [PATCH v2 04/13] regulators: Versatile Express regulator driver
In-Reply-To: <20120919022141.GA8832@opensource.wolfsonmicro.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
 <20120918150212.GA12543@opensource.wolfsonmicro.com>
 <1347983056.11116.11.camel@hornet>
 <20120918160909.GA15587@opensource.wolfsonmicro.com>
 <1347987819.11116.38.camel@hornet>
 <20120919022141.GA8832@opensource.wolfsonmicro.com>
Message-ID: <1348073905.11116.80.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-09-19 at 03:21 +0100, Mark Brown wrote:
> No, I mean discovering which regulators are present and what they can
> do.

Nope. This driver is supposed to work only on Device Tree "enabled"
platforms. Having said that, I should have added the bindings
documentation in the patch. Will do.

> > > So this is going to break interoperation with a bunch of consumer
> > > drivers that rely on being able to tell what voltages are supported.
> > > The key thing for them would be that regulator_is_supported_voltage()
> > > works, currently it relies on list_voltage() as that's the only way to
> > > do that right now.
> 
> > Ok, I guess I should use regulator_list_voltage_linear() and
> > regulator_map_voltage_linear() then? I'll just have to carefully think
> > what step to choose.
> 
> No, we should provide a way to describe this situation in the API - it's
> not unreasonable and having to pick step sizes is obviously suboptimal.

Actually before I finally got this mail (our mail system was playing
stupid today), I came up with idea of using the power supply specified
tolerance as a base to chose the step sizes. This comes down to such
code (with the regulator_*_voltage_linear in the ops):

8<---
                int range = init_data->constraints.max_uV -
                                init_data->constraints.min_uV;
                u32 tolerance;
                int avg_error;

                err = of_property_read_u32(pdev->dev.of_node,
                                "arm,vexpress-volt,tolerance", &tolerance);
                if (err)
                        goto error_property_read;

                reg->desc.min_uV = init_data->constraints.min_uV;
                avg_error = (range / 2 + reg->desc.min_uV) * tolerance / 100;
                reg->desc.n_voltages = range / avg_error + 1;
                reg->desc.uV_step = range / (reg->desc.n_voltages - 1);
8<---

so it doesn't look that bad to me. Now, if you are considering changing
the API, I would propose something like this:

8<---
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4838531..a091719 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1948,8 +1948,14 @@ int regulator_is_supported_voltage(struct regulator *regulator,
        }
 
        ret = regulator_count_voltages(regulator);
-       if (ret < 0)
-               return ret;
+       if (ret < 0) {
+               /* No operating points defined, allow any value within range */
+               struct regulation_constraints *constraints =
+                               regulator->rdev->constraints;
+
+               return min_uV >= constraints->min_uV &&
+                               max_uV <= constraints->max_uV;
+       }
        voltages = ret;
 
        for (i = 0; i < voltages; i++) {
8<---

I originally assumed that if I provide no operating points (in the form
of list_voltage function) any voltage within the constraints range will
be allowed.

Both options are perfectly fine with me.

Thanks!

Pawel
