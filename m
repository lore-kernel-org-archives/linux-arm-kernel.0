From: stefan@agner.ch (Stefan Agner)
Date: Thu, 31 Mar 2016 10:55:13 -0700
Subject: [PATCH 03/18] ARM: dts: vf610-colibri: GPIO wakeup key
In-Reply-To: <20160331081908.GV28207@tiger>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-4-git-send-email-stefan@agner.ch>
 <20160331081908.GV28207@tiger>
Message-ID: <fa5e44e044a2fd8056886c72db2f8483@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-31 01:19, Shawn Guo wrote:
> On Wed, Mar 09, 2016 at 06:16:44PM -0800, Stefan Agner wrote:
>> Enable GPIO wakeup key on Vybrid PAD 41 which is routed to the
>> Colibri default wakeup pin SO-DIMM 45.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> I think this one can be merged independently, right?  One small comment
> below though.
> 

Yes, shouldn't cause any trouble even if wakeup/suspend is not yet
implemented.

>> ---
>>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
>> index 4d8b7f6..936ece6 100644
>> --- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
>> +++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
>> @@ -39,6 +39,8 @@
>>   *     OTHER DEALINGS IN THE SOFTWARE.
>>   */
>>
>> +#include <dt-bindings/input/input.h>
>> +
>>  / {
>>  	chosen {
>>  		stdout-path = "serial0:115200n8";
>> @@ -74,6 +76,20 @@
>>  		gpio = <&gpio2 19 GPIO_ACTIVE_LOW>; /* USBH_PEN resp. USBH_P_EN */
>>  		vin-supply = <&reg_5v0>;
>>  	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_gpiokeys>;
>> +
>> +		power {
>> +			label = "Wake-Up";
>> +			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
>> +			linux,code = <KEY_WAKEUP>;
>> +			debounce-interval = <10>;
>> +			gpio-key,wakeup;
> 
> Please use generic 'wakeup-source' instead.  See the following document
> for details.
> 
> Documentation/devicetree/bindings/power/wakeup-source.txt

Will do.

--
Stefan

> 
>> +		};
>> +	};
>>  };
>>
>>  &bl {
>> @@ -157,5 +173,11 @@
>>  				VF610_PAD_PTB21__GPIO_43	0x22ed
>>  			>;
>>  		};
>> +
>> +		pinctrl_gpiokeys: gpiokeys {
>> +			fsl,pins = <
>> +				VF610_PAD_PTB19__GPIO_41	0x218d
>> +			>;
>> +		};
>>  	};
>>  };
>> --
>> 2.7.2
>>
>>
