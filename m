From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 9 Nov 2015 17:42:32 +0100
Subject: [PATCH] mvneta: add FIXED_PHY dependency
In-Reply-To: <4225885.EYXTHjRPmX@wuerfel>
References: <4225885.EYXTHjRPmX@wuerfel>
Message-ID: <20151109164232.GB3388@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 03:08:57PM +0100, Arnd Bergmann wrote:
> The fixed_phy infrastructure is done in a way that is optional,
> by providing 'static inline' helper functions doing nothing in
> include/linux/phy_fixed.h for all its APIs. However, three out
> of the four users (DSA, BCMGENET, and SYSTEMPORT) always
> 'select FIXED_PHY', presumably because they need that.

Hi Arnd

Need is probably too strong, it could be considered an optional
feature. If you don't have a fixed_phy property in your DT blob, you
don't need fixed phy support in your image.

> MVNETA is the fourth one, and if that is built-in but FIXED_PHY
> is configured as a loadable module, we get a link error:
> 
> drivers/built-in.o: In function `mvneta_fixed_link_update':
> fpga-mgr.c:(.text+0x33ed80): undefined reference to `fixed_phy_update_state'
> 
> Presumably this driver has the same dependency as the others,
> so this patch also uses 'select' to ensure that the fixed-phy
> support is built-in.

This will work, and is uniform with the other instances. But maybe a
more correct fix is to ensure fixed-phy is never a module when there
is a builtin user.

> Should we perhaps make 'FIXED_PHY' a silent option and remove the
> inline helpers, based on the assumption that a driver that wants these
> will not work without them?

I suppose it comes down to, are we allowed to optionally implement
part of the DT binding?

     Andrew
