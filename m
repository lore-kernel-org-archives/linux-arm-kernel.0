From: robherring2@gmail.com (Rob Herring)
Date: Mon, 07 Jan 2013 08:59:41 -0600
Subject: machine_is_dt() ?
In-Reply-To: <20130106140821.GR17242@lunn.ch>
References: <20130106131805.GQ17242@lunn.ch>
 <20130106134113.GD2631@n2100.arm.linux.org.uk>
 <20130106140821.GR17242@lunn.ch>
Message-ID: <50EAE2DD.805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2013 08:08 AM, Andrew Lunn wrote:
> On Sun, Jan 06, 2013 at 01:41:13PM +0000, Russell King - ARM Linux wrote:
>> On Sun, Jan 06, 2013 at 02:18:05PM +0100, Andrew Lunn wrote:
>>> I'm moving the cpuidle code for Kirkwood into drivers/cpuidle. I'm
>>> following the way cpuidle-calxeda.c instantiates the driver, it uses
>>> module_init(calxeda_cpuidle_init) and calxeda_cpuidle_init() uses
>>> of_machine_is_compatible("calxeda,highbank") so only loading the
>>> driver in a ARCH_MULTIPLATFORM kernel when needed.
>>>
>>> I can follow this model for when kirkwood is booted using device
>>> tree. However, i would also like to use the driver for those boards
>>> which are not yet converted to DT. In that situation, we have a kernel
>>> dedicate to kirkwood and the cpuidle driver is always relevant.
>>>
>>> Thus i need to code something like:
>>>
>>> (of_machine_is_compatible("marvell, kirkwood") ||
>>>  !machine_is_dt())
>>>
>>> However, there is no macro machine_is_dt().
>>>
>>> Is there a way to tell if a machine has been booted using a machine
>>> number as opposed to DT?
>>
>> This doesn't seem to me to be the right way to deal with this.  What
>> you're suggesting would mean that if you built a multiplatform kernel
>> which included this driver, and booted it on a non-DT platform, you'd
>> have this driver registered.
> 
> Hi Russel
> 
> Yes, not what i want. I would need to limit it further to non-DT
> platform on Kirkwood.
> 
>> It looks to me like many of the CPUFREQ drivers just register themselves
>> if they've been built into the kernel.  No one's thought about making
>> them platform drivers or similar, so the current "if it's built-in, then
>> we use it" approach seems to have persisted.  As many of them are
>> initialized via a late_initcall(), I don't see any problem with them
>> being platform drivers, which will solve the problem in a way that's
>> well established.
> I actually went towards a platform driver to start with. See the
> discussion here:
> 
> https://patchwork.kernel.org/patch/1915171/
> 
> About 1/2 way down, Rob Herring says:
> 
>       Don't do a platform driver and just check the machine compatible
>       property which is what I did for highbank.
> 
> What Rob mostly seems to be objecting to is that
> 
> +		cpuidle at 1418 {
> +			compatible = "marvell,kirkwood-cpuidle";
> +			reg = <0x1418 0x4>;
> +		};
> 
> does not describe hardware, so it does not belong in DT. Hence i will
> check of_machine_is_compatible() to see if its a marvell,kirkwood. But
> that does not help with old style boots.
> 
> Should i make it both a platform driver for old style boots and check
> of_machine_is_compatible() for DT boots?

You could make the platform code create the platform device in the DT
case as well. Not all platform devices have to come from a DT node and
putting virtual devices in DT is wrong.

Rob

> Thanks
> 	Andrew
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
