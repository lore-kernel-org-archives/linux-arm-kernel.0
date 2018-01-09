From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 09 Jan 2018 15:55:38 +0100
Subject: soc: imx: gpcv2: removing and probing fails
In-Reply-To: <d71311e13720724b3b3bccd06fe9309b@agner.ch>
References: <3f836677c6e98aaf01bc1ac8c3410083@agner.ch>
 <1515507886.12538.33.camel@pengutronix.de>
 <d71311e13720724b3b3bccd06fe9309b@agner.ch>
Message-ID: <1515509738.12538.35.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 09.01.2018, 15:44 +0100 schrieb Stefan Agner:
> On 2018-01-09 15:24, Lucas Stach wrote:
> > Am Sonntag, den 07.01.2018, 11:48 +0100 schrieb Stefan Agner:
> > > Hi Andrew,
> > > 
> > > I noticed that the driver fails when removing and probing again.
> > > As far
> > > as I can see due to duplicate add of the platform devices.
> > > 
> > > As far as I can tell the driver should register the remove
> > > callback and
> > > do a platform_device_unregister on the newly created platform
> > > devices.
> > > However, as far as I can tell we don't hold on to a reference to
> > > them...
> > > I guess we could keep references in imx_gpcv2_probe, but maybe
> > > there is
> > > an easier way?
> > 
> > The GPC v1 driver adds the necessary device dependency between the
> > power domain devices and the GPC parent device. See the
> > device_link_add() in imx_pgc_power_domain_probe().
> 
> Note that despite device_link_add, GPC v1 seems to cause issue with
> CONFIG_DEBUG_TEST_DRIVER_REMOVE=y:
> https://marc.info/?l=linux-arm-kernel&m=151544599904423&w=4
> 
> (sorry, I made it confusing, by adding a stack trace when using GPC
> v1
> in the gpcv2 thread...)

IMHO this is an issue with the?CONFIG_DEBUG_TEST_DRIVER_REMOVE option,
as it just blindly calls the remove callback instead of doing a proper
__device_release_driver(). All the regular driver/device unbind paths
will properly unbind the consumer devices before removing the driver.

I think this should be fixed in the device driver core instead of
individual drivers.

Regards,
Lucas
