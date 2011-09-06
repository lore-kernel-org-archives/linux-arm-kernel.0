From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 6 Sep 2011 09:15:59 +0200
Subject: [PATCH 2/7] arm/dts: OMAP3: Add mpu and iva nodes
In-Reply-To: <4E650AEA.2090109@firmworks.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1377915.IaVE5xAurc@wuerfel> <4E64E527.4040409@ti.com>
	<201109051923.51084.arnd@arndb.de> <4E650AEA.2090109@firmworks.com>
Message-ID: <4E65C8AF.1060501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/5/2011 7:46 PM, Mitch Bradley wrote:
> On 9/5/2011 7:23 AM, Arnd Bergmann wrote:
>> On Monday 05 September 2011, Cousson, Benoit wrote:
>>> Yeah, I saw that in the "cpus" node documentation. My point here is that
>>> I do need to represent the MPU subsystem that will contain the cpus. And
>>> thus the Cortex is inside the MPU subsystem.
>
>
> The device tree hierarchy does not represent "containment", but rather
> addressing from the standpoint of a program running on a CPU.
>
>   From that viewpoint, it might be better to have a phandle reference to
> the mpu in each CPU node.

So in that case, I'd rather use a scheme similar to a shared cache 
between CPUs:

cpus {
	cpu at 0 {
		compatible = "arm,cortex-a8";
		subsystem = <&mpu>

		mpu: arm_mpu {
			compatible = "ti,omap3-mpu";
			hwmods = "mpu";
	};
};

And for an OMAP4 SMP system:

cpus {
	cpu at 0 {
		compatible = "arm,cortex-a9";
		subsystem = <&mpu>

		mpu: arm_mpu {
			compatible = "ti,omap4-mpu";
			hwmods = "mpu";
	};

	cpu at 1 {
		compatible = "arm,cortex-a9";
		subsystem = <&mpu>
	};
};

Ideally the interrupt-controller/GIC should probably be inside that MPU 
node, isn't it?

Thanks,
Benoit


>
>>>
>>> I can potentially keep the CPUs inside the cpus node, and just represent
>>> the mpu node inside the soc, with potentially some phandle to the real
>>> cpu nodes.
>>>
>>> Something like that:
>>>
>>> cpus {
>>>           cpu0: cpu at 0 {
>>>                           compatible = "arm,cortex-a8";
>>>           };
>>> };
>>>
>>> [...]
>>>
>>> soc {
>>>           compatible = "ti,omap-infra";
>>>           mpu {
>>>                   compatible = "ti,omap3-mpu";
>>>                   hwmods = "mpu";
>>>                   cpu at 0 {
>>>                           phandle =<&cpu0>;
>>>                           [...]
>>>                   };
>>>           };
>>> };
>>
>> Yes, that looks good. I wouldn't name the attribute "phandle" if I could
>> think of anything better (which I can't at the moment).
>>
>> 	Arnd
>> _______________________________________________
>> devicetree-discuss mailing list
>> devicetree-discuss at lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/devicetree-discuss
>>
