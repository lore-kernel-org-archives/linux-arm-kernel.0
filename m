From: yankejian@huawei.com (Yankejian (Hackim Yim))
Date: Tue, 8 Dec 2015 20:21:05 +0800
Subject: [PATCH net-next 2/2] net: hns: enet specisies a reference to dsaf
 (config and documents)
In-Reply-To: <20151207141221.GA18040@rob-hp-laptop>
References: <1449302356-54658-1-git-send-email-yankejian@huawei.com>
 <1449302356-54658-3-git-send-email-yankejian@huawei.com>
 <20151207141221.GA18040@rob-hp-laptop>
Message-ID: <5666CB31.6090109@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/7 22:12, Rob Herring wrote:
> On Sat, Dec 05, 2015 at 03:59:16PM +0800, yankejian wrote:
>> when enet specisies a reference to dsaf, the correlative config and
> s/when/When/
ok?i will pay attention to it on patch v3.
thanks.
>> documents needs to update. this patch updates the correlative dtsi file
> s/this/This/
ok?i will pay attention to it on patch v3.
thanks.
>> and bindings documents .
>                         ^
> extra space
>
> This change breaks compatibility with old dtbs. IIRC, this is all new, 
> so maybe it doesn't matter, but you should be explicit that you are 
> doing that.
>
ok?i will pay attention to it on patch v3.
thanks.
>> Signed-off-by: yankejian <yankejian@huawei.com>
>> ---
>>  .../devicetree/bindings/net/hisilicon-hns-dsaf.txt    |  5 +----
>>  .../devicetree/bindings/net/hisilicon-hns-nic.txt     |  7 ++++---
>>  arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi          | 19 +++++++++----------
>>  3 files changed, 14 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
>> index 80411b2..ecacfa4 100644
>> --- a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
>> +++ b/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
>> @@ -4,8 +4,6 @@ Required properties:
>>  - compatible: should be "hisilicon,hns-dsaf-v1" or "hisilicon,hns-dsaf-v2".
>>    "hisilicon,hns-dsaf-v1" is for hip05.
>>    "hisilicon,hns-dsaf-v2" is for Hi1610 and Hi1612.
>> -- dsa-name: dsa fabric name who provide this interface.
>> -  should be "dsafX", X is the dsaf id.
>>  - mode: dsa fabric mode string. only support one of dsaf modes like these:
>>  		"2port-64vf",
>>  		"6port-16rss",
>> @@ -26,9 +24,8 @@ Required properties:
>>  
>>  Example:
>>  
>> -dsa: dsa at c7000000 {
>> +dsaf0: dsa at c7000000 {
>>  	compatible = "hisilicon,hns-dsaf-v1";
>> -	dsa_name = "dsaf0";
>>  	mode = "6port-16rss";
>>  	interrupt-parent = <&mbigen_dsa>;
>>  	reg = <0x0 0xC0000000 0x0 0x420000
>> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
>> index 41d19be..e6a9d1c 100644
>> --- a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
>> +++ b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
>> @@ -4,8 +4,9 @@ Required properties:
>>  - compatible: "hisilicon,hns-nic-v1" or "hisilicon,hns-nic-v2".
>>    "hisilicon,hns-nic-v1" is for hip05.
>>    "hisilicon,hns-nic-v2" is for Hi1610 and Hi1612.
>> -- ae-name: accelerator name who provides this interface,
>> -  is simply a name referring to the name of name in the accelerator node.
>> +- ae-handle: accelerator engine handle for hns,
>> +  specifies a reference to the associating hardware driver node.
>> +  see Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
>>  - port-id: is the index of port provided by DSAF (the accelerator). DSAF can
>>    connect to 8 PHYs. Port 0 to 1 are both used for adminstration purpose. They
>>    are called debug ports.
>> @@ -41,7 +42,7 @@ Example:
>>  
>>  	ethernet at 0{
>>  		compatible = "hisilicon,hns-nic-v1";
>> -		ae-name = "dsaf0";
>> +		ae-handle = <&dsaf0>;
>>  		port-id = <0>;
>>  		local-mac-address = [a2 14 e4 4b 56 76];
>>  	};
>> diff --git a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
>> index 606dd5a..89c883e 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
>> @@ -23,9 +23,8 @@ soc0: soc at 000000000 {
>>  		};
>>  	};
>>  
>> -	dsa: dsa at c7000000 {
>> +	dsaf0: dsa at c7000000 {
>>  		compatible = "hisilicon,hns-dsaf-v1";
>> -		dsa_name = "dsaf0";
>>  		mode = "6port-16rss";
>>  		interrupt-parent = <&mbigen_dsa>;
>>  
>> @@ -127,7 +126,7 @@ soc0: soc at 000000000 {
>>  
>>  	eth0: ethernet at 0{
>>  		compatible = "hisilicon,hns-nic-v1";
>> -		ae-name = "dsaf0";
>> +		ae-handle = <&dsaf0>;
>>  		port-id = <0>;
>>  		local-mac-address = [00 00 00 01 00 58];
>>  		status = "disabled";
>> @@ -135,14 +134,14 @@ soc0: soc at 000000000 {
>>  	};
>>  	eth1: ethernet at 1{
>>  		compatible = "hisilicon,hns-nic-v1";
>> -		ae-name = "dsaf0";
>> +		ae-handle = <&dsaf0>;
>>  		port-id = <1>;
>>  		status = "disabled";
>>  		dma-coherent;
>>  	};
>>  	eth2: ethernet at 2{
>>  		compatible = "hisilicon,hns-nic-v1";
>> -		ae-name = "dsaf0";
>> +		ae-handle = <&dsaf0>;
>>  		port-id = <2>;
>>  		local-mac-address = [00 00 00 01 00 5a];
>>  		status = "disabled";
>> @@ -150,7 +149,7 @@ soc0: soc at 000000000 {
>>  	};
>>  	eth3: ethernet at 3{
>>  		compatible = "hisilicon,hns-nic-v1";
>> -		ae-name = "dsaf0";
>> +		ae-handle = <&dsaf0>;
>>  		port-id = <3>;
>>  		local-mac-address = [00 00 00 01 00 5b];
>>  		status = "disabled";
>> @@ -158,7 +157,7 @@ soc0: soc at 000000000 {
>>  	};
>>  	eth4: ethernet at 4{
>>  		compatible = "hisilicon,hns-nic-v1";
>> -		ae-name = "dsaf0";
>> +		ae-handle = <&dsaf0>;
>>  		port-id = <4>;
>>  		local-mac-address = [00 00 00 01 00 5c];
>>  		status = "disabled";
>> @@ -166,7 +165,7 @@ soc0: soc at 000000000 {
>>  	};
>>  	eth5: ethernet at 5{
>>  		compatible = "hisilicon,hns-nic-v1";
>> -		ae-name = "dsaf0";
>> +		ae-handle = <&dsaf0>;
>>  		port-id = <5>;
>>  		local-mac-address = [00 00 00 01 00 5d];
>>  		status = "disabled";
>> @@ -174,7 +173,7 @@ soc0: soc at 000000000 {
>>  	};
>>  	eth6: ethernet at 6{
>>  		compatible = "hisilicon,hns-nic-v1";
>> -		ae-name = "dsaf0";
>> +		ae-handle = <&dsaf0>;
>>  		port-id = <6>;
>>  		local-mac-address = [00 00 00 01 00 5e];
>>  		status = "disabled";
>> @@ -182,7 +181,7 @@ soc0: soc at 000000000 {
>>  	};
>>  	eth7: ethernet at 7{
>>  		compatible = "hisilicon,hns-nic-v1";
>> -		ae-name = "dsaf0";
>> +		ae-handle = <&dsaf0>;
>>  		port-id = <7>;
>>  		local-mac-address = [00 00 00 01 00 5f];
>>  		status = "disabled";
>> -- 
>> 1.9.1
>>
> .
>
