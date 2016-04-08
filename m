From: sugar.zhang@rock-chips.com (sugar)
Date: Fri, 8 Apr 2016 17:26:57 +0800
Subject: [PATCH] ASoC: rockchip: i2s: configure the sdio pins' iomux mode
In-Reply-To: <20160407175811.GP32257@rob-hp-laptop>
References: <1459931902-77324-1-git-send-email-sugar.zhang@rock-chips.com>
 <20160407175811.GP32257@rob-hp-laptop>
Message-ID: <57077961.6010200@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 4/8/2016 01:58, Rob Herring Wrote:
> On Wed, Apr 06, 2016 at 04:38:22PM +0800, Sugar Zhang wrote:
>> There are 3 i2s sdio pins, which iomux mode is as follows:
>
> s/i2s sdio/I2S\/SDIO muxed/
>
>>
>>   - sdi3_sdo1
>>   - sdi2_sdo2
>>   - sdi1_sdo3
>>
>> we need to configure these pins' iomux mode via the GRF register
>> when use multi channel playback/capture.
>
> Why not a pinctrl binding here? If you want SDIO mode, then you need
> similar code in the SDIO driver (or just rely on default mode).
>
here, i2s_sdio means i2s_sdi/i2s_sdo, not means SDIO bus interface.
for example:

gpio3d[6] iomux select:
2'b 00: gpio
2'b 01: i2s0_sdi3sdo1
2'b 10: xxx
2'b 11: xxx

we configure the i2s_sdi3sdo1 mode via the pinctrl, and then need another
grf register to configure it is used for i2s0_sdi3 or i2s0_sdo1.

>>
>> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
>> ---
>>
>>   .../devicetree/bindings/sound/rockchip-i2s.txt     |  5 +++
>>   sound/soc/rockchip/rockchip_i2s.c                  | 39 +++++++++++++++++++++-
>>   sound/soc/rockchip/rockchip_i2s.h                  |  8 +++++
>>   3 files changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
>> index 6e86d8a..ad72a7d 100644
>> --- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
>> +++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
>> @@ -23,6 +23,11 @@ Required properties:
>>   - rockchip,playback-channels: max playback channels, if not set, 8 channels default.
>>   - rockchip,capture-channels: max capture channels, if not set, 2 channels default.
>>
>> +Required properties for controller which support multi channels playback/capture:
>> +
>> +- rockchip,grf: Should be phandle/offset pair. the phandle of the syscon node for GRF register,
>
> Wrap your lines at less than 80 chars.

Ok, will fix.
>
>> +  and the offset of the GRF for control register.
>> +
>>   Example for rk3288 I2S controller:
>>
>>   i2s at ff890000 {
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>
>
