From: kieran.bingham@ideasonboard.com (Kieran Bingham)
Date: Thu, 15 Feb 2018 14:30:28 +0000
Subject: [PATCH 6/8] arm64: dts: renesas: r8a77995-draak: Enable DU
In-Reply-To: <6281511.bskcdgqsgb@avalon>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-7-git-send-email-kbingham@kernel.org>
 <6281511.bskcdgqsgb@avalon>
Message-ID: <8b2c853c-2963-a116-a246-5fdb30b0688e@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent, Simon,

On 15/02/18 14:12, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Thursday, 15 February 2018 10:38:21 EET Kieran Bingham wrote:
>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> Enable the DU, providing only the VGA output for now.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I assume Simon will take care of this patch.

That will be great, - One small caveat on this patch though:


>> ---
>>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 51 +++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index
>> af07da240be0..668e246dfc5d 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>> @@ -27,6 +27,38 @@
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>
>> +	vga {
>> +		compatible = "vga-connector";
>> +
>> +		port {
>> +			vga_in: endpoint {
>> +				remote-endpoint = <&adv7123_out>;
>> +			};
>> +		};
>> +	};
>> +
>> +	vga-encoder {
>> +		compatible = "adi,adv7123";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port at 0 {
>> +				reg = <0>;
>> +				adv7123_in: endpoint {
>> +					remote-endpoint = <&du_out_rgb>;
>> +				};
>> +			};
>> +			port at 1 {
>> +				reg = <1>;
>> +				adv7123_out: endpoint {
>> +					remote-endpoint = <&vga_in>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>>  	memory at 48000000 {
>>  		device_type = "memory";
>>  		/* first 128MB is reserved for secure area. */
>> @@ -46,6 +78,11 @@
>>  		};
>>  	};
>>
>> +	du_pins: du {
>> +		groups = "du_rgb888", "du_sync", "du_disp", "du_dotclkout0";

The du_dotclkout0 is named differently in Uli's patch. (Of course I believe my
version is correct, but there is some precedent set it would seem).

Anyway, If Uli's version of the PFC is accepted (Which I'm sure it will be),
then I will have to re-spin this patch with the 'different' "du_clk_out_0" value
in the groups.

--
Kieran


>> +		function = "du";
>> +	};
>> +
>>  	i2c0_pins: i2c0 {
>>  		groups = "i2c0";
>>  		function = "i2c0";
>> @@ -95,6 +132,20 @@
>>  	status = "okay";
>>  };
>>
>> +&du {
>> +	pinctrl-0 = <&du_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +
>> +	ports {
>> +		port at 0 {
>> +			endpoint {
>> +				remote-endpoint = <&adv7123_in>;
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
