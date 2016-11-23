From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Nov 2016 13:57:48 +0530
Subject: [PATCH 2/4] ARM: dts: davinci: da850: add VPIF
In-Reply-To: <7hh96yiwdj.fsf@baylibre.com>
References: <20161122194551.3420-1-khilman@baylibre.com>
 <20161122194551.3420-3-khilman@baylibre.com>
 <51071aa1-50c5-1121-3e64-018edaf544bf@lechnology.com>
 <7hh96yiwdj.fsf@baylibre.com>
Message-ID: <d4e696d1-f9b2-665c-c44f-c661856c5098@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 November 2016 11:13 AM, Kevin Hilman wrote:
> David Lechner <david@lechnology.com> writes:
> 
>> On 11/22/2016 01:45 PM, Kevin Hilman wrote:
>>> Add VPIF and VPIF capture nodes to da850.  VPIF capture has two input
>>> channels describe using the standard DT ports and enpoints.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>>> ---
>>>  arch/arm/boot/dts/da850.dtsi | 28 ++++++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>>> index 6205917b4f59..e05e2bb834e8 100644
>>> --- a/arch/arm/boot/dts/da850.dtsi
>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>> @@ -453,7 +453,35 @@
>>>  			interrupts = <52>;
>>>  			status = "disabled";
>>>  		};
>>> +
>>> +		vpif: video at 0x00217000 {
>>
>> Should be @217000
>>
>>> +			compatible = "ti,da850-vpif";
>>> +			reg = <0x00217000 0x1000>;
>>
>> Could omit leading 0's to be consistent with existing entries.
>>
>> 	reg = <0x217000 0x1000>;
> 
> Ugh, yeah. I hate that convention, but better to be consistent, I guess.
> 
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		vpif_capture: video-capture at 0x00217000 {
>>
>> Again, @217000. But it seems odd to have two device nodes with the
>> same address. Is enabling these mutually exclusive?
> 
> They're not mutually exclusive because the vpif is the one that actually
> maps the register range (since it's shared between vpif_display and
> vpif_capture) so I guess I should just drop the reg property from the
> vpif_capture node.

Reading the documentation, VPIF is presented as a single device, with
two channels dedicated to display and two for capture. Most of the
channel registers are independent, but there are are some like interrupt
enable which are common for all channels. So I believe we cannot use
simple-mfd. But I believe VPIF display and capture should be subdevices
of a single VPIF device.

It should look something like this, I think:

		vpif: video at 217000 {
			compatible = "ti,da850-vpif";
			reg = <0x217000 0x1000>;
			interrupts = <92>;
			status = "disabled";

			vpif_capture: video-capture {
				compatible = "ti,da850-vpif-capture"
				port {
					vpif_ch0: endpoint at 0 {
						  reg = <0>;
						  bus-width = <8>;
					};
	
					vpif_ch1: endpoint at 1 {
						  reg = <1>;
						  bus-width = <8>;
						  data-shift = <8>;
					};
				};
			};

			vpif_display: video-display {
				compatible = "ti,da850-vpif-display"
				port {
					vpif_ch2: endpoint at 2 {
						  reg = <2>;
						  bus-width = <8>;
						  data-shift = <16>;
					};

					vpif_ch3: endpoint at 3 {
						  reg = <3>;
						  bus-width = <8>;
						  data-shift = <24>;
					};
				};
			};
		};

The interrupt too, seems to be common interrupt for both display and
capture. So, it should not be under the capture node. BTW, I am sure
what exactly data-shift is used for. It does not seem to be used in the
driver patches too. I just extrapolated the values based on the pattern
I saw.

Thanks,
Sekhar
