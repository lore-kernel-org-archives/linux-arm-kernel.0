From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Fri, 5 Oct 2018 17:34:08 +0900
Subject: [PATCH v2] arm64: dts: rockchip: add spdif sound node for rock64
In-Reply-To: <CAGb2v64gTj7766o+6-BZkqKy=cDv9bqLcKHOzj-BiJOtjQMSyQ@mail.gmail.com>
References: <20180917122633.31401-1-katsuhiro@katsuster.net>
 <CAGb2v64gTj7766o+6-BZkqKy=cDv9bqLcKHOzj-BiJOtjQMSyQ@mail.gmail.com>
Message-ID: <9b54c5e6-f705-c792-1f41-c33c3403baa9@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Sorry for late, thank you for your comments.

On 2018?10?03? 18:53, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Sep 17, 2018 at 8:28 PM Katsuhiro Suzuki
> <katsuhiro@katsuster.net> wrote:
>>
>> This patch adds sound card node for rock64. Currently we can support
>> S/PDIF only. It seems the lack of codec driver of rk3328 to enable
>> analog audio out.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 29 +++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> index 5852061e497b..9ee4f57557f3 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> @@ -62,6 +62,23 @@
>>                  regulator-min-microvolt = <5000000>;
>>                  regulator-max-microvolt = <5000000>;
>>          };
>> +
>> +       sound {
>> +               compatible = "audio-graph-card";
>> +               label = "rockchip,rk3328";
> 
> I understand that this patch has been merged. However, seeing this label
> I wonder how this works when the analog codec and HDMI audio out are added,
> and how userspace is supposed to select an output.
> 

I don't know detail of HDMI audio of RK3328, but maybe it has cpu or 
codec DAIs. The audio-graph-card is supporting to use multiple DAIs on
a card. This is same as simple-audio-card.

For example, add I2S0 device as hw:X,0
(and move SPDIF to hw:X,0 -> hw:X,1)

sound {
	compatible = "audio-graph-card";
	label = "rockchip,rk3328";
	dais = <&i2s0_p0
		&spdif_p0>;
};

&i2s0 {
	status = "okay";
	#sound-dai-cells = <0>;

	i2s0_p0: port {
		i2s0_p0_0: endpoint {
			dai-format = "i2s";
			remote-endpoint = <&some_codec_abcd>;
		};
	};
};

We should write special card driver for RK3328 sound if audio-graph-card
is not enough to deal with HDMI audio.


> On the side, it seems that extra codecs, such as the rock64 add-on board,
> are easier dealt with by adding a separate simple-audio-card node to couple
> the codec and i2s nodes.

I think multiple DAIs on single card and single DAI on multiple cards
are both OK to work. But I cannot decide the way for this issue.


> 
> ChenYu
> 

Regards,
--
Katsuhiro Suzuki
