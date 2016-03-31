From: treding@nvidia.com (Thierry Reding)
Date: Thu, 31 Mar 2016 11:56:02 +0200
Subject: [v14, 01/17] drm: bridge: analogix/dp: split exynos dp driver to
 bridge directory
In-Reply-To: <20160330203204.GA24156@roeck-us.net>
References: <1455534576-1486-1-git-send-email-ykk@rock-chips.com>
 <20160330203204.GA24156@roeck-us.net>
Message-ID: <20160331095600.GD26032@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 01:32:04PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Feb 15, 2016 at 07:09:36PM +0800, Yakir Yang wrote:
> > Split the dp core driver from exynos directory to bridge directory,
> > and rename the core driver to analogix_dp_*, rename the platform
> > code to exynos_dp.
> > 
> > Beside the new analogix_dp driver would export six hooks.
> > "analogix_dp_bind()" and "analogix_dp_unbind()"
> > "analogix_dp_suspned()" and "analogix_dp_resume()"
> > "analogix_dp_detect()" and "analogix_dp_get_modes()"
> > 
> > The bind/unbind symbols is used for analogix platform driver to connect
> > with analogix_dp core driver. And the detect/get_modes is used for analogix
> > platform driver to init the connector.
> > 
> > They reason why connector need register in helper driver is rockchip drm
> > haven't implement the atomic API, but Exynos drm have implement it, so
> > there would need two different connector helper functions, that's why we
> > leave the connector register in helper driver.
> > 
> > Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > 
> [ ... ]
> 
> > diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
> > new file mode 100644
> > index 0000000..9107b86
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp_core.o analogix_dp_reg.o
> 
> This results in the following build errors if DRM_ANALOGIX_DP
> is configured as module.
> 
> ERROR: "analogix_dp_start_video" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane0_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane1_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane2_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane3_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane_count" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_link_bandwidth" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> 
> [ and so on ]

Ugh... most of these functions shouldn't be there in the first place. We
have helpers in the core that already do this. Most of the functionality
is duplicated in this driver.

I realize that this is a problem that existed in the Exynos DP driver,
but somebody really ought to rewrite those parts to make use of the DRM
DP helpers.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160331/5f26b101/attachment.sig>
