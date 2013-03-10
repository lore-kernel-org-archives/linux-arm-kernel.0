From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 10 Mar 2013 22:55:50 +0530
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <513624AA.4090207@wwwdotorg.org>
References: <512BF81A.3080700@wwwdotorg.org> <201302261023.26939.arnd@arndb.de>
 <20130226113538.GS17833@n2100.arm.linux.org.uk>
 <512CF87A.4090404@wwwdotorg.org>
 <20130226181114.GU17833@n2100.arm.linux.org.uk>
 <5130E757.6090500@wwwdotorg.org>
 <20130304063436.GB27241@tbergstrom-lnx.Nvidia.com>
 <20130304091600.GC27241@tbergstrom-lnx.Nvidia.com>
 <5134D50B.8060001@wwwdotorg.org>
 <20130305074047.GH27241@tbergstrom-lnx.Nvidia.com>
 <513624AA.4090207@wwwdotorg.org>
Message-ID: <513CC21E.7080901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013 10:30 PM, Stephen Warren wrote:
> On 03/05/2013 12:40 AM, Peter De Schrijver wrote:
>> On Mon, Mar 04, 2013 at 06:08:27PM +0100, Stephen Warren wrote:
>>> On 03/04/2013 02:16 AM, Peter De Schrijver wrote:
>>>> On Mon, Mar 04, 2013 at 07:34:36AM +0100, Peter De Schrijver wrote:
>>>>> On Fri, Mar 01, 2013 at 06:37:27PM +0100, Stephen Warren wrote:
>>>>>
>>
>> ...
>>
>>>> 1) Handle CPU0 errata WARs in the bootloader
>>>
>>> OK - there's not much choice here, and I've posted a patch for this for
>>> Tegra U-Boot already.
>>>
>>>> 2) Indicate in device tree if linux is booting in secude mode or non-secure
>>>>    mode.
>>>> 3) Use this information in the kernel to decide how to apply the WARs for
>>>>    secondary core bringup and after powerungating.
>>>
>>> Hmmm. That seems like a lot of overhead to avoid duplicating roughly 8
>>> assembly instructions per Tegra version. Also, some/all of the WARs in
>>
>> Unfortunately we can't write to the diag register if we are in non-secure
>> mode. So unless we never want to support running in non-secure mode, we will
>> need to make the distinction somehow and use a different method for non-secure
>> mode. Or assume the secure OS has applied the WARs.
> 
> Yes. The secure OS really has to have enabled the appropriate WARs
> before jumping into the kernel's reset vector. If/when we support the
> upstream kernel running on Tegra in non-secure mode, the plan was to use
> a Tegra-specific mechanism to detect secure-vs-normal mode in the Tegra
> reset vector, and skip the application of secure-only WARs based on that.
> 
>> I'm afraid existing secure
>> OS implementations for Tegra don't work that way though. They just offer an
>> SMC which allows the kernel to read and write the diag register.
> 
> I had a downstream discussion about this, and Bo Yan said someone had
> verified this was working correctly for at least for some WARs on some
> CPUs and for the one particular secure OS we're using.
> 
> I think it's reasonable to require a fixed secure OS (i.e. one that
> correctly enables any required WARs) be used with any upstream kernel,
> since running in normal world would be a new feature that we'd be
> supporting.
> 
> An SMC to read/write the diag register sounds the opposite of secure...
> 
>>> question probably need to be applied very early by assembly code, e.g.
>>> before MMU is re-enabled, so I think you'd end up parsing DT from
>>> assembly again, which would be painful. I tend to think just including
>>> the code in the kernel's SoC-specific reset handler is simplest, and
>>> even with the slight duplication, probably most maintainable. I've
>>> written a patch for this for Tegra already, which I hope to post later
>>> today, depending on testing and what other stuff I get side-tracked on.
>>
>> No. We could just set a flag in __tegra_cpu_reset_handler_data based on the
>> info in DT or use a different reset handler. DT is parsed before bringing up
>> secondary CPUs, so this approach should work I think.
> 
> Yes, that could work.
> 
It might work for few but it isn't an alternative which is maintainable.

Olof proposed to have a common code which can be executed before kernel boot
in recent Linaro connect multi-platform discussion.
Though there was no conclusion on where this file can be part of kernel source
tree. Just form errata WA version control perspective, its is best to have such
errata WA as part of kernel code instead of spreading it over boot-loader, kernel
and firmware/sleep code.

Some of these errata's needs to be enabled before MMU gets enabled and as
discussed in past, we can still get this with 1:1 mapping code once
the SOCs are detected. This can potentially avoid the difficult patching
part for boot CPU which is proposed to be handled in boot-loader. We can
then potentially let the secondary CPUs also execute the same code before
getting into secondary_startup()

And if possible also re-use this code for CPU sleep code as well though
this one isn't must have since this part is already manageable in platform
sleep code.

Regards,
Santosh
