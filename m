From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 31 Jan 2017 22:38:51 +0100
Subject: [PATCH 09/11] drm/panel: Add support for the Raspberry Pi 7"
 Touchscreen.
In-Reply-To: <20170131211952.jirg7scbzajshpec@phenom.ffwll.local>
References: <20161214194621.16499-1-eric@anholt.net>
 <20161214194621.16499-10-eric@anholt.net>
 <20170131210717.GA872@mithrandir.ba.sec>
 <20170131211952.jirg7scbzajshpec@phenom.ffwll.local>
Message-ID: <20170131213849.GD872@mithrandir.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 10:19:52PM +0100, Daniel Vetter wrote:
> On Tue, Jan 31, 2017 at 10:07:19PM +0100, Thierry Reding wrote:
> > On Wed, Dec 14, 2016 at 11:46:19AM -0800, Eric Anholt wrote:
> > > +static int rpi_touchscreen_dsi_remove(struct mipi_dsi_device *dsi)
> > > +{
> > > +	struct device *dev = &dsi->dev;
> > > +	struct rpi_touchscreen *ts = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret = mipi_dsi_detach(dsi);
> > > +	if (ret < 0) {
> > > +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> > > +		return ret;
> > > +	}
> > 
> > You might want to continue after this anyway, because the driver will be
> > unloaded regardless of your error code and you'll leave behind a
> > dangling panel and leak a reference to the I2C bridge.
> 
> Sounds like we should switch the mipi_dsi_driver->remove callback to
> return void then? But separate cleanup series if someone bothers with it.

I think there are advantages to keeping this consistent with the driver
core's definition of ->remove(). There have been efforts lately to deny
unloading drivers if they are a dependency for other drivers, so we may
yet see the day where the driver core actually does something with this
return value.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/3cf85fc7/attachment-0001.sig>
