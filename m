From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 31 Mar 2016 12:15:35 +0200
Subject: [PATCH v14 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20160331101535.GZ2510@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 07:08:05PM +0800, Yakir Yang wrote:
> 
> Hi all,
> 
>   The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
> share the same IP, so a lot of parts can be re-used. I split the common
> code into bridge directory, then rk3288 and exynos only need to keep
> some platform code. Cause I can't find the exact IP name of exynos dp
> controller, so I decide to name dp core driver with "analogix" which I
> find in rk3288 eDP TRM
> 
> But there are still three light registers setting different between
> exynos and rk3288.
> 1. RK3288 have five special pll registers which not indicate in exynos
>    dp controller.
> 2. The address of DP_PHY_PD(dp phy power manager register) are different
>    between rk3288 and exynos.
> 3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
>    register).
> 
> Due to Mark Yao have introduced the ATOMIC support to Rockchip drm, so it's
> okay to use the ATOMIC helpers functions in connector_funcs. No need to splict
> the connector init to platform driver anymore, and this is the biggest change
> since version 11.
> 
> This v14 didn't have lots of new changes which seems not the correct time to
> upgrade the version number, but I have changed ordering of patches (adding 2
> more, and removing 2 out). Especially to prevent confusing people, so I updated
> the whole series.

So I'm jumping into this part way late, but just noticed (well Thierry
pointed this out to me) that the exynos dp driver reinvents all the dp and
dp-aux helpers we already. That's somewhat okish for a private driver (and
exynos has a reputation for that kind of stuff), but imo not ok for a
shared driver.

Not saying this should block merging this patch, but it really needs to be
addressed. All the dp aux and edid read code in the current
exynos_dp_core/reg.c files needs to be replaced with dp helpers and the
core i2c edid reading code.

Who's going to sign up to do this?
-Daniel

> 
> Thanks,
> - Yakir
> 
> 
> Changes in v14:
> - Rebase the new changes in imx-dp driver
> - Split up this patch into 3 parts, make this easy to review (Heiko)
> - Remove the Rockchip DP PHY to an separate thread (Heiko)
>     https://patchwork.kernel.org/patch/8312701/
> 
> Changes in v13:
> - Use .enable instead of preprare/commit in encoder_helper_funcs (Heiko)
> - Fix the missing parameters with drm_encoder_init() helper function. (Heiko)
> 
> Changes in v12:
> - Move the connector init to analogix_dp driver, and using ATOMIC helper (Heiko)
> - Add the ack from Jingoo
> - Remove the enum link_rate_type struct, using the marcos in drm_dp_helper.h (Jingoo)
> 
> Changes in v11:
> - Uses tabs to fix the indentation issues in analogix_dp_core.h (Heiko)
> - Rename the "analogix,need-force-hpd" to common 'force-hpd' (Rob)
> - Add the ack from Rob Herring
> - Revert parts of Gustavo Padovan's changes in commit:
> 	drm/exynos: do not start enabling DP at bind() phase
>   Add dp phy poweron function in bind time.
> - Move the panel prepare from get_modes time to bind time, and move
>   the panel unprepare from bridge->disable to unbind time. (Heiko)
> 
> Changes in v10:
> - Add the ack from Rob Herring
> - Correct the ROCKCHIP_ANALOGIX_DP indentation in Kconfig to tabs here (Heiko)
> - Add the ack from Rob Herring
> - Remove the surplus "plat_data" check. (Heiko)
> -       switch (dp->plat_data && dp->plat_data->dev_type) {
> +       switch (dp->plat_data->dev_type) {
> 
> Changes in v9:
> - Document more details for 'ports' property.
> 
> Changes in v8:
> - Correct the right document path of display-timing.txt (Heiko)
> - Correct the misspell of 'from' to 'frm'. (Heiko)
> - Modify the commit subject name. (Heiko)
> 
> Changes in v7:
> - Back to use the of_property_read_bool() interfacs to provoid backward
>   compatibility of "hsync-active-high" "vsync-active-high" "interlaced"
>   to avoid -EOVERFLOW error (Krzysztof)
> 
> Changes in v6:
> - Fix the Kconfig recursive dependency (Javier)
> - Fix Peach Pit hpd property name error:
> -       hpd-gpio = <&gpx2 6 0>;
> +       hpd-gpios = <&gpx2 6 0>;
> 
> Changes in v5:
> - Correct the check condition of gpio_is_valid when driver try to get
>   the "hpd-gpios" DT propery. (Heiko)
> - Move the platform attach callback in the front of core driver bridge
>   attch function. Cause once platform failed at attach, core driver should
>   still failed, so no need to init connector before platform attached (Krzysztof)
> - Keep code style no changes with the previous exynos_dp_code.c in this
>   patch, and update commit message about the new export symbol (Krzysztof)
> - Gather the device type patch (v4 11/16) into this one. (Krzysztof)
> - leave out the connector registration to analogix platform driver. (Thierry)
> - Resequence this patch after analogix_dp driver have been split
>   from exynos_dp code, and rephrase reasonable commit message, and
>   remove some controversial style (Krzysztof)
>     -		analogix_dp_write_byte_to_dpcd(
>     - 				dp, DP_TEST_RESPONSE,
>     +		analogix_dp_write_byte_to_dpcd(dp,
>     +				DP_TEST_RESPONSE,
> 				DP_TEST_EDID_CHECKSUM_WRITE);
> - Switch video timing type to "u32", so driver could use "of_property_read_u32"
>   to get the backword timing values. Krzysztof suggest me that driver could use
>   the "of_property_read_bool" to get backword timing values, but that interfacs
>   would modify the original drm_display_mode timing directly (whether those
>   properties exists or not).
> - Correct the misspell in commit message. (Krzysztof)
> - Remove the empty line at the end of document, and correct the endpoint
>   numbers in the example DT node, and remove the regulator iomux setting
>   in driver code while using the pinctl in devicetree instead. (Heiko)
> - Add device type declared, cause the previous "platform device type
>   support (v4 11/16)" already merge into (v5 02/14).
> - Implement connector registration code. (Thierry)
> - Split binding doc's from driver changes. (Rob)
> - Add eDP hotplug pinctrl property. (Heiko)
> 
> Changes in v4:
> - Update "analogix,hpd-gpios" to "hpd-gpios" DT propery. (Rob)
> - Rename "analogix_dp-exynos.c" file name to "exynos_dp.c" (Jingoo)
> - Create a separate folder for analogix code in bridge/ (Archit)
> - Update commit message more readable. (Jingoo)
> - Adjust the order from 05 to 04
> - Provide backword compatibility with samsung. (Krzysztof)
> - Split all DTS changes, and provide backward compatibility. Mark old
>   properties as deprecated but still support them. (Krzysztof)
> - Update "analogix,hpd-gpio" to "hpd-gpios" prop name. (Rob)
> - Deprecated some properties which could parsed from Edid/Mode/DPCD. (Thierry)
>     "analogix,color-space" & "analogix,color-depth"   &
>     "analogix,link-rate"   & "analogix,lane-count"    &
>     "analogix,ycbcr-coeff" & "analogix,dynamic-range" &
>     "vsync-active-high"    & "hsync-active-high"      & "interlaces"
> - Separate all DTS changes to a separate patch. (Krzysztof)
> - Remove some deprecated DT properties in rockchip dp document.
> - Seprate the link-rate and lane-count limit out with the device_type
>   flag. (Thierry)
> - Take Jingoo suggest, add commit messages.
> - Call drm_panel_prepare() in .get_modes function, ensure panel should
>   power on before driver try to read edid message.
> 
> Changes in v3:
> - Move exynos's video_timing code to analogix_dp-exynos platform driver,
>   add get_modes method to struct analogix_dp_plat_data. (Thierry)
> - Rename some "samsung*" dts propery to "analogix*". (Heiko)
> - The link_rate and lane_count shouldn't config to the DT property value
>   directly, but we can take those as hardware limite. For example, RK3288
>   only support 4 physical lanes of 2.7/1.62 Gbps/lane, so DT property would
>   like "link-rate = 0x0a" "lane-count = 4". (Thierry)
> - Dynamic parse video timing info from struct drm_display_mode and
>   struct drm_display_info. (Thierry)
> - Add devicetree binding documents. (Heiko)
> - Remove sync pol & colorimetry properies from the new analogix dp driver
>   devicetree binding. (Thierry)
> - Update the exist exynos dtsi file with the latest DP DT properies.
> - Leave "sclk_edp_24m" to rockchip dp phy driver which name to "24m",
>   and leave "sclk_edp" to analogix dp core driver which name to "dp",
>   and leave "pclk_edp" to rockchip dp platform driver which name to
>   "pclk". (Thierry & Heiko)
> - Add devicetree binding document. (Heiko)
> - Remove "rockchip,panel" DT property, take use of remote point to get panel
>   node. (Heiko)
> - Add the new function point dp_platdata->get_modes() init.
> - Add "analogix,need-force-hpd" to indicate whether driver need foce
>   hpd when hpd detect failed.
> - move dp hpd detect to connector detect function.
> - Add edid modes parse support
> 
> Changes in v2:
> - Remove new copyright (Jingoo)
> - Fix compiled failed due to analogix_dp_device misspell
> - Improved commit message more readable, and avoid using some
>   uncommon style like bellow: (Joe Preches)
>     -  retval = exynos_dp_read_bytes_from_i2c(...
>   				  ...);
>     +  retval =
>     +  exynos_dp_read_bytes_from_i2c(......);
> - Get panel node with remote-endpoint method, and create devicetree binding
>   for driver. (Heiko)
> - Remove the clock enable/disbale with "sclk_edp" & "sclk_edp_24m",
>   leave those clock to rockchip dp phy driver.
> - Fix compile failed dut to phy_pd_addr variable misspell error
> 
> Heiko Stuebner (2):
>   drm/exynos: dp: rename implementation specific driver part
>   drm: bridge: analogix/dp: rename register constants
> 
> Yakir Yang (15):
>   drm: bridge: analogix/dp: split exynos dp driver to bridge directory
>   drm: bridge: analogix/dp: fix some obvious code style
>   drm: bridge: analogix/dp: remove duplicate configuration of link rate
>     and link count
>   drm: bridge: analogix/dp: dynamic parse sync_pol & interlace &
>     dynamic_range
>   dt-bindings: add document for analogix display port driver
>   ARM: dts: exynos/dp: remove some properties that deprecated by
>     analogix_dp driver
>   drm: rockchip: dp: add rockchip platform dp driver
>   dt-bindings: add document for rockchip variant of analogix_dp
>   drm: bridge: analogix/dp: add some rk3288 special registers setting
>   drm: bridge: analogix/dp: add max link rate and lane count limit for
>     RK3288
>   drm: bridge: analogix/dp: try force hpd after plug in lookup failed
>   drm: bridge: analogix/dp: move hpd detect to connector detect function
>   drm: bridge: analogix/dp: add edid modes parse in get_modes method
>   drm: bridge: analogix/dp: add panel prepare/unprepare in
>     suspend/resume time
>   drm: bridge: analogix/dp: Fix the possible dead lock in bridge disable
>     time
> 
>  .../bindings/display/bridge/analogix_dp.txt        |   52 +
>  .../bindings/display/exynos/exynos_dp.txt          |   93 +-
>  .../display/rockchip/analogix_dp-rockchip.txt      |   92 ++
>  arch/arm/boot/dts/exynos5250-arndale.dts           |    2 -
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    2 -
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi      |    4 +-
>  arch/arm/boot/dts/exynos5250-spring.dts            |    4 +-
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |    4 +-
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |    2 -
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |    2 -
>  drivers/gpu/drm/bridge/Kconfig                     |    2 +
>  drivers/gpu/drm/bridge/Makefile                    |    1 +
>  drivers/gpu/drm/bridge/analogix/Kconfig            |    3 +
>  drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1430 ++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  281 ++++
>  drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 1320 +++++++++++++++++
>  .../analogix/analogix_dp_reg.h}                    |  270 ++--
>  drivers/gpu/drm/exynos/Kconfig                     |    3 +-
>  drivers/gpu/drm/exynos/Makefile                    |    2 +-
>  drivers/gpu/drm/exynos/exynos_dp.c                 |  324 +++++
>  drivers/gpu/drm/exynos/exynos_dp_core.c            | 1510 --------------------
>  drivers/gpu/drm/exynos/exynos_dp_core.h            |  282 ----
>  drivers/gpu/drm/exynos/exynos_dp_reg.c             | 1263 ----------------
>  drivers/gpu/drm/rockchip/Kconfig                   |    9 +
>  drivers/gpu/drm/rockchip/Makefile                  |    1 +
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  384 +++++
>  include/drm/bridge/analogix_dp.h                   |   41 +
>  28 files changed, 4115 insertions(+), 3269 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
>  create mode 100644 drivers/gpu/drm/bridge/analogix/Kconfig
>  create mode 100644 drivers/gpu/drm/bridge/analogix/Makefile
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>  rename drivers/gpu/drm/{exynos/exynos_dp_reg.h => bridge/analogix/analogix_dp_reg.h} (62%)
>  create mode 100644 drivers/gpu/drm/exynos/exynos_dp.c
>  delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.c
>  delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.h
>  delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_reg.c
>  create mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>  create mode 100644 include/drm/bridge/analogix_dp.h
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
