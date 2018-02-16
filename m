From: kieran.bingham@ideasonboard.com (Kieran Bingham)
Date: Fri, 16 Feb 2018 11:51:51 +0000
Subject: [PATCH 7/8] arm64: dts: renesas: r8a77995-draak: Add HDMI Out
 through ADV7511
In-Reply-To: <2517305.jdPBFiRQEk@avalon>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-8-git-send-email-kbingham@kernel.org>
 <2517305.jdPBFiRQEk@avalon>
Message-ID: <95b1fa2c-8302-e264-2f00-eba5ac34bcd3@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 15/02/18 14:16, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Thursday, 15 February 2018 10:38:22 EET Kieran Bingham wrote:
>> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>
>> Provide a device node for the ADV7511 as found on the Draak D3 platform.
>>
>> The ADV7511 is connected to the DU through a parallel mux chip, and is
>> configurable in hardware whether it is connected to LVDS0 or LVDS1.
>>
>> Connect through to LVDS0 as a default implementation.
> 
> You need to model the LVDS decoder in DT too. I know that no driver and no DT 
> bindings are available at the moment, and I'm aware that this patch enables 
> the HDMI output on the Draak board, but I don't think it's upstreamable as-is.

Ok, understood. - I'll drop this patch for now until we can schedule time to
dedicate to looking into this.

I'm sure the archive's will hold on to this patch for us as a starting point :-)

--
Regards

Kieran

> 
>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>> ---
>>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 56 +++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index
>> 668e246dfc5d..df0c7773cb7d 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>> @@ -27,6 +27,17 @@
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>
>> +	hdmi-out {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_con_out: endpoint {
>> +				remote-endpoint = <&adv7511_out>;
>> +			};
>> +		};
>> +	};
>> +
>>  	vga {
>>  		compatible = "vga-connector";
>>
>> @@ -124,6 +135,39 @@
>>  		reg = <0x50>;
>>  		pagesize = <8>;
>>  	};
>> +
>> +	hdmi at 39 {
>> +		compatible = "adi,adv7511w";
>> +		reg = <0x39>, <0x3f>, <0x38>, <0x3c>;
>> +		reg-names = "main", "edid", "packet", "cec";
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		adi,input-depth = <8>;
>> +		adi,input-colorspace = "rgb";
>> +		adi,input-clock = "1x";
>> +		adi,input-style = <1>;
>> +		adi,input-justification = "evenly";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port at 0 {
>> +				reg = <0>;
>> +				adv7511_in: endpoint {
>> +					remote-endpoint = <&lvds0_out>;
>> +				};
>> +			};
>> +
>> +			port at 1 {
>> +				reg = <1>;
>> +				adv7511_out: endpoint {
>> +					remote-endpoint = <&hdmi_con_out>;
>> +				};
>> +			};
>> +		};
>> +	};
>>  };
>>
>>  &i2c1 {
>> @@ -146,6 +190,18 @@
>>  	};
>>  };
>>
>> +&lvds0 {
>> +	status = "okay";
>> +
>> +	ports {
>> +		port at 1 {
>> +			endpoint {
>> +				remote-endpoint = <&adv7511_in>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>  &ehci0 {
>>  	status = "okay";
>>  };
> 
> 
