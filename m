From: MNARANI@xilinx.com (Manish Narani)
Date: Thu, 6 Sep 2018 13:42:30 +0000
Subject: [PATCH 1/3] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
In-Reply-To: <5b8e8a6c.1c69fb81.21d7a.5b20@mx.google.com>
References: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
 <1535624539-7839-2-git-send-email-manish.narani@xilinx.com>
 <5b8e8a6c.1c69fb81.21d7a.5b20@mx.google.com>
Message-ID: <DM6PR02MB52274964865A3F7CE1A8889AC1010@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for the review. Please see my comments inline.

> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Tuesday, September 4, 2018 6:48 AM
> To: Manish Narani <MNARANI@xilinx.com>
> 
> On Thu, Aug 30, 2018 at 03:52:17PM +0530, Manish Narani wrote:
> > Xilinx AMS have several ADC channels that can be used for measurement
> > of different voltages and temperatures. Document the same in the bindings.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/iio/adc/xilinx-ams.txt     | 159
> +++++++++++++++++++++
> >  1 file changed, 159 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> > b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> > new file mode 100644
> > index 0000000..8cc96f0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> > +AMS device tree subnode:
> > +	- compatible: Should be "xlnx,zynqmp-ams-ps" or "xlnx,zynqmp-ams-pl"
> > +	- reg:  Register space for PS or PL
> 
> Please split each child node into its own section.

Okay. I will update this in v2.

> 
> > +
> > +Optional properties:
> > +
> > +Following optional property only valid for PL.
> 
> property or...

It should be node.  I will update this in v2.

> 
> > +	- xlnx,ext-channels: List of external channels that are connected to the
> > +	                     AMS PL module.
> > +
> > +	  The child nodes of this node represent the external channels which
> > +are
> 
> node?
> 
> > +	  connected to the AMS Module. If the property is not present
> > +	  no external channels will be assumed to be connected.
> > +
> > +	  Each child node represents one channel and has the following
> > +	  properties:
> > +		Required properties:
> > +			* reg: Pair of pins the channel is connected to.
> > +				0: VP/VN
> > +				1: VUSER0
> > +				2: VUSER1
> > +				3: VUSER3
> > +				4: VUSER4
> > +				5: VAUXP[0]/VAUXN[0]
> > +				6: VAUXP[1]/VAUXN[1]
> > +				...
> > +				20: VAUXP[15]/VAUXN[15]
> > +			  Note each channel number should only be used at
> most
> > +			  once.
> > +		Optional properties:
> > +			* xlnx,bipolar: If set the channel is used in bipolar
> > +			  mode.
> > +
> > +
> > +Example:
> > +	xilinx_ams: ams at ffa50000 {
> > +		compatible = "xlnx,zynqmp-ams";
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 56 4>;
> > +		interrupt-names = "ams-irq";
> > +		clocks = <&clkc 70>;
> > +		reg = <0x0 0xffa50000 0x0 0x800>;
> > +		reg-names = "ams-base";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> 
> There's no need for 64-bits of addresses and sizes here. Use ranges.

Okay.

> > +
> > +		ams_ps: ams_ps at ffa50800 {
> > +			compatible = "xlnx,zynqmp-ams-ps";
> > +			reg = <0x0 0xffa50800 0x0 0x400>;
> > +		};
> > +
> > +		ams_pl: ams_pl at ffa50c00 {
> > +			compatible = "xlnx,zynqmp-ams-pl";
> > +			reg = <0x0 0xffa50c00 0x0 0x400>;
> > +			xlnx,ext-channels {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				channel at 0 {
> > +					reg = <0>;
> > +					xlnx,bipolar;
> > +				};
> > +				channel at 1 {
> > +					reg = <1>;
> > +				};
> > +				channel at 8 {
> > +					reg = <8>;
> > +					xlnx,bipolar;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +AMS Channels Details:
> > +
> > +Sysmon Block	|Channel|			Details
> 			|Measurement
> > +		 Number
> 			 Type
> > +---------------------------------------------------------------------------------------------------
> ------
> > +AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.
> 		|Voltage
> > +		|1	|Battery voltage measurement, VCC_PSBATT.
> 		|Voltage
> > +		|2	|PL Internal voltage measurement, VCCINT.
> 		|Voltage
> > +		|3	|Block RAM voltage measurement, VCCBRAM.
> 		|Voltage
> > +		|4	|PL Aux voltage measurement, VCCAUX.
> 		|Voltage
> > +		|5	|Voltage measurement for six DDR I/O PLLs,
> VCC_PSDDR_PLL.	|Voltage
> > +		|6	|VCC_PSINTFP_DDR voltage measurement.
> 			|Voltage
> > +---------------------------------------------------------------------------------------------------
> ------
> > +PS Sysmon	|7	|LPD temperature measurement.
> 			|Temperature
> > +		|8	|FPD Temperature Measurment (REMOTE).
> 			|Temperature
> > +		|9	|VCC PS LPD voltage measurement (supply1).
> 		|Voltage
> > +		|10	|VCC PS FPD voltage measurement (supply2).
> 		|Voltage
> > +		|11	|PS Aux voltage reference (supply3).
> 		|Voltage
> > +		|12	|DDR I/O VCC voltage measurement.
> 		|Voltage
> > +		|13	|PS IO Bank 503 voltage measurement (supply5).
> 			|Voltage
> > +		|14	|PS IO Bank 500 voltage measurement (supply6).
> 			|Voltage
> > +		|15	|VCCO_PSIO1 voltage measurement.
> 		|Voltage
> > +		|16	|VCCO_PSIO2 voltage measurement.
> 		|Voltage
> > +		|17	|VCC_PS_GTR voltage measurement
> (VPS_MGTRAVCC).			|Voltage
> > +		|18	|VTT_PS_GTR voltage measurement
> (VPS_MGTRAVTT).			|Voltage
> > +		|19	|VCC_PSADC voltage measurement.
> 			|Voltage
> > +---------------------------------------------------------------------------------------------------
> ------
> > +PL Sysmon	|20	|PL Temperature measurement.
> 			|Temperature
> > +		|21	|PL Internal Voltage Voltage measurement, VCCINT.
> 		|Voltage
> > +		|22	|PL Auxiliary Voltage measurement, VCCAUX.
> 		|Voltage
> > +		|23	|ADC Reference P+ Voltage measurement.
> 			|Voltage
> > +		|24	|ADC Reference N- Voltage measurement.
> 			|Voltage
> > +		|25	|PL Block RAM Voltage measurement, VCCBRAM.
> 			|Voltage
> > +		|26	|LPD Internal Voltage measurement, VCC_PSINTLP
> (supply4).	|Voltage
> > +		|27	|FPD Internal Voltage measurement, VCC_PSINTFP
> (supply5).	|Voltage
> > +		|28	|PS Auxiliary Voltage measurement (supply6).
> 		|Voltage
> > +		|29	|PL VCCADC Voltage measurement (vccams).
> 		|Voltage
> > +		|30	|Differencial analog input signal Voltage measurment.
> 		|Voltage
> > +		|31	|VUser0 Voltage measurement (supply7).
> 			|Voltage
> > +		|32	|VUser1 Voltage measurement (supply8).
> 			|Voltage
> > +		|33	|VUser2 Voltage measurement (supply9).
> 			|Voltage
> > +		|34	|VUser3 Voltage measurement (supply10).
> 			|Voltage
> > +		|35	|Auxiliary ch 0 Voltage measurement (VAux0).
> 		|Voltage
> > +		|36	|Auxiliary ch 1 Voltage measurement (VAux1).
> 		|Voltage
> > +		|37	|Auxiliary ch 2 Voltage measurement (VAux2).
> 		|Voltage
> > +		|38	|Auxiliary ch 3 Voltage measurement (VAux3).
> 		|Voltage
> > +		|39	|Auxiliary ch 4 Voltage measurement (VAux4).
> 		|Voltage
> > +		|40	|Auxiliary ch 5 Voltage measurement (VAux5).
> 		|Voltage
> > +		|41	|Auxiliary ch 6 Voltage measurement (VAux6).
> 		|Voltage
> > +		|42	|Auxiliary ch 7 Voltage measurement (VAux7).
> 		|Voltage
> > +		|43	|Auxiliary ch 8 Voltage measurement (VAux8).
> 		|Voltage
> > +		|44	|Auxiliary ch 9 Voltage measurement (VAux9).
> 		|Voltage
> > +		|45	|Auxiliary ch 10 Voltage measurement (VAux10).
> 			|Voltage
> > +		|46	|Auxiliary ch 11 Voltage measurement (VAux11).
> 			|Voltage
> > +		|47	|Auxiliary ch 12 Voltage measurement (VAux12).
> 			|Voltage
> > +		|48	|Auxiliary ch 13 Voltage measurement (VAux13).
> 			|Voltage
> > +		|49	|Auxiliary ch 14 Voltage measurement (VAux14).
> 			|Voltage
> > +		|50	|Auxiliary ch 15 Voltage measurement (VAux15).
> 			|Voltage
> > +---------------------------------------------------------------------
> > +------------------------------------
> > --
> > 2.1.1
> >

Thanks,
Manish Narani
