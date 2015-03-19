From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Mar 2015 10:54:42 -0600
Subject: [PATCHv2 3/3] Documentation: DT bindings: Tegra AHB: note base
 address change
In-Reply-To: <alpine.DEB.2.02.1503191601520.9480@utopia.booyaka.com>
References: <20150317083221.32662.14647.stgit@baseline>
 <20150317083221.32662.96822.stgit@baseline>
 <20150317103806.GU8656@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1503191525450.9480@utopia.booyaka.com>
 <550AEE6B.5080301@wwwdotorg.org>
 <alpine.DEB.2.02.1503191601520.9480@utopia.booyaka.com>
Message-ID: <550AFF52.6070503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 10:17 AM, Paul Walmsley wrote:
> On Thu, 19 Mar 2015, Stephen Warren wrote:
>
>> On 03/19/2015 09:26 AM, Paul Walmsley wrote:
>>> On Tue, 17 Mar 2015, Russell King - ARM Linux wrote:
>>>
>>>> On Tue, Mar 17, 2015 at 01:32:21AM -0700, Paul Walmsley wrote:
>>>>>    Required properties:
>>>>>    - compatible : For Tegra20, must contain "nvidia,tegra20-ahb".  For
>>>>> -  Tegra30, must contain "nvidia,tegra30-ahb".  Otherwise, must contain
>>>>> -  '"nvidia,<chip>-ahb", "nvidia,tegra30-ahb"' where <chip> is tegra124,
>>>>> -  tegra132, or tegra210.
>>>>> -- reg : Should contain 1 register ranges(address and length)
>>>>> +  Tegra30, must contain "nvidia,tegra30-ahb".  For Tegra114 and
>>>>> Tegra124, must
>>>>> +  contain '"nvidia,<chip>-ahb", "nvidia,tegra30-ahb"' where <chip> is
>>>>> tegra114
>>>>> +  or tegra124.  For Tegra132, the compatible string must contain
>>>>> +  "nvidia,tegra132-ahb".
>>>>> +
>>>>> +- reg : Should contain 1 register ranges(address and length).  On
>>>>> Tegra20,
>>>>> +  Tegra30, Tegra114, and Tegra124 chips, the low byte of the physical
>>>>> base
>>>>> +  address of the IP block must end in 0x04.  On DT files for later
>>>>> chips, the
>>>>> +  actual hardware base address of the IP block should be used.
>>>>
>>>> You could check that in the driver.  If you can check it in the driver,
>>>> you can also decide to ignore it if it were offset by 0x04 (possibly
>>>> printing a warning.)  That opens up the ability to fix the older Tegra
>>>> DT files going forward while still remaining compatible with existing
>>>> DT files, and avoiding the need for a complex note about this.
>>>
>>> That's fine, I'll do that and drop this patch.
>>
>> Don't we still want to update the DT binding documentation to state what the
>> preferred base address (or at least set of legal base addresses) is/are?
>
> As far as I know, the DT binding documents are intended to be a
> reference for IP block integration data like base addresses.  At least,
> that is not how they've been used in the past, in the cases that I'm
> familiar with.
>
> I can see some marginal utility in changing the base address in the
> example.  But since the worst possible outcome of using the old address is
> a warning message at boot, that margin seems quite small indeed.  Anyone
> who would blindly use the base address from the example to create a DT
> file for a new Tegra SoC isn't doing it correctly.

The binding document is supposed to say what value the reg property 
should have. If we require some unusual offset in the reg property (i.e. 
something other than what the HW documentation describes as the module 
base address), that ought to be documented. We do have this situation 
for this module at present, although the documentation unfortunately 
doesn't explicitly call this out even though the example alludes to it.

I do think we should at least fix the example so it isn't confusing and 
inconsistent with expected practice. We could either switch the example 
to Tegra210 so we only provide the best example going forward, or have 
separate examples for Tegra20/210 to highlight the difference.

We should also add documentation that Chips before Tegra210 (or 
Tegra132?) *require* the extra offset. Any code or DT written to the 
existing (admittedly slightly implicit) binding needs to continue to 
work, so we should document this unusual requirement, even if we enhance 
the Linux driver to accept either mode of operation. Other OSs and old 
versions of Linux will still need the exception for older SoCs.
