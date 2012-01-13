From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 13 Jan 2012 12:03:07 +0100
Subject: [PATCH v2 4/5] arm/dts: OMAP3: Add interrupt-controller bindings
 for INTC
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317A43FC@DBDE01.ent.ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
 <1324388398-2683-5-git-send-email-b-cousson@ti.com>
 <79CD15C6BA57404B839C016229A409A8317A43FC@DBDE01.ent.ti.com>
Message-ID: <4F100F6B.2050303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav,

On 1/13/2012 7:14 AM, Hiremath, Vaibhav wrote:
> On Tue, Dec 20, 2011 at 19:09:57, Cousson, Benoit wrote:

[...]

>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -54,10 +54,12 @@
>>   		ranges;
>>   		ti,hwmods = "l3_main";
>>
>> -		intc: interrupt-controller at 1 {
>> -			compatible = "ti,omap3-intc";
>> +		intc: interrupt-controller at 48200000 {
>> +			compatible = "ti,omap2-intc";
>>   			interrupt-controller;
>>   			#interrupt-cells =<1>;
>> +			ti,intc-size =<96>;
> Can we configure/change this field in platform specific .dts file?
> OR
> Is there condition based configuration possible in DT?

I'm not sure to fully understand how your two options differ.
Otherwise, yes the DT it can be configured, that why I exposed this 
attribute.
The intc code was already supporting the ti81xx with 128 lines as well, 
hence the need to make it configurable.
The other option was two handle that in the driver with 2 different 
compatible strings.

> To be specific,
>
> I am adding support for AM335x EVM (using all your DT support patches),
> The device is considered as OMAP3 variant and when it comes to INTC support,
> I need to configure it to value "128", rest everything is same
> (including base add).
>
> Can I do something like
>
> File - am335x-evm.dts
>
> /include/ "omap3.dtsi"
>
> ....
> Again change the specific fields of " intc: interrupt-controller"?

Yes.

> ....
>
> How can this be handled?

After the include, you can redefine the node and the hierarchy:

+	ocp {
+		intc: interrupt-controller at 48200000 {
+			ti,intc-size = <128>;
+		};
...

or use the label directly:

+&intc: {
+	ti,intc-size =<128>;
+}

You can have a look at the way i2c or twl are using the include so far.

Regards,
Benoit
