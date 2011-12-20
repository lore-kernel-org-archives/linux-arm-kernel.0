From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 Dec 2011 10:01:02 +0800
Subject: [PATCH v3 1/3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111220005708.GM2860@opensource.wolfsonmicro.com>
References: <1323702958-4831-1-git-send-email-shawn.guo@linaro.org>
 <1323702958-4831-2-git-send-email-shawn.guo@linaro.org>
 <20111220005708.GM2860@opensource.wolfsonmicro.com>
Message-ID: <20111220020101.GD5683@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 12:57:09AM +0000, Mark Brown wrote:
> On Mon, Dec 12, 2011 at 11:15:56PM +0800, Shawn Guo wrote:
> 
> > +Sub-nodes:
> > +- regulators : Contain the regulator nodes.  The name of regulator node
> > +  is being used by mc13xxx regulator driver to find the correct relator
> > +  device.
> 
> Reading this I'm not clear what the name of the node is, or what the
> valid node names are.
> 
In the example below, the name would be 'mc13892__sw1'.

> > +			sw1_reg: mc13892__sw1 {
> 
> The examples don't really elucidate this either (and the __ is rather
> odd).

Yes, that's because the name defined by mc13892 regulator driver is odd.

There is a '_' in 'MC13892_' when using MC13xxx_DEFINE below.

#define MC13892_SW_DEFINE(name, reg, vsel_reg, voltages)        \
        MC13xxx_DEFINE(MC13892_, name, reg, vsel_reg, voltages, \
                        mc13892_sw_regulator_ops)

And the second one comes from the definition of .name below.

#define MC13xxx_DEFINE(prefix, _name, _reg, _vsel_reg, _voltages, _ops) \
        [prefix ## _name] = {                           \
                .desc = {                                               \
                        .name = #prefix "_" #_name,                     \

Using the regulator name to find the correct device is the approach I
can see that brings the least churn to the existing driver.  You may
think the regulator name is Linux mc13892 regulator driver specific.
But I think it should be something from hardware manual and should be
used in driver and device tree consistently.  Unfortunately, the driver
created an odd name first, and we have to use that name in device tree
to minimize the diff stat.

-- 
Regards,
Shawn
