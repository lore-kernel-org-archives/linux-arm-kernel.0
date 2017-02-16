From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 16 Feb 2017 10:26:32 +0100
Subject: [PATCH v2 1/4] dt-bindings: add multidomain support to i.MX GPC
 DT binding
In-Reply-To: <20170216013526.GB8398@dragon>
References: <20170127183728.26701-1-l.stach@pengutronix.de>
 <1486741439.3879.7.camel@pengutronix.de> <20170215070830.GA8398@dragon>
 <1487150765.2304.65.camel@pengutronix.de> <20170216013526.GB8398@dragon>
Message-ID: <1487237192.13536.15.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 16.02.2017, 09:35 +0800 schrieb Shawn Guo:
> On Wed, Feb 15, 2017 at 10:26:05AM +0100, Lucas Stach wrote:
> > Am Mittwoch, den 15.02.2017, 15:08 +0800 schrieb Shawn Guo:
> > > On Fri, Feb 10, 2017 at 04:43:59PM +0100, Lucas Stach wrote:
> > > > Hi Shawn,
> > > > 
> > > > are you willing to take this series through your tree or do you think we
> > > > need to get this in via some other tree?
> > > 
> > > I'm willing to take it.  But I don't think it's been ready yet.  Since
> > > you insist on keeping the .remove hook for both imx_gpc_driver and
> > > imx_pgc_power_domain_driver, did you actually test it with manually
> > > bind/unbind the drivers?  I tested it a bit and found it doesn't work
> > > well for me.
> > 
> > It works as well as it could at this point. The driver unloads fine, but
> > obviously anything that depends on it is broken at that point. Try
> > unloading a regulator driver, it's the same experience.
> > 
> > This will get better once the functional dependency stuff is far enough
> > to either block unloading of drivers providing resources to other
> > devices, or unload the dependent drivers first.
> 
> I'm seeing two problems with my testing.  I need some help to understand
> whether they are expected.
> 
> 1. There is an error message with imx-pgc-power-domain.1 unbind.
> 
> root at arm:~# echo imx-pgc-power-domain.1 > /sys/bus/platform/drivers/imx-pgc-pd/unbind
> [   31.934370] genpd_remove: unable to remove PU

That is expected at this point, as the PU domain is still in use and
there is no functional dependency yet, that would unbind the consumers.

I'll see if I can make the necessary change in genpd, but I wouldn't
like to block this patchset on that, as this is an infrastructure
change.

Note that not providing the .remove hook will not print this error, but
still leave the PU domain in a unusable state, as the driver is still
going away. 

> 
> 2. Unbind 20dc000.gpc and bind again causes a fat kernel warning and
> drops out console login.

This is kind of expected, as we re-register the GPC child devices. As
the functional dependency stuff has landed in 4.10, I'll add the
necessary calls in the next version of this patchset, so GPC unbind/bind
is properly handled.

Regards,
Lucas
