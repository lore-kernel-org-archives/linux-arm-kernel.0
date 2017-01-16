From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Mon, 16 Jan 2017 21:12:19 +0100
Subject: [PATCH] ARM: dts: imx6q-utilite-pro: enable 2nd display pipeline
In-Reply-To: <27256207f2d84b1ca4b7dfc41a413fcc@rwthex-s2-a.rwth-ad.de>
References: <ec9676f344eb4786a28a3c7b969f0e94@rwthex-s1-b.rwth-ad.de>
 <27256207f2d84b1ca4b7dfc41a413fcc@rwthex-s2-a.rwth-ad.de>
Message-ID: <6c25c25f-7811-10fe-2824-e813e88ec8f7@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

ping? It would be very nice if you comment on this patch before it's too 
late for v4.11 (which is soon, I think).

Cheers,
Christopher

On 12/30/2016 03:27 PM, Shawn Guo wrote:
> On Fri, Dec 02, 2016 at 03:37:22PM +0100, christopher.spinrath at rwth-aachen.de wrote:
>> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>>
>> Apart from the already enabled Designware HDMI port, the Utilite Pro
>> has a second display pipeline which has the following shape:
>>
>>   IPU1 DI0 --> Parallel display --> tfp410 rgb24 to DVI encoder
>>                                 --> HDMI connector.
>> Enable support for it.
>>
>> In addition, since this pipeline is hardwired to IPU1, sever the link
>> between IPU1 and the SoC-internal Designware HDMI encoder forcing the
>> latter to be connected to IPU2 instead of IPU1. Otherwise, it is not
>> possible to drive both displays at high resolution due to the bandwidth
>> limitations of a single IPU.
>>
>> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>
> @Philipp, can you help review the changes?
>
>> ---
>>
>> Hi all,
>>
>> the removal of the link between IPU1 and the Designware HDMI encoder is the
>> result of a discussion I had with Philipp Zabel:
>>
>>   https://lists.freedesktop.org/archives/dri-devel/2016-November/125399.html .
>>
>> Altough it is not possible to connect anything else to IPU1 on the Utilite, this
>> approach has at least one disadvantage: if the resolution is low enough such
>> that a single IPU can handle both displays then muxing both displays to IPU1
>> would reduce the power consumption.
>>
>> However, IMHO omitting the link IPU1 <--> DW HDMI is still the preferrable
>> solution since I'm not aware of any OS/driver that is capable of switching IPUs
>> or can handle the bandwidth limitation in a sane way. In particular, Linux is
>> unusable when both displays are supposed to be driven at high resolution and
>> both muxing options for the DW HDMI are available (this is not a userspace
>> issue; the system becomes almost unresponsive as soon as the kernel sets the
>> initial resolution).
>>
>> Cheers,
>> Christopher
>>
>> P.S.: this patch depends on the tfp410 bridge driver which has recently been
>> merged into drm-next.
>
> v4.10-rc1 has the driver, so the dependency is gone now, I guess.
>
>>
>>  arch/arm/boot/dts/imx6q-utilite-pro.dts | 115 ++++++++++++++++++++++++++++++++
>>  1 file changed, 115 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>> index 2200994..69bdd82 100644
>> --- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
>> +++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>> @@ -59,6 +59,33 @@
>>  		rtc1 = &snvs_rtc;
>>  	};
>>
>> +	encoder {
>> +		compatible = "ti,tfp410";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port at 0 {
>> +				reg = <0>;
>> +
>> +				tfp410_in: endpoint {
>> +					remote-endpoint = <&parallel_display_out>;
>> +				};
>> +			};
>> +
>> +			port at 1 {
>> +				reg = <1>;
>> +
>> +				tfp410_out: endpoint {
>> +					remote-endpoint = <&hdmi_connector_in>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>>  	gpio-keys {
>>  		compatible = "gpio-keys";
>>  		pinctrl-names = "default";
>> @@ -72,6 +99,19 @@
>>  		};
>>  	};
>>
>> +	hdmi-connector {
>> +		compatible = "hdmi-connector";
>> +
>
> The newline is unnecessary.
>
>> +		type = "a";
>> +		ddc-i2c-bus = <&i2c_dvi_ddc>;
>> +
>> +		port {
>> +			hdmi_connector_in: endpoint {
>> +				remote-endpoint = <&tfp410_out>;
>> +			};
>> +		};
>> +	};
>> +
>>  	i2cmux {
>>  		compatible = "i2c-mux-gpio";
>>  		pinctrl-names = "default";
>> @@ -105,8 +145,46 @@
>>  			#size-cells = <0>;
>>  		};
>>  	};
>> +
>> +	parallel-display {
>> +		compatible = "fsl,imx-parallel-display";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_ipu1>;
>> +
>
> Ditto
>
> I can fix them up if I get a Reviewed-by tag from Philipp on this
> version.
>
> Shawn
>
>> +		interface-pix-fmt = "rgb24";
>> +
>> +		port at 0 {
>> +			reg = <0>;
>> +
>> +			parallel_display_in: endpoint {
>> +				remote-endpoint = <&ipu1_di0_disp0>;
>> +			};
>> +		};
>> +
>> +		port at 1 {
>> +			reg = <1>;
>> +
>> +			parallel_display_out: endpoint {
>> +				remote-endpoint = <&tfp410_in>;
>> +			};
>> +		};
>> +	};
>>  };
>>
>> +/*
>> + * A single IPU is not able to drive both display interfaces available on the
>> + * Utilite Pro at high resolution due to its bandwidth limitation. Since the
>> + * tfp410 encoder is wired up to IPU1, sever the link between IPU1 and the
>> + * SoC-internal Designware HDMI encoder forcing the latter to be connected to
>> + * IPU2 instead of IPU1.
>> + */
>> +/delete-node/&ipu1_di0_hdmi;
>> +/delete-node/&hdmi_mux_0;
>> +/delete-node/&ipu1_di1_hdmi;
>> +/delete-node/&hdmi_mux_1;
>> +
>>  &hdmi {
>>  	ddc-i2c-bus = <&i2c2>;
>>  	status = "okay";
>> @@ -151,6 +229,39 @@
>>  		>;
>>  	};
>>
>> +	pinctrl_ipu1: ipu1grp {
>> +		fsl,pins = <
>> +			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x38
>> +			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x38
>> +			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x38
>> +			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x38
>> +			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x38
>> +			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x38
>> +			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x38
>> +			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x38
>> +			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x38
>> +			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x38
>> +			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x38
>> +			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x38
>> +			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x38
>> +			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x38
>> +			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x38
>> +			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x38
>> +			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x38
>> +			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x38
>> +			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x38
>> +			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x38
>> +			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x38
>> +			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x38
>> +			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x38
>> +			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x38
>> +			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x38
>> +			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x38
>> +			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x38
>> +			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x38
>> +		>;
>> +	};
>> +
>>  	pinctrl_uart2: uart2grp {
>>  		fsl,pins = <
>>  			MX6QDL_PAD_GPIO_7__UART2_TX_DATA 0x1b0b1
>> @@ -194,6 +305,10 @@
>>  	};
>>  };
>>
>> +&ipu1_di0_disp0 {
>> +	remote-endpoint = <&parallel_display_in>;
>> +};
>> +
>>  &pcie {
>>  	pcie at 0,0 {
>>  		reg = <0x000000 0 0 0 0>;
>> --
>> 2.10.2
>>
