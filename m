From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 22 Mar 2017 17:57:32 +0000
Subject: [PATCH] of: Fix DMA mask assignment
In-Reply-To: <CAL_JsqKAuyePWUC-K21uZEjBU29EZA3WUQOYQdwAZUMOz+mEFg@mail.gmail.com>
References: <94ede94e98502a7948085fba5a16994d3805010c.1488910224.git.robin.murphy@arm.com>
 <CAL_JsqKAuyePWUC-K21uZEjBU29EZA3WUQOYQdwAZUMOz+mEFg@mail.gmail.com>
Message-ID: <826df234-8840-cbf4-74da-cb39bc56af29@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 22/03/17 15:19, Rob Herring wrote:
> On Tue, Mar 7, 2017 at 12:12 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> As we start moving towards mandating that device DMA addressing
>> capabilities are correctly described in DT for platforms like arm64,
> 
> Why? There's no point to dma-ranges if the bus is not restricting the
> device. dma-ranges is supposed to apply to a bus, not a device. For
> example, using dma-ranges for a 32-bit device on a 64-bit platform is
> wrong. To put it another way, devices know their addressing
> capability, so we don't need to describe that in DT, only external
> restrictions outside of the device.

The "mandating dma-ranges" part was something that Arnd had mentioned,
so my interpretation of the rationale might differ slightly, but I
generally didn't disagree. Perhaps my wording is at fault here, but by
"device addressing capabilities" I do mean the capabilities of the
device as integrated into the system, (i.e. whatever interconnect it's
attached to) rather than whatever might be inherent to the device
itself. Nobody's suggesting we start using dma-ranges in some way other
than its existing definition, just that we should put it on any bus
which is not 32 bits wide (in the manner of e.g. amd-seattle-soc.dtsi).

A secondary issue here is that ePAPR/DTSpec isn't particularly clear
about dma-ranges, or more specifically what its absence implies. The
assumption which seems to exist through much of the (PPC) OF code is
that it should be present on any bus which allows DMA through to its
parent, but then for FDT at least we end up sort-of respecting that but
mostly ignoring it such that missing dma-ranges is assumed equivalent to
empty dma-ranges (and thus we also have no way to actually say "children
of this bus that might think they can do DMA, can't").

Now, "devices know their addressing capability" is precisely the problem
that the original commit referenced here was trying to tackle, but the
code turns out to only work correctly in the case where the dma-ranges
size is *less* than 32 bits (it's 31 bits on Keystone, which was the
original platform in question). More generally on 64-bit systems we're
ending up with configurations like a 64-bit NVMe device on PCIe behind
an IOMMU with 48-bit-wide interfaces, neither of which are aware that
only 32/44/etc. bits of address are wired up on the SoC buses in between
it all, and truncation-based hilarity ensues. In order to make use of
dma-ranges as the correct tool for the job, this first wants un-breaking
to properly interpret buses with n-bit limitations where 32 < n < 64.
Then we can actually start preventing drivers from setting wider masks
where a bus limitation exists.

The problem that arises then is what to do when no range is described -
do we change the default mask to 64 bits to represent "no limit" and let
any remaining (bad) drivers relying implicitly on the (deeply-ingrained)
32-bit default start subtly going wrong, or do we play it safe and stick
with the 32-bit default, but with the side effect that nobody can then
DMA above 4GB unless they set an explicitly larger dma-ranges. I believe
the latter was what Arnd was in favour of, and which is alluded to in
this commit message, but in truth I'm equally happy to take either
approach. What I *don't* want is to end up with a bunch of
special-casing where we sometimes allow drivers to enlarge their
device's DMA mask and sometimes don't depending on DT vs. ACPI, some
property present vs. absent, wind direction etc.

>> it
>> turns out that actually assigning DMA masks wider than 32 bits from
>> "dma-ranges" is made largely impossible by the current code. New PCI
>> devices are passed in with 32-bit masks, while new platform devices are
>> passed in with their masks unset, so we install default 32-bit masks for
>> them. As a result, subsequently taking the minimum between any existing
>> mask and the size given by "dma-ranges" means that we can never exceed
>> 32 bits for the vast majority of devices.
>>
>> Since the DT can be assumed to describe the hardware appropriately, and
>> the device's driver is expected by the DMA API to explicitly set a mask
>> later when it probes, we can safely let "dma-ranges" unconditionally
>> override any initial mask from device creation (and as a small bonus
>> deduplicate the calculation in the process).
>>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Murali Karicheri <m-karicheri2@ti.com>
>> Fixes: 9a6d7298b083 ("of: Calculate device DMA masks based on DT dma-range size")
> 
> Changing behavior since 4.1 doesn't really seem like a fix. A fix
> should generally be tagged for stable and I'd be nervous on this one.

Fair enough - some maintainers seem to like fixes tags on anything that
purely corrects something introduced by a previous patch, even if
non-critical, and I don't always guess right :) FWIW I wouldn't consider
this one for stable either (I'd have added the tag myself if so).

> Are we sure all the things a driver may do still work the same? A
> driver changing the default 32-bit mask to a 64-bit mask for example.

Yes, the only change here is that if dma-ranges is present, then its
actual specified size will be now propagated to a newly created device's
initial DMA mask, as opposed to being munged with a fixed 32 bits and/or
whatever the bus code set (which is generally also 32 bits) along the
way. The fact that drivers will then unconditionally stomp on that mask
when they probe with whatever larger or smaller mask they "know" is
appropriate remains unchanged - it's just that however we start tackling
*that* problem we need the dma-ranges info to get through unmolested in
the first place.

(It transpires that we also fail to handle it at all for PCI host
bridges in FDT where we don't have OF nodes for the children, but that's
something else; I'm looking into it.)

Robin.

>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  drivers/of/device.c | 11 ++---------
>>  1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index b1e6bebda3f3..9bb8518b28f2 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -129,15 +129,8 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>         }
>>
>>         dev->dma_pfn_offset = offset;
>> -
>> -       /*
>> -        * Limit coherent and dma mask based on size and default mask
>> -        * set by the driver.
>> -        */
>> -       dev->coherent_dma_mask = min(dev->coherent_dma_mask,
>> -                                    DMA_BIT_MASK(ilog2(dma_addr + size)));
>> -       *dev->dma_mask = min((*dev->dma_mask),
>> -                            DMA_BIT_MASK(ilog2(dma_addr + size)));
>> +       dev->coherent_dma_mask = DMA_BIT_MASK(ilog2(dma_addr + size));
>> +       *dev->dma_mask = dev->coherent_dma_mask;
>>
>>         coherent = of_dma_is_coherent(np);
>>         dev_dbg(dev, "device is%sdma coherent\n",
>> --
>> 2.11.0.dirty
>>
