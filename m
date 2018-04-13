From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Fri, 13 Apr 2018 17:30:04 +0530
Subject: [PATCH v4 0/8] drm/sun4i: Allwinner MIPI-DSI support
In-Reply-To: <20180411124325.youvfpws27l2wesf@flea>
References: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
 <20180411124325.youvfpws27l2wesf@flea>
Message-ID: <CAD6G_RRQrj9m=MPdjovEcwJV_fivCMAERSa49Mt0cKGFTicsxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 6:13 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Wed, Apr 04, 2018 at 11:57:08AM +0200, Maxime Ripard wrote:
>> Hi,
>>
>> Here is an preliminary version of the MIPI-DSI support for the Allwinner
>> SoCs.
>>
>> This controller can be found on a number of recent SoCs, such as the
>> A31, A33 or the A64.
>>
>> Given the sparse documentation, there's a number of obscure areas, but
>> the current implementation has been tested with a 4-lanes DSI panel on
>> an A33.
>>
>> The support is a bit rough around the edges at the time, and some artifacts
>> are still shown on the screen for some reasons. Wider testing with
>> different display will hopefully nail those down.
>>
>> This needs the regmap_mmio_attach_clk, on its way to Linus in 4.17.
>>
>> Let me know what you think,
>> Maxime
>>
>> Changes from v3:
>>   - Rebased on top of current drm-misc-next
>>   - Switched to SPDX license header
>>   - Made the ECC array const
>>   - Split the big DSI patch into two, one to add the DSI driver and one to
>>     add the TCON bits.
>>   - Removed the dithering code
>>   - Changed the DT labels to remove the indices
>>   - Used sleeps instead of delays in the panel driver
>>   - Used the backlight_enable / _disable functions
>>   - Added Chen-Yu's Reviewed-by
>>
>> Changes from v2:
>>   - Added a ports node under the DSI node
>>   - Changed the huarui panel driver to an ili9881c driver
>>   - Changed the panel vendor to bananapi
>>   - Made the init table static in the panel driver
>>   - Dropped the huarui vendor patch for the DT doc.
>>
>> Changes from v1:
>>   - Rebased on 4.16-rc1
>>   - Constified a few function arguments and structures
>>   - Reworked the DT binding example a bit
>>   - Reworked the panel driver to check for DSI return codes, and use DCS
>>     helpers when possible
>>
>> Maxime Ripard (8):
>>   drm/sun4i: tcon: Add TRI finish interrupt for vblank
>>   dt-bindings: display: Add Allwinner MIPI-DSI bindings
>>   drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
>>   drm/sun4i: Tie the DSI controller in the TCON
>>   dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
>>   drm/panel: Add Ilitek ILI9881c panel driver
>>   ARM: dts: sun8i: a33: Add the DSI-related nodes
>>   [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display

I have reviewed most of the patches and reused for A64 all look fine
to me (except the panel driver). May be my issue is not relevant to
this thread, but I'm looking for help If I miss anything for A64 [1]
and [2] are changes made for A64, the issue is kernel hang while
loading sun6i_dsi.

Log:

# modprobe -a sun6i_dsi
[   18.798684] sun6i-mipi-dsi 1ca0000.dsi: Attached device ts8550b
[   18.819628] sun4i-drm display-engine: bound 1100000.mixer (ops
sun8i_mixer_ops)
[   18.827336] sun4i-drm display-engine: No panel or bridge found...
RGB output disabled
[   18.835200] sun4i-drm display-engine: bound 1c0c000.lcd-controller
(ops sun4i_tcon_ops)
[   18.843246] sun4i-drm display-engine: bound 1ca0000.dsi (ops
sun6i_dsi_ops [sun6i_dsi])
[   18.851263] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   18.857878] [drm] No driver support for vblank timestamp query.

<< hang here >>

[1] https://github.com/openedev/linux-openedev/commit/9030929673b21971ff77b7593e88c26e84ed3742
[2] https://github.com/openedev/linux-openedev/commit/725afe3ce4507fa975fcb4a04b1bbb90d9d44a91

Jagan.

-- 
Jagan Teki
Free Software Engineer | www.openedev.com
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
