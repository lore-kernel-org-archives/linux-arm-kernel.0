From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Wed, 24 Feb 2016 17:38:27 +0800
Subject: [PATCH v7 0/5] Add mipi dsi support for rk3288
In-Reply-To: <56B869F4.6090507@codeaurora.org>
References: <1452053038-32098-1-git-send-email-zyw@rock-chips.com>
 <56B869F4.6090507@codeaurora.org>
Message-ID: <CAGd==049mj+K5u28SQQR+7Fh5aj-fGfOZtuPFHodmCZyKQhmqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 February 2016 at 18:12, Archit Taneja <architt@codeaurora.org> wrote:
> Hi,
>
> On 01/06/2016 09:33 AM, Chris Zhong wrote:
>>
>>
>> The rk3288 MIPI DSI is a Synopsys DesignWare MIPI DSI host controller
>> IP. This series adds support for a Synopsys DesignWare MIPI DSI host
>> controller DRM driver.
>>
>> The MIPI DSI feature is tested on rk3288 evb board, backport them to
>> chrome os kernel chrome_v3.14, and it can display normally.
>>
>> This patchset is base on the patchset from Ying.liu at freescale.com.
>> <http://www.spinics.net/lists/dri-devel/msg77181.html>
>>
>> According to the suggestion from Thierry, I have get rid of the bridge,
>> and register the encoder & connecter in drm/rockchip/dw-mipi-dsi.c.
>
>
> I've raised this question too late, but what was the reason to not
> implement the DSI block as a bridge driver?
>
> The drm/hisilicon IP seems to use a very similar DSI Designware IP (the
> register offsets seems to be the same). There is a good potential of
> re-use here by different kms drivers here the way it's already done for
> DW HDMI and the analogix DP driver that's in review process.

yes, Hisilicon's hi6220 SoC use a Designware DSI Controller IP similar
to rockchip.
Maybe the version number is different.
I notice this recently when I am doing the upstream of hi6220's DRM driver.

And I have a look at Ying liu's original patches. It seems that it is
implemented in bridge.
His patches were sent in the early of last year, I can't get all the
background easily.
I wonder why his patches was not accecpted? What's the problem? And
why Thierry suggested get rid of bridge?

Thanks,
-xinliang

>
> Archit
>
>
>> After backport below patches from linux-next, I can merge this serial into
>> Dave's drm-next branch.
>>
>> 94d5d6a0fbf3 clk: rockchip: add an id for rk3288 crypto clk
>> c6d49fbcfcc4 clk: rockchip: add id for mipidsi sclk on rk3288
>> a2f4c560f18e clk: rockchip: add mipidsi clock on rk3288
>> 69c923743640 ARM: dts: rockchip: correct the name of REG8 for
>> rk3288-evb-act8846
>> 662513a14c9d ARM: dts: rockchip: add 2 regulators for rk3288-evb-act8846
>> b04061e6599b ARM: dts: rockchip: move the public part to rk3288-evb common
>>
>>
>> Changes in v7:
>> - modify the config to tristate for modules build (Mark Yao)
>> - Pass NULL 'name' to drm_encoder_init() to fix compile err (Mark Yao)
>> - Move the lcd_en control to act8846 dts
>>
>> Changes in v6:
>> - update the document, since the bridge device has been deleted.
>> - move the mipi_en gate to ockchip_drm_crtc_mode_config
>> - Remove the atomic feature check (Mark Yao)
>> - Add atomic API support (Heiko St?bne)
>> - Do not use bridge driver (Thierry Reding)
>> - Optimization the phy init sequence
>>
>> Changes in v5:
>> - modify the clk name to SCLK_MIPIDSI_24M
>> - add a blank line befor lcd_en
>>
>> Changes in v4:
>> - use clk_round_rate to check the clock rate in vop_crtc_mode_fixup
>>
>> Changes in v3:
>> - move dw_mipi_dsi_rockchip.txt to bindings/display/rockchip/
>>
>> Chris Zhong (5):
>>    drm/rockchip: return a true clock rate to adjusted_mode
>>    Documentation: dt-bindings: Add bindings for rk3288 DW MIPI DSI driver
>>    drm: rockchip: Support Synopsys DW MIPI DSI
>>    ARM: dts: rockchip: add rk3288 mipi_dsi nodes
>>    ARM: dts: rockchip: add support mipi panel tv080wum-nl0
>>
>>   .../display/rockchip/dw_mipi_dsi_rockchip.txt      |   60 +
>>   arch/arm/boot/dts/rk3288-evb-act8846.dts           |    2 +
>>   arch/arm/boot/dts/rk3288-evb.dtsi                  |   12 +-
>>   arch/arm/boot/dts/rk3288.dtsi                      |   39 +
>>   drivers/gpu/drm/rockchip/Kconfig                   |   10 +
>>   drivers/gpu/drm/rockchip/Makefile                  |    1 +
>>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c             | 1196
>> ++++++++++++++++++++
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    8 +
>>   8 files changed, 1327 insertions(+), 1 deletion(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
>>   create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>>
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
