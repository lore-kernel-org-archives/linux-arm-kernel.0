From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Dec 2012 11:52:53 -0700
Subject: [PATCH V2 1/6] ARM: tegra: add pending SGI checking API
In-Reply-To: <1354777471.13857.9.camel@jlo-ubuntu-64.nvidia.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
 <1354701715-24150-2-git-send-email-josephl@nvidia.com>
 <50BFC605.3000402@wwwdotorg.org>
 <1354777471.13857.9.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <50C0E985.2020604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2012 12:04 AM, Joseph Lo wrote:
> On Thu, 2012-12-06 at 06:09 +0800, Stephen Warren wrote:
>> On 12/05/2012 03:01 AM, Joseph Lo wrote:
>>> The "powered-down" CPU idle mode of Tegra cut off the vdd_cpu rail, it
>>> include the power of GIC. That caused the SGI (Software Generated
>>> Interrupt) been lost. Because the SGI can't wake up the CPU that in
>>> the "powered-down" CPU idle mode. We need to check if there is any
>>> pending SGI when go into "powered-down" CPU idle mode. This is important
>>> especially when applying the coupled cpuidle framework into "power-down"
>>> cpuidle dirver. Because the coupled cpuidle framework may have the
>>> chance that misses IPI_SINGLE_FUNC handling sometimes.
>>>
>>> For the PPI or SPI, something like the legacy peripheral interrupt. It
>>> still can be maintained by Tegra legacy interrupt controller. If there
>>> is any pending PPI or SPI when CPU in "powered-down" CPU idle mode. The
>>> CPU can be woken up immediately. So we don't need to take care the same
>>> situation for PPI or SPI.
>>
>> Is this feature something that can/should be added to the core GIC
>> driver, rather than something custom in the Tegra code?
>>
> This function is SoC specific code not a generic common code even I
> modify it to more generic for checking the pending irq (SGI, PPI and
> SPI). Different SoC had different design about it. For ex, some SoC only
> put CPU core to power saving mode not include GIC, or there is another
> irq controller can handle the case when CPU go into power saving mode.
> Differenc SoC had different usage here (some need to check all pending
> irq, some need to check SGI only and some even no need to consider
> this).

Hmmm. OK.

>> Part of the reason I ask is that I'd like to avoid any more:
>>
>> static void __iomem *distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
>>
>> since that requires static page tables to be set up, whereas I'd like to
>> reduce, as much as possible, the set of pages Tegra maps statically.
> 
> I can move this into the function as a temp variable.

Well, the issue here is use of the IO_ADDRESS() macro at all; ioremap()
at run-time would be better, which I imagine is what the core GIC driver
does when intialized from DT. Still, I suppose there are many instance
of IO_ADDRESS() in the mach-tegra directory right now, so adding one
more won't hurt too much; we still need to do a big pass to get rid of
them sometime if possible.
