From: treding@nvidia.com (Thierry Reding)
Date: Thu, 31 Mar 2016 12:22:48 +0200
Subject: [PATCH v14 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <20160331101535.GZ2510@phenom.ffwll.local>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <20160331101535.GZ2510@phenom.ffwll.local>
Message-ID: <20160331102247.GE26032@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 12:15:35PM +0200, Daniel Vetter wrote:
> On Mon, Feb 15, 2016 at 07:08:05PM +0800, Yakir Yang wrote:
> > 
> > Hi all,
> > 
> >   The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
> > share the same IP, so a lot of parts can be re-used. I split the common
> > code into bridge directory, then rk3288 and exynos only need to keep
> > some platform code. Cause I can't find the exact IP name of exynos dp
> > controller, so I decide to name dp core driver with "analogix" which I
> > find in rk3288 eDP TRM
> > 
> > But there are still three light registers setting different between
> > exynos and rk3288.
> > 1. RK3288 have five special pll registers which not indicate in exynos
> >    dp controller.
> > 2. The address of DP_PHY_PD(dp phy power manager register) are different
> >    between rk3288 and exynos.
> > 3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
> >    register).
> > 
> > Due to Mark Yao have introduced the ATOMIC support to Rockchip drm, so it's
> > okay to use the ATOMIC helpers functions in connector_funcs. No need to splict
> > the connector init to platform driver anymore, and this is the biggest change
> > since version 11.
> > 
> > This v14 didn't have lots of new changes which seems not the correct time to
> > upgrade the version number, but I have changed ordering of patches (adding 2
> > more, and removing 2 out). Especially to prevent confusing people, so I updated
> > the whole series.
> 
> So I'm jumping into this part way late, but just noticed (well Thierry
> pointed this out to me) that the exynos dp driver reinvents all the dp and
> dp-aux helpers we already. That's somewhat okish for a private driver (and
> exynos has a reputation for that kind of stuff), but imo not ok for a
> shared driver.
> 
> Not saying this should block merging this patch, but it really needs to be
> addressed. All the dp aux and edid read code in the current
> exynos_dp_core/reg.c files needs to be replaced with dp helpers and the
> core i2c edid reading code.

Agreed. I think a first step would be to implement and register a
drm_dp_aux object for Analogix DP hardware. That will give you access to
a slew of helpers that allow to read DPCD, parse link status and use the
standard EDID reading routines that the DRM core already has. This
should remove a lot of duplication from this driver.

For extra incentive, doing this might even fix a bug or two.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160331/6a5cf18a/attachment.sig>
