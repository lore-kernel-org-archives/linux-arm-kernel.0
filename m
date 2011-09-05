From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 5 Sep 2011 17:05:11 +0200
Subject: [PATCH 2/7] arm/dts: OMAP3: Add mpu and iva nodes
In-Reply-To: <1377915.IaVE5xAurc@wuerfel>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1314897912-18178-3-git-send-email-b-cousson@ti.com>
	<1377915.IaVE5xAurc@wuerfel>
Message-ID: <4E64E527.4040409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 9/1/2011 8:17 PM, Arnd Bergmann wrote:
> On Thursday 01 September 2011 19:25:07 Benoit Cousson wrote:
>>
>>          /*
>> +        * XXX: The cpus node is mandatory, but since the CPUs are as well part
>> +        * of the mpu subsystem below, it is not clear where the information
>> +        * should be. Maybe here with a phandle inside the mpu?
>> +        */
>> +       cpus {
>> +       };
>> +
>> +       /*
>>           * The soc node represents the soc top level view. It is uses for IPs
>>           * that are not memory mapped in the MPU view or for the MPU itself.
>>           */
>>          soc {
>>                  compatible = "ti,omap-infra";
>> +               mpu {
>> +                       compatible = "ti,omap3-mpu";
>> +                       hwmods = "mpu";
>> +                       cpu at 0 {
>> +                               compatible = "arm,cortex-a8";
>> +                       };
>> +               };
>> +
>
> I would always put the cpu nodes in the top-level, even if that's
> a slight misrepresentation of the truth. The point is basically
> that CPU nodes are special (you cannot have device drivers for them)
> and that the device tree is basically laid out from the perspective
> of the CPU, which may be different from the perspective that a
> hardware designer has.

Yeah, I saw that in the "cpus" node documentation. My point here is that 
I do need to represent the MPU subsystem that will contain the cpus. And 
thus the Cortex is inside the MPU subsystem.

I can potentially keep the CPUs inside the cpus node, and just represent 
the mpu node inside the soc, with potentially some phandle to the real 
cpu nodes.

Something like that:

cpus {
	cpu0: cpu at 0 {
			compatible = "arm,cortex-a8";
	};
};

[...]

soc {
	compatible = "ti,omap-infra";
	mpu {
		compatible = "ti,omap3-mpu";
		hwmods = "mpu";
		cpu at 0 {
			phandle = <&cpu0>;
			[...]
		};
	};
};


Does that look better?

Thanks,
Benoit
