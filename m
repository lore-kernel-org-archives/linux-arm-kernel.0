From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 4 Jun 2018 15:24:28 -0700
Subject: [PATCH] arm64: dts: stingray: move common board components to
 stingray-board-base
In-Reply-To: <05b33af8-c938-f124-f918-a9d7f8679d90@gmail.com>
References: <1527015342-9317-1-git-send-email-scott.branden@broadcom.com>
 <05b33af8-c938-f124-f918-a9d7f8679d90@gmail.com>
Message-ID: <dcf364c7-2488-9c3b-9b55-4080b746c83d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,


On 18-06-04 02:09 PM, Florian Fainelli wrote:
> On 05/22/2018 11:55 AM, Scott Branden wrote:
>> Move common board components from base bcm958742 dtsi file to new
>> stingray-board-base dtsi file so they can be shared between many stingray
>> boards following common design.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>
> Applied to devicetree-arm64/next, though this did not apply cleanly,
> please check the results at:
>
> https://github.com/Broadcom/stblinux/commit/0b2cf5a855cd235fa95fbdfedfc524a97a71a7fe
It's looks fine.
>
>> ---
>>   .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 35 +--------------
>>   .../dts/broadcom/stingray/stingray-board-base.dtsi | 51 ++++++++++++++++++++++
>>   2 files changed, 52 insertions(+), 34 deletions(-)
>>   create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> index cacc25e..d74f6df 100644
>> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> @@ -30,20 +30,9 @@
>>    *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>    */
>>   
>> -#include "stingray.dtsi"
>> +#include "stingray-board-base.dtsi"
>>   
>>   / {
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -
>> -	aliases {
>> -		serial0 = &uart1;
>> -		serial1 = &uart0;
>> -		serial2 = &uart2;
>> -		serial3 = &uart3;
>> -	};
>> -
>>   	sdio0_vddo_ctrl_reg: sdio0_vddo_ctrl {
>>   		compatible = "regulator-gpio";
>>   		regulator-name = "sdio0_vddo_ctrl_reg";
>> @@ -67,23 +56,6 @@
>>   	};
>>   };
>>   
>> -&memory { /* Default DRAM banks */
>> -	reg = <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
>> -	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
>> -};
>> -
>> -&mdio_mux_iproc {
>> -	mdio at 10 {
>> -		gphy0: eth-phy at 10 {
>> -			reg = <0x10>;
>> -		};
>> -	};
>> -};
>> -
>> -&uart1 {
>> -	status = "okay";
>> -};
>> -
>>   &pwm {
>>   	status = "okay";
>>   };
>> @@ -111,8 +83,6 @@
>>   };
>>   
>>   &enet {
>> -	phy-mode = "rgmii-id";
>> -	phy-handle = <&gphy0>;
>>   	status = "okay";
>>   };
>>   
>> @@ -133,13 +103,10 @@
>>   
>>   &sdio0 {
>>   	vqmmc-supply = <&sdio0_vddo_ctrl_reg>;
>> -	non-removable;
>> -	full-pwr-cycle;
>>   	status = "okay";
>>   };
>>   
>>   &sdio1 {
>>   	vqmmc-supply = <&sdio1_vddo_ctrl_reg>;
>> -	full-pwr-cycle;
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
>> new file mode 100644
>> index 0000000..82a2471
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
>> +/*
>> + *  Copyright(c) 2016-2018 Broadcom
>> + */
>> +
>> +#include "stingray.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	aliases {
>> +		serial0 = &uart1;
>> +		serial1 = &uart0;
>> +		serial2 = &uart2;
>> +		serial3 = &uart3;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&memory { /* Default DRAM banks */
>> +	reg = <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
>> +	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
>> +};
>> +
>> +&enet {
>> +	phy-mode = "rgmii-id";
>> +	phy-handle = <&gphy0>;
>> +};
>> +
>> +&uart1 {
>> +	status = "okay";
>> +};
>> +
>> +&sdio0 {
>> +	non-removable;
>> +	full-pwr-cycle;
>> +};
>> +
>> +&sdio1 {
>> +	full-pwr-cycle;
>> +};
>> +
>> +&mdio_mux_iproc {
>> +	mdio at 10 {
>> +		gphy0: eth-phy at 10 {
>> +			reg = <0x10>;
>> +		};
>> +	};
>> +};
>>
>
