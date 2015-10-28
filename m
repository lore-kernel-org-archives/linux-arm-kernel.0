From: rjui@broadcom.com (Ray Jui)
Date: Tue, 27 Oct 2015 17:25:32 -0700
Subject: [PATCH v3 2/2] arm64: dts: Add BRCM IPROC NAND DT node for NS2
In-Reply-To: <20151028001920.GY13239@google.com>
References: <1445577373-21252-1-git-send-email-anup.patel@broadcom.com>
 <1445577373-21252-3-git-send-email-anup.patel@broadcom.com>
 <20151028001920.GY13239@google.com>
Message-ID: <563015FC.9040006@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/27/2015 5:19 PM, Brian Norris wrote:
> On Fri, Oct 23, 2015 at 10:46:13AM +0530, Anup Patel wrote:
>> The NAND controller on NS2 SoC is compatible with existing
>> BRCM IPROC NAND driver so let's enable it in NS2 DT and
>> NS2 SVK DT.
>>
>> This patch also fixes use of node labels in ns2-svk.dts.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>   arch/arm64/boot/dts/broadcom/ns2-svk.dts | 30 ++++++++++++++++++++----------
>>   arch/arm64/boot/dts/broadcom/ns2.dtsi    | 14 ++++++++++++++
>>   2 files changed, 34 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
>> index e5950d5..6bb3d4d 100644
>> --- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
>> +++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
>> @@ -50,18 +50,28 @@
>>   		device_type = "memory";
>>   		reg = <0x000000000 0x80000000 0x00000000 0x40000000>;
>>   	};
>> +};
>>
>> -	soc: soc {
>> -		i2c0: i2c at 66080000 {
>> -			status = "ok";
>> -		};
>> +&i2c0 {
>> +	status = "ok";
>> +};
>>
>> -		i2c1: i2c at 660b0000 {
>> -			status = "ok";
>> -		};
>> +&i2c1 {
>> +	status = "ok";
>> +};
>> +
>> +&uart3 {
>> +	status = "ok";
>> +};
>>
>> -		uart3: serial at 66130000 {
>> -			status = "ok";
>> -		};
>> +&nand {
>> +	nandcs at 0 {
>> +		compatible = "brcm,nandcs";
>> +		reg = <0>;
>> +		nand-ecc-mode = "hw";
>> +		nand-ecc-strength = <8>;
>> +		nand-ecc-step-size = <512>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>>   	};
>>   };
>> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> index f603277..9610822 100644
>> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> @@ -212,5 +212,19 @@
>>   			compatible = "brcm,iproc-rng200";
>>   			reg = <0x66220000 0x28>;
>>   		};
>> +
>> +		nand: nand at 66460000 {
>> +			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
>
> Technically, the binding says you should also have "brcm,brcmnand" as a
> last resort. Otherwise (for the NAND parts):
>

I believe Anup was seeing issues when both "brcm,nand-iproc" and 
"brcm,brcmnand" are present.

Note "brcm,nand-iproc" invokes 'iproc_nand_probe', which calls 
'brcmnand_probe' in the end.

"brcm,brcmnand" invokes 'brcmstb_nand_probe', which also calls 
'brcmstb_probe', but without all the prep configuration required for 
"brcm,nand-iproc".

> Reviewed-by: Brian Norris <computersforpeace@gmail.com>
