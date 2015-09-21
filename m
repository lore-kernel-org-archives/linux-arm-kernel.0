From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2015 20:32:07 +0100
Subject: [PATCH 1/7] phy: fix of_mdio_find_bus() device refcount leak
In-Reply-To: <20150921.120159.326170798236851436.davem@davemloft.net>
References: <20150918094625.GB21084@n2100.arm.linux.org.uk>
 <E1ZcsNb-0001Bf-U5@rmk-PC.arm.linux.org.uk>
 <20150921.120159.326170798236851436.davem@davemloft.net>
Message-ID: <20150921193206.GU21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 12:01:59PM -0700, David Miller wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Date: Fri, 18 Sep 2015 10:54:55 +0100
> 
> > Update the comment, and arrange for the only user of this function
> > to drop this refcount when disposing of a reference to it.
> 
> mdio_mux is not the only user of of_mdio_find_bus(), DSA uses it as
> well.
> 
> So if anything this commit message is inaccurate.

Yes, I missed that as it wasn't under drivers/net.  It doesn't change
the validity of this patch, the existing code is wrong and I'm not
introducing anything that makes the code any more wrong than it is.

I'll fix the commit message, and I'll fix the DSA code too but in a
separate patch.  Thanks for pointing it out.

> I also wonder about this refcounting scheme.

It's the standard driver model refcounting rules that we've lived with
for about a decade, ever since the driver model was introduced by
Patrick Mochel.

> If you are going to drop the inner device reference, then we take the
> mdio bus returned from of_mdio_find_bus() what holds onto it and keeps
> it from disappearing on us?
> 
> Don't we have to hold onto some reference count of some kind here?

In the case of the mdio mux code, I'm dropping the reference when
either (a) we've encountered an error during initialisation and we're
cleaning up, or (b) when the mdio mux code is being torn down after
the mdiomux bus has been unregistered and freed.  In both cases, we're
done with the mdio bus that was returned from of_mdio_find_bus().

In case (a), the devres code will release the kmalloc'd memory when
mdio_mux_gpio_probe() or mdio_mux_mmioreg_probe() propagates the error
out of their probe() function.

I'm not sure why you think anything is wrong here - maybe it's the odd
code structure to the success path at the bottom of mdio_mux_init()?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
