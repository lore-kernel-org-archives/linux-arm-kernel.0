From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Apr 2018 17:08:33 +0100
Subject: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
In-Reply-To: <20180423072301.11962-8-peda@axentia.se>
References: <20180423072301.11962-1-peda@axentia.se>
 <20180423072301.11962-8-peda@axentia.se>
Message-ID: <20180423160833.GF16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
>  static int tda998x_remove(struct i2c_client *client)
>  {
> -	component_del(&client->dev, &tda998x_ops);
> +	struct device *dev = &client->dev;
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +
> +	drm_bridge_remove(&bridge->bridge);
> +	component_del(dev, &tda998x_ops);
> +

I'd like to ask a rather fundamental question about DRM bridge support,
because I suspect that there's a major fsckup here.

The above is the function that deals with the TDA998x device being
unbound from the driver.  With the component API, this results in the
DRM device correctly being torn down, because one of the hardware
devices has gone.

With DRM bridge, the bridge is merely removed from the list of
bridges:

void drm_bridge_remove(struct drm_bridge *bridge)
{
        mutex_lock(&bridge_lock);
        list_del_init(&bridge->list);
        mutex_unlock(&bridge_lock);
}
EXPORT_SYMBOL(drm_bridge_remove);

and the memory backing the "struct tda998x_bridge" (which contains
the struct drm_bridge) will be freed by the devm subsystem.

However, there is no notification into the rest of the DRM subsystem
that the device has gone away.  Worse, the memory that is still in
use by DRM has now been freed, so further use of the DRM device
results in a use-after-free bug.

This is really not good, and to me looks like a fundamental problem
with the DRM bridge code.  I see nothing in the DRM bridge code that
deals with the lifetime of a "DRM bridge" or indeed the lifetime of
the actual device itself.

So, from what I can see, there seems to be a fundamental lifetime
issue with the design of the DRM bridge code.  This needs to be
fixed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
