From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 23 Jan 2015 10:47:03 -0700
Subject: [PATCH] arm64: dts: Add initial device tree support for Tegra132
In-Reply-To: <20150123173449.GB10424@leverpostej>
References: <alpine.DEB.2.02.1501161139180.9776@utopia.booyaka.com>
 <20150121161313.GI5044@leverpostej>
 <alpine.DEB.2.02.1501231038130.5450@utopia.booyaka.com>
 <54C27D6F.9000006@wwwdotorg.org> <20150123173449.GB10424@leverpostej>
Message-ID: <54C28917.1070809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2015 10:34 AM, Mark Rutland wrote:
> On Fri, Jan 23, 2015 at 04:57:19PM +0000, Stephen Warren wrote:
>> On 01/23/2015 04:31 AM, Paul Walmsley wrote:
>>> + Arto, Terje for comments on the host1x section
>>> + Stephen Warren for comments on the serial DT data
>>
>>> On Wed, 21 Jan 2015, Mark Rutland wrote:
>>>
>>>> As mentioned in my reply to the DT list patch [1], there are a couple of
>>>> bits I'd like to see cleaned up first, but in the meantime I have some
>>>> comments from my first pass of the dtsi below. Some of these may equally
>>>> apply to existing dts(i) files.
>>>>
>>>> I see a few undocumented compatible strings (at least when comparing
>>>> against mainline). If there are other series or trees I should be
>>>> looking at, any pointers would be appreciated. If not, documentation
>>>> updates would be nice (checkpatch should complain otherwise).
>>
>>>> On Fri, Jan 16, 2015 at 11:45:29AM +0000, Paul Walmsley wrote:
>>>>>
>>>>> Add an initial device tree file for the Tegra132 SoC.  The DT file is
>>>>> based on arch/arm/boot/dts/tegra124.dtsi and
>>>>> arch/arm/boot/dts/tegra114.dtsi, with the following significant
>>>>> changes:
>>>>>
>>>>> - Tegra132 uses a Denver CPU cluster rather than an ARMv7 CPU cluster
>>>>> - Devices are arranged by bus, rather than in a flat topology
>>>>> - No polling delays have been defined for the thermal zones.  I don't
>>>>>     believe that this is a property of the SoC hardware, but rather of a
>>>>>     given use-case.
>>
>>>>> diff --git a/arch/arm64/boot/dts/tegra/tegra132.dtsi b/arch/arm64/boot/dts/tegra/tegra132.dtsi
>>>>> +               /*
>>>>> +                * There are two serial drivers: an 8250 based simple
>>>>> +                * serial driver and an APB DMA based serial driver
>>>>> +                * for higher baudrate and performance. To enable the
>>>>> +                * 8250 based driver, the compatible string is
>>>>> +                * "nvidia,tegra132-uart", "nvidia,tegra124-uart",
>>>>> +                * "nvidia,tegra20-uart" and to enable the APB DMA
>>>>> +                * based serial driver, the compatible string is
>>>>> +                * "nvidia,tegra132-hsuart", "nvidia,tegra124-hsuart",
>>>>> +                * "nvidia,tegra30-hsuart".
>>>>> +                */
>>>>
>>>> Is there any reason to continue with this split?
>>>>
>>>> Surely if the only difference is DMA, the presence of dmas and dma-names
>>>> should be sufficient to get the driver to do the right thing, and if you
>>>> need to disable DMA for debugging that could be a command-line option.
>>
>> I vaguely recall asking for the DMA support to be integrated into the
>> regular 8250 driver instead when the separate DMA-capable driver was
>> first added. I /think/ there was resistance to this because adding lots
>> of different SoC-specific ways to do DMA into the existing 8250 driver
>> would complicate it even more, and hence be unmaintainable.
>>
>> I assume that reasoning is still valid.
>>
>> Perhaps what we need is more fine-grained driver selection, not just
>> based on compatible value. Something like:
>>
>> if compatible == nvidia,tegra20-uart:
>>     if node.has_prop("enable-dma"):
>>       driver = Tegra-specfic DMA capable UART driver
>>     else:
>>       driver = Common 8250 driver
>
> Surely we should assume that if the DMAs are listed (and not disabled)
> they are usable?

I would assume so, yes.

 > I'm not sure I see the point in an additional property
> to force Linux-internal driver selection in this way.

I think it comes down to whether you want to use DMA for that UART or 
not. I don't recall the exact reason why this might be important. 
Perhaps it's one/more of:

- The Tegra-specific DMA-capable driver can't be used for early debug 
but the core 8250 driver can. I don't know if this is true though.

- There are a limited number of DMA channels on Tegra. If all ports 
blindly used DMA simply because the dmas property was included, then 
we'd risk running out of DMA channels for cases where it absolutely had 
to be used; e.g. a low-volume debug console might prevent a high-volume 
MODEM or BT UART from using DMA if they probed in the "wrong" order.

Laxman might be able to shed more light on this.

> What happens if we have a driver for a particular string, but fail to
> probe? Can we fall back to a more generic driver?

At least in this case, I'd assume so, yes.

>> Is that something that of_serial.c could/should be enhanced to do? That
>> said, the whole reasoning behind separate compatible properties before
>> was that compatible is supposed to "drive" driver selection. At least,
>> that's what I was told then.
>
> The compatible string is meant to describe the programming interface the
> device is compatible with. The kernel should then choose the most
> appropriate driver it knows can handle that HW programming interface.
>
> Considering it as a way to choose the driver is backwards. I'd expect
> the device node to have both strings (with the DMA capable string first)
> unless it really doesn't have any DMAs.

That's a subtly different interpretation of DT compatible usage than was 
given (I think it was by Mitch Bradley???) when this driver was 
introduced. In the conversation then, it was asserted that using 
different compatible values to describe that SW should use a different 
interface to the HW (non-DMA vs. DMA) was exactly in line with the 
semantic concept of compatible.
