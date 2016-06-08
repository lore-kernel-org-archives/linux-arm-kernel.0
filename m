From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 8 Jun 2016 08:44:19 +0100
Subject: [PATCH v14.1 01/17] drm: bridge: analogix/dp: split exynos dp
 driver to bridge directory
In-Reply-To: <575774C0.4000900@rock-chips.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <1455534576-1486-1-git-send-email-ykk@rock-chips.com>
 <1811552.qvsCm7GUs1@diego>
 <417ed48e-74e1-f747-34b9-0d1031a3d862@osg.samsung.com>
 <575774C0.4000900@rock-chips.com>
Message-ID: <20160608084419.602f02d2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Jun 2016 09:28:32 +0800
Yakir Yang <ykk@rock-chips.com> wrote:

> Hi Javier,
> 
> On 06/08/2016 01:06 AM, Javier Martinez Canillas wrote:
> > Hello Yakir,
> >
> > On 03/17/2016 05:47 PM, Heiko St?bner wrote:  
> >> Split the dp core driver from exynos directory to bridge directory,
> >> and rename the core driver to analogix_dp_*, rename the platform
> >> code to exynos_dp.
> >>
> >> Beside the new analogix_dp driver would export six hooks.
> >> "analogix_dp_bind()" and "analogix_dp_unbind()"
> >> "analogix_dp_suspned()" and "analogix_dp_resume()"
> >> "analogix_dp_detect()" and "analogix_dp_get_modes()"
> >>
> >> The bind/unbind symbols is used for analogix platform driver to connect
> >> with analogix_dp core driver. And the detect/get_modes is used for analogix
> >> platform driver to init the connector.
> >>
> >> They reason why connector need register in helper driver is rockchip drm
> >> haven't implement the atomic API, but Exynos drm have implement it, so
> >> there would need two different connector helper functions, that's why we
> >> leave the connector register in helper driver.
> >>
> >> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> >> ---  
> > Marc reported that his Exynos5250 Snow Chromebook fails to boot with v4.7-rc.
> >
> > I've done a git bisect and tracked down to this commit. The problem is a NULL
> > pointer dereference to connector->dev in drm_mode_create(connector->dev) when
> > called from exynos_dp_get_modes(). The error log is at [1].
> >
> > I'm trying to figure out the issue but wanted to mention in case you have any
> > hints about what could be the cause. AFAICT the problem is related to the fact
> > that drm_connector_init() is called in analogix_dp_bridge_attach() and the
> > connector passed as argument is the one in struct analogix_dp_device *dp, but
> > later exynos_dp_get_modes() calls drm_mode_create() passing the connector in
> > struct exynos_dp_device *dp, which has not been previously initialized.  
> 
> Agree, this should be the problem, exynos_dp->connector haven't been
> initialized, driver should make exynos_dp->dp to a connector point, and
> record the passing connector in exynos_dp_bridge_attach(), that should
> fix this problem.
> 
> 
> Thanks,
> - Yakir
> 
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c 
> b/drivers/gpu/drm/exynos/exynos_dp.c
> index 468498e..4c1fb3f 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -34,7 +34,7 @@
> 
>   struct exynos_dp_device {
>          struct drm_encoder         encoder;
> -       struct drm_connector       connector;
> +       struct drm_connector       *connector;
>          struct drm_bridge          *ptn_bridge;
>          struct drm_device          *drm_dev;
>          struct device              *dev;
> @@ -70,7 +70,7 @@ static int exynos_dp_poweroff(struct 
> analogix_dp_plat_data *plat_data)
>   static int exynos_dp_get_modes(struct analogix_dp_plat_data *plat_data)
>   {
>          struct exynos_dp_device *dp = to_dp(plat_data);
> -       struct drm_connector *connector = &dp->connector;
> +       struct drm_connector *connector = dp->connector;
>          struct drm_display_mode *mode;
>          int num_modes = 0;
> 
> @@ -103,6 +103,7 @@ static int exynos_dp_bridge_attach(struct 
> analogix_dp_plat_data *plat_data,
>          int ret;
> 
>          drm_connector_register(connector);
> +       dp->connector = connector;
> 
>          /* Pre-empt DP connector creation if there's a bridge */
>          if (dp->ptn_bridge) {
> 

I've just tested this change, and in combination with Javier's DT patch,
my Snow is back to its useful state (I'm writing this email from that
very Chromebook).

Once you make this a proper patch, please add my:

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

to it.

Thanks a lot to you and Javier for tracking this down!

	M.
-- 
Jazz is not dead. It just smells funny.
