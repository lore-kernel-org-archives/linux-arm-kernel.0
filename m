From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 07 Oct 2015 14:25:33 +0800
Subject: [PATCH v5 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
Message-ID: <5614BADD.1070307@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Friendly ping.....   :)


Best regards,
- Yakir


On 09/22/2015 03:20 PM, Yakir Yang wrote:
> Hi all,
>
>     The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
> share the same IP, so a lot of parts can be re-used. I split the common
> code into bridge directory, then rk3288 and exynos only need to keep
> some platform code. Cause I can't find the exact IP name of exynos dp
> controller, so I decide to name dp core driver with "analogix" which I
> find in rk3288 eDP TRM :)
>
> This time I create this version on linux-next branch (tag is next-20150918),
> and also applied this version to Heiko github eDP branch to verify the function.
> (https://github.com/mmind/linux-rockchip/tree/tmp/edp-with-veyron)
> Glad to say my chromebook "cnm,n116bgeea2" eDP panel just lighted rightly on
> Heiko branch. And after back port this series to chromeos-3.14 tree, my rk3288
> SDK board still can light my 2K DisplayPort monitor. So this time would be okay
> on mainline kernel and chromeos-3.14 tree. ;)
>
> Due to no Exynos board in my side, so I haven't verified the eDP function on
> samsung platform, I only ensure that there are no obvious compiled error. Any
> help would be greatly appreciated. :)
>
> Thanks,
> - Yakir
>
> Changes in v5:
> - Correct the check condition of gpio_is_valid when driver try to get
>    the "hpd-gpios" DT propery. (Heiko)
> - Move the platform attach callback in the front of core driver bridge
>    attch function. Cause once platform failed at attach, core driver should
>    still failed, so no need to init connector before platform attached (Krzysztof)
> - Keep code style no changes with the previous exynos_dp_code.c in this
>    patch, and update commit message about the new export symbol (Krzysztof)
> - Gather the device type patch (v4 11/16) into this one. (Krzysztof)
> - leave out the connector registration to analogix platform driver. (Thierry)
> - Resequence this patch after analogix_dp driver have been split
>    from exynos_dp code, and rephrase reasonable commit message, and
>    remove some controversial style (Krzysztof)
>      -		analogix_dp_write_byte_to_dpcd(
>      - 				dp, DP_TEST_RESPONSE,
>      +		analogix_dp_write_byte_to_dpcd(dp,
>      +				DP_TEST_RESPONSE,
> 				DP_TEST_EDID_CHECKSUM_WRITE);
> - Switch video timing type to "u32", so driver could use "of_property_read_u32"
>    to get the backword timing values. Krzysztof suggest me that driver could use
>    the "of_property_read_bool" to get backword timing values, but that interfacs
>    would modify the original drm_display_mode timing directly (whether those
>    properties exists or not).
> - Correct the misspell in commit message. (Krzysztof)
> - Remove the empty line at the end of document, and correct the endpoint
>    numbers in the example DT node, and remove the regulator iomux setting
>    in driver code while using the pinctl in devicetree instead. (Heiko)
> - Add device type declared, cause the previous "platform device type
>    support (v4 11/16)" already merge into (v5 02/14).
> - Implement connector registration code. (Thierry)
> - Split binding doc's from driver changes. (Rob)
> - Add eDP hotplug pinctrl property. (Heiko)
> - Remove "reg" DT property, cause driver could poweron/poweroff phy via
>    the exist "grf" syscon already. And rename the example DT node from
>    "edp_phy: phy at ff770274" to "edp_phy: edp-phy" directly. (Heiko)
> - Add deivce_node at the front of driver, update phy_ops type from "static
>    struct" to "static const struct". And correct the input paramters of
>    devm_phy_create() interfaces. (Heiko)
> - Split binding doc's from driver changes. (Rob)
> - Update the rockchip,grf explain in document, and correct the clock required
>    elemets in document. (Rob & Heiko)
> - Fix compiled error (Heiko)
> - Using the connector display info message to configure eDP driver input
>    video mode, but hard code CRTC video output mode to RGBaaa.
>
> Changes in v4:
> - Update "analogix,hpd-gpios" to "hpd-gpios" DT propery. (Rob)
> - Rename "analogix_dp-exynos.c" file name to "exynos_dp.c" (Jingoo)
> - Create a separate folder for analogix code in bridge/ (Archit)
> - Update commit message more readable. (Jingoo)
> - Adjust the order from 05 to 04
> - Provide backword compatibility with samsung. (Krzysztof)
> - Split all DTS changes, and provide backward compatibility. Mark old
>    properties as deprecated but still support them. (Krzysztof)
> - Update "analogix,hpd-gpio" to "hpd-gpios" prop name. (Rob)
> - Deprecated some properties which could parsed from Edid/Mode/DPCD. (Thierry)
>      "analogix,color-space" & "analogix,color-depth"   &
>      "analogix,link-rate"   & "analogix,lane-count"    &
>      "analogix,ycbcr-coeff" & "analogix,dynamic-range" &
>      "vsync-active-high"    & "hsync-active-high"      & "interlaces"
> - Separate all DTS changes to a separate patch. (Krzysztof)
> - Remove some deprecated DT properties in rockchip dp document.
> - Add commit message, and remove the redundant rockchip_dp_phy_init()
>    function, move those code to probe() method. And remove driver .owner
>    number. (Kishon)
> - Seprate the link-rate and lane-count limit out with the device_type
>    flag. (Thierry)
> - Take Jingoo suggest, add commit messages.
> - Call drm_panel_prepare() in .get_modes function, ensure panel should
>    power on before driver try to read edid message.
>
> Changes in v3:
> - Move exynos's video_timing code to analogix_dp-exynos platform driver,
>    add get_modes method to struct analogix_dp_plat_data. (Thierry)
> - Rename some "samsung*" dts propery to "analogix*". (Heiko)
> - The link_rate and lane_count shouldn't config to the DT property value
>    directly, but we can take those as hardware limite. For example, RK3288
>    only support 4 physical lanes of 2.7/1.62 Gbps/lane, so DT property would
>    like "link-rate = 0x0a" "lane-count = 4". (Thierry)
> - Dynamic parse video timing info from struct drm_display_mode and
>    struct drm_display_info. (Thierry)
> - Add devicetree binding documents. (Heiko)
> - Remove sync pol & colorimetry properies from the new analogix dp driver
>    devicetree binding. (Thierry)
> - Update the exist exynos dtsi file with the latest DP DT properies.
> - Leave "sclk_edp_24m" to rockchip dp phy driver which name to "24m",
>    and leave "sclk_edp" to analogix dp core driver which name to "dp",
>    and leave "pclk_edp" to rockchip dp platform driver which name to
>    "pclk". (Thierry & Heiko)
> - Add devicetree binding document. (Heiko)
> - Remove "rockchip,panel" DT property, take use of remote point to get panel
>    node. (Heiko)
> - Add the new function point dp_platdata->get_modes() init.
> - Suggest, add rockchip dp phy driver, collect the phy clocks and
>    power control. (Heiko)
> - Add "analogix,need-force-hpd" to indicate whether driver need foce
>    hpd when hpd detect failed.
> - move dp hpd detect to connector detect function.
> - Add edid modes parse support
>
> Changes in v2:
> - Keep author name list no changed (Jingoo)
> - Remove new copyright (Jingoo)
> - Fix compiled failed due to analogix_dp_device misspell
> - Improved commit message more readable, and avoid using some
>    uncommon style like bellow: (Joe Preches)
>      -  retval = exynos_dp_read_bytes_from_i2c(...
>    				  ...);
>      +  retval =
>      +  exynos_dp_read_bytes_from_i2c(......);
> - Get panel node with remote-endpoint method, and create devicetree binding
>    for driver. (Heiko)
> - Remove the clock enable/disbale with "sclk_edp" & "sclk_edp_24m",
>    leave those clock to rockchip dp phy driver.
> - Fix compile failed dut to phy_pd_addr variable misspell error
>
> Mark Yao (1):
>    drm: rockchip: vop: add bpc and color mode setting
>
> Yakir Yang (16):
>    drm: exynos: dp: convert to drm bridge mode
>    drm: bridge: analogix/dp: split exynos dp driver to bridge directory
>    drm: bridge: analogix/dp: fix some obvious code style
>    drm: bridge: analogix/dp: remove duplicate configuration of link rate
>      and link count
>    drm: bridge: analogix/dp: dynamic parse sync_pol & interlace &
>      dynamic_range
>    Documentation: drm/bridge: add document for analogix_dp
>    ARM: dts: exynos/dp: remove some properties that deprecated by
>      analogix_dp driver
>    drm: rockchip: dp: add rockchip platform dp driver
>    Documentation: drm/bridge: add document for analogix_dp
>    phy: Add driver for rockchip Display Port PHY
>    Documentation: phy: add document for rockchip dp phy
>    drm: bridge: analogix/dp: add some rk3288 special registers setting
>    drm: bridge: analogix/dp: add max link rate and lane count limit for
>      RK3288
>    drm: bridge: analogix/dp: try force hpd after plug in lookup failed
>    drm: bridge: analogix/dp: move hpd detect to connector detect function
>    drm: bridge: analogix/dp: add edid modes parse in get_modes method
>
>   .../devicetree/bindings/drm/bridge/analogix_dp.txt |   52 +
>   .../devicetree/bindings/phy/rockchip-dp-phy.txt    |   22 +
>   .../bindings/video/analogix_dp-rockchip.txt        |   91 ++
>   .../devicetree/bindings/video/exynos_dp.txt        |   64 +-
>   arch/arm/boot/dts/exynos5250-arndale.dts           |    2 -
>   arch/arm/boot/dts/exynos5250-smdk5250.dts          |    2 -
>   arch/arm/boot/dts/exynos5250-snow.dts              |    4 +-
>   arch/arm/boot/dts/exynos5250-spring.dts            |    4 +-
>   arch/arm/boot/dts/exynos5420-peach-pit.dts         |    4 +-
>   arch/arm/boot/dts/exynos5420-smdk5420.dts          |    2 -
>   arch/arm/boot/dts/exynos5800-peach-pi.dts          |    4 +-
>   drivers/gpu/drm/bridge/Kconfig                     |    2 +
>   drivers/gpu/drm/bridge/Makefile                    |    1 +
>   drivers/gpu/drm/bridge/analogix/Kconfig            |    4 +
>   drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1372 +++++++++++++++++++
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  286 ++++
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 1294 ++++++++++++++++++
>   .../analogix/analogix_dp_reg.h}                    |  270 ++--
>   drivers/gpu/drm/exynos/Kconfig                     |    3 +-
>   drivers/gpu/drm/exynos/Makefile                    |    2 +-
>   drivers/gpu/drm/exynos/exynos_dp.c                 |  366 +++++
>   drivers/gpu/drm/exynos/exynos_dp_core.c            | 1427 --------------------
>   drivers/gpu/drm/exynos/exynos_dp_core.h            |  281 ----
>   drivers/gpu/drm/exynos/exynos_dp_reg.c             | 1263 -----------------
>   drivers/gpu/drm/rockchip/Kconfig                   |    9 +
>   drivers/gpu/drm/rockchip/Makefile                  |    1 +
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  457 +++++++
>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |    2 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |    2 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   32 +-
>   drivers/phy/Kconfig                                |    7 +
>   drivers/phy/Makefile                               |    1 +
>   drivers/phy/phy-rockchip-dp.c                      |  151 +++
>   include/drm/bridge/analogix_dp.h                   |   42 +
>   35 files changed, 4360 insertions(+), 3167 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
>   create mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>   create mode 100644 Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
>   create mode 100644 drivers/gpu/drm/bridge/analogix/Kconfig
>   create mode 100644 drivers/gpu/drm/bridge/analogix/Makefile
>   create mode 100644 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>   create mode 100644 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>   create mode 100644 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>   rename drivers/gpu/drm/{exynos/exynos_dp_reg.h => bridge/analogix/analogix_dp_reg.h} (62%)
>   create mode 100644 drivers/gpu/drm/exynos/exynos_dp.c
>   delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.c
>   delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.h
>   delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_reg.c
>   create mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>   create mode 100644 drivers/phy/phy-rockchip-dp.c
>   create mode 100644 include/drm/bridge/analogix_dp.h
>
