From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 06 Jul 2014 11:46:56 +0200
Subject: [PATCH RFC 06/15] drm/armada: move variant initialisation to
 CRTC init
In-Reply-To: <20140705122115.GP21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
 <E1X3NMM-0000A5-N5@rmk-PC.arm.linux.org.uk> <53B7E86D.5040109@gmail.com>
 <20140705122115.GP21766@n2100.arm.linux.org.uk>
Message-ID: <53B91B10.8060009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2014 02:21 PM, Russell King - ARM Linux wrote:
> On Sat, Jul 05, 2014 at 01:58:37PM +0200, Sebastian Hesselbarth wrote:
>> On 07/05/2014 12:38 PM, Russell King wrote:
>>> Move the variant initialisation entirely to the CRTC init function -
>>> the variant support is really about the CRTC properties than the whole
>>> system, and we want to treat each CRTC individually when we support DT.
>>>
>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>> ---
>> [...]
>>> diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
>>> index 531a9b0bdcfb..3f0e70bb2e9c 100644
>>> --- a/drivers/gpu/drm/armada/armada_crtc.h
>>> +++ b/drivers/gpu/drm/armada/armada_crtc.h
>>> @@ -38,6 +38,7 @@ struct armada_crtc {
>>>  	unsigned		num;
>>>  	void __iomem		*base;
>>>  	struct clk		*clk;
>>> +	struct clk		*extclk[2];
>>
>> I wonder, if we should rename above array srcclk instead of extclk
>> while moving it anyway. That way we can use it for the other variant
>> specific clocks, too.
> 
> pixelclk may be a better name for it.  I would like to think about the

The name was derived from the "SCLK_SOURCE_SELECT" bits in Dove FS, but
any other name not limited to external clocks is fine, too.

> clock handling further though - the issues surrounding clock selection
> are not limited to just Armada - imx-drm has the exact same problem.
> 
> The issue with clocking of CRTCs is that it seems to be common that:
> 
> 1. you have multiple clocks to choose from, some of which may be more
>    suitable than others depending on the type of output.

Given the limited capabilities of the internal clock dividers, on Dove
the heuristic seems to be fairly simple: always prefer the external
clock. This is true for all actively supported Dove boards (Cubox and
{d2,d3}plug) as all have an external PLL connected.

I'd even say to make the external clock mandatory. Hitting a standard
pixclk frequency with one of the internal clocks is pure coincidence.

As long as there is no board using anything else than HDMI transmitter
on dumb RGB, we shouldn't try to foresee any suitable heuristic.

> 2. clocks end up being shared between multiple CRTCs, and one CRTC
>    can (at the moment) interfere with the clock rate delivered to
>    another CRTC.
> 
> This happens on imx-drm today, where the two DIs (CRTCs) are in use -
> one for HDMI, the other for LVDS.  We end up with HDMI set first to
> 148.5MHz, and then LVDS sets it's clock to 65MHz, which results in
> HDMI receiving a clock at over 500MHz!  At the moment, there are hacks
> to solve this by adjusting the muxes in the clock paths to ensure that
> they both derive from different PLLs - moving the LVDS onto the USB OTG
> PLL rather than the video PLL.  That works fine until USB OTG wants
> to change the OTG PLL.

Again, luckily on Cubox we have 2 VCOs for the two external clocks
(audio and video) so we won't have to deal with it. For the {d2,d3}plug
I'll have to check the IDT datasheet again.

In particular, for imx maybe it is possible to identify some clock tree
configurations for specific use-cases. I don't think there is any non-
manual way to tell the best clock tree config.

> There's also the issue whether the output can cope with fractional
> clock-skipping dividers - entirely synchronous display systems can
> (such as synchronously clocked LCD panels), but asynchronous display
> systems (such as HDMI, TV out, etc) can't.  That said, the other
> parameter that needs to be taken account of here is that even with the
> fractional divider, the minimum output clock period isn't the average
> frequency, but the maximum frequency, which may violate a panel's minimum
> clock period specification.

Yeah, the fractional divider isn't made for external HDMI transmitters
for sure. I have seen from your branch that there is some Armada 610
stub for OLPC, do they have a dumb panel directly connected?

I also saw that they do have an external PLL, so maybe we should stick
to the external clock inputs as long as no other configurations pops-up
(which may never happen).

Sebastian

> I think there's lots to do on the clocking side, and as it's a fairly
> complex problem which is common to multiple implementations, I think
> that any solution should not be specific.
> 
> However, this topic isn't one which I want to work on until I have
> reduced down my patch sets to something more manageable - something
> which I'm desperate to do.  (I've been trying to avoid adding any
> further patches to any tree for some time now.)  This is why (eg) I'm
> not going to fix the kernel oops-able bugs I found in the SGTL5000
> codec - someone else can do that.
