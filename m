From: kieran.bingham+renesas@ideasonboard.com (Kieran Bingham)
Date: Fri, 27 Apr 2018 22:40:33 +0100
Subject: [PATCH v2 11/11] arm64: dts: r8a77965-salvator-xs: Enable DU
 external clocks and HDMI
In-Reply-To: <35470587.gVktJpfmq0@avalon>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
 <20180427165722.19445-12-kieran.bingham+renesas@ideasonboard.com>
 <35470587.gVktJpfmq0@avalon>
Message-ID: <9566c920-daf7-e470-4552-309f6082524b@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 27/04/18 22:32, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Friday, 27 April 2018 19:57:22 EEST Kieran Bingham wrote:
>> The DU1 external dot clock is provided by the fixed frequency clock
>> generator X21, while the DU0 and DU3 clocks are provided by the
>> programmable Versaclock6 clock generator.
>>
>> Enable the clocks, and the HDMI encoder for the M3-N Salvator-XS, and
>> hook it up to the HDMI connector
>>
>> Based on patches from Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>  .../boot/dts/renesas/r8a77965-salvator-xs.dts | 29 +++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
>> b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts index
>> a83a00deed9e..dcf1849f1a67 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
>> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
>> @@ -19,3 +19,32 @@
>>  		reg = <0x0 0x48000000 0x0 0x78000000>;
>>  	};
>>  };
>> +
>> +&du {
>> +	clocks = <&cpg CPG_MOD 724>,
>> +		 <&cpg CPG_MOD 723>,
>> +		 <&cpg CPG_MOD 721>,
>> +		 <&cpg CPG_MOD 727>,
>> +		 <&versaclock6 1>,
>> +		 <&x21_clk>,
>> +		 <&versaclock6 2>;
>> +	clock-names = "du.0", "du.1", "du.3", "lvds.0",
>> +		      "dclkin.0", "dclkin.1", "dclkin.3";
> 
> You should remove the LVDS clock from here too.

Aha, I missed one - thanks.

> 
> Apart from that,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Collected. Thanks.



> 
>> +};
>> +
>> +&hdmi0 {
>> +	status = "okay";
>> +
>> +	ports {
>> +		port at 1 {
>> +			reg = <1>;
>> +			rcar_dw_hdmi0_out: endpoint {
>> +				remote-endpoint = <&hdmi0_con>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&hdmi0_con {
>> +	remote-endpoint = <&rcar_dw_hdmi0_out>;
>> +};
> 
