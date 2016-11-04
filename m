From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Nov 2016 12:21:07 +0000
Subject: [PATCH] bus: vexpress-config: fix device reference leak
In-Reply-To: <1478259746.17152.126.camel@arm.com>
References: <1477997017-29103-1-git-send-email-johan@kernel.org>
 <1478259746.17152.126.camel@arm.com>
Message-ID: <20161104122107.GA1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 11:42:26AM +0000, Pawel Moll wrote:
> On Tue, 2016-11-01 at 11:43 +0100, Johan Hovold wrote:
> > Make sure to drop the reference to the parent device taken by
> > class_find_device() after populating the bus.
> > 
> > Fixes: 3b9334ac835b ("mfd: vexpress: Convert custom func API to
> > regmap")
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> You're right. May I ask how did you figure it out? The get_device()
> happening in class_find_device() is a bit obscure,

It's not obscure at all - all the functions that find a device do so
under a lock to ensure that the device does not go away, and they
take a reference count on the device before returning the pointer for
exactly the same reason.

If they didn't do that, the find function could locate a struct device
while another thread is deleting the struct device, and it would then
return a stale pointer - and dereferencing that pointer would then be
a use-after-free bug.

So not obscure, but rather fundamentally necessary.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
