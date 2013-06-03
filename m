From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Jun 2013 13:42:10 -0400
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <20130603190954.3bd52784@skate>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603165753.GL3803@titan.lakedaemon.net>
 <20130603190954.3bd52784@skate>
Message-ID: <20130603174210.GM3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 07:09:54PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Mon, 3 Jun 2013 12:57:53 -0400, Jason Cooper wrote:
> 
> > Won't this override a user editing the 'local-mac-address' property in
> > the dts?  Since we're dealing with appended dtbs, there's a higher
> > probability of the user doing such a thing.
> > 
> > I'll admit it's a corner case, but I'd like to make sure we've thought
> > through the use cases and aren't making things more complicated than
> > necessary.
> 
> I don't have a strong opinion about this one, so if it's seen as being
> necessary to preserve a potentially existing 'local-mac-address', then
> I'll add the necessary checks to only update the property if it doesn't
> already exist.

hmmm, of_get_mac_address() give preferences to 'mac_address' and has the
following comment:

/**
 * Search the device tree for the best MAC address to use.
 * 'mac-address' is checked first, because that is supposed to contain
 * to "most recent" MAC address. If that isn't set, then
 * 'local-mac-address' is checked next, because that is the default
 * address.  If that isn't set, then the obsolete 'address' is checked,
 * just in case we're using an old device tree.
 *
 * Note that the 'address' property is supposed to contain a virtual
 * address of the register set, but some DTS files have redefined that
 * property to be the MAC address.
 *
 * All-zero MAC addresses are rejected, because those could be
 * properties that exist in the device tree, but were not set by U-Boot.
 * For example, the DTS could define 'mac-address' and
 * 'local-mac-address', with zero MAC addresses.  Some older U-Boots
 * only initialized 'local-mac-address'.  In this case, the real MAC is
 * in 'local-mac-address', and 'mac-address' exists but is all zeros.
*/

So the real (minor) problem is that we require 'local-mac-address' in the
binding.  And say nothing about mac-address.

u-boot, v2013.04 sets both mac-address and local-mac-address
from the environment in fdt_fixup_ethernet() and doesn't check to see if
it's already populated with a valid mac :(

barebox doesn't appear to set the mac-address, and relies on the dtb.

Since we really only have to worry about legacy u-boot with ATAGs, we
should mimic the behavior of u-boot to date.  The mac address found in
the u-boot environment is the canonical source for the mac address.
This would have the added bonus that flash-kernel (debian kernel
installer) wouldn't need to dig up the mac address and add it to the
appended dtb.

So, I'm happy with it the way it is.  If we want to dot our i's and
cross our t's, we could also set local-mac-address from the atag,
however, this isn't necessary because of the precedence in
of_get_mac_address().

thx,

Jason.
