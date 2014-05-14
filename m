From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 14 May 2014 09:19:39 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140513152518.GA16837@atomide.com>
References: <20140509155504.GE17814@atomide.com> <53707A64.2060203@ti.com>
 <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com>
 <53709706.10501@ti.com>
 <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com>
 <20140512142646.GA31772@atomide.com> <5370E0C9.8050201@ti.com>
 <20140512155132.GH31772@atomide.com> <5371F923.80000@ti.com>
 <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
 <20140513152518.GA16837@atomide.com>
Message-ID: <53730AFB.2090800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/05/14 18:25, Tony Lindgren wrote:

> Well ideally the revision info for a device would come from device
> revision registers rather using the SoC revision. In the DSS case when
> the SoC revision is needed by a device it maybe it can be deciphered
> from a combination of compatible flag and the clock rate for example?

I've been trying that. The HW guys didn't bother to update the DSS
revision registers, so they are useless. And, for example, the OMAP3 ES
difference is only about bitfield widths in two registers.

I tried writing "too long" value to the register on the earlier ES
version, hoping that the extra bits would be kept at zero, but that
wasn't the case. So I just don't see a way to detect this from the DSS's
point of view.

>>> Do you object to the compatible string remapping as such, or just that
>>> it's in arch/arm/mach-omap2?
> 
> It's something I'd rather not have under mach-omap2 as that means that
> I may need to deal with it too to some extent. And I don't think we
> need to do such remapping, we should be able to use the panel compatible
> strings as they are just fine. It should be possible to figure out from
> the device tree properties what controller the panel belongs to. Or
> for now, use the panel registration to figure out what display controller
> it belongs to.
> 
>>> I guess nothing prevents me from moving it to drivers/, and having some
>>> early-ish initcall doing the job.
> 
> /me likes this idea if you need it at all. Stuff like this tends to stay
> and spread, so I'd rather not do the remapping of compatible strings at
> all.

Yep. I'll look to this. Thinking about it now, it kind of makes more
sense to have it in the omapdss's directory.

>> So, since we can change the kernel later but not the DTS, I agree with
>> you that the remapping is the least bad of our options.
> 
> Yes the binding for the panel should just describe the panel so it can be
> used with whatever display controller. But we do have quite a few buses
> probing devices. How about set up the panel probing the same way?

> For the panels on display controller, just do the usual
> for_each_child_of_node(pdev->dev.of_node, child) and probe them?
>
> It seems the remapping of compatible strings is not needed in this
> as we're only picking up panels that are children of the display
> controller.

The panels (or display encoders) are not (usually) children of the
display controller. They are children of their respective control bus.
Say, an i2c panel is a child of i2c bus. If there's no control bus, like
is the case with the sharp panel, it's a platform device.

The video paths of the panels and encoders are connected using the v4l2
style ports/endpoints. We can use those to see what display controller a
panel is connected to, but only after the panel driver has already
probed. We don't have control for the actual probing, as that happens
with whatever the control bus is for the display component.

>>>>> I'm not sure what it would give us to try to be compatible with
>>>>> simple-panel.txt. The simple-panel bindings won't probably be compatible
>>>>> with the future common display drivers in any case, as the simple-panel
>>>>> binding is just too limited and doesn't describe the hardware fully.
>>>>
>>>> Hmm what else does a panel need where the existing binding cannot be
>>>> extended?
>>>
>>> The existing simple-panel binding doesn't describe the connections of
>>> the panel, i.e. its video input. I guess it can be extended, but I don't
>>> see what the benefit is of trying to create new panel bindings
>>> compatible with the simple-panel bindings. As I see, the simple-panel
>>> bindings work only with very limited use cases, where the drivers make
>>> assumptions. Simple panel bindings cannot be used with omapdss, nor can
>>> it be used with the future common display framework.
> 
> Well it seems at least the reset and enable pin standard from that
> binding can be kept.

Only enable gpio there. But even that's vague. Do you turn on the power
before or after setting the enable gpio? How long delay should be
between the power and the gpio? Different panels have different rules
for the power-up.

>>> But I'm not really familiar with using extending current bindings, and
>>> making new bindings compatible with old ones. Can you explain why it'd
>>> be good to have the sharp panel bindings compatible with simple-panel?
>>> In what kind of scenario would it be used?
> 
> Ideally the panel binding just describes the panel and it should not
> matter which display controller it is a child of.

Yes, but that means the panel bindings need to have enough information
so that all display controllers can use it. Simple-panel bindings do not
have enough information. The simple-panel bindings do not have
information about the video bus input, and it doesn't even have
information about the resolution or bitdepth of the panel.

So I'm still asking, if we create sharp bindings that use the same
properties as the simple-panel bindings, and define that sharp panel is
compatible with simple-panel, what kind of scenario in practice would it
be used in?

Would the scenario be some other OS, that doesn't have a driver for the
sharp panel, but has a driver for the simple-panel? That would only work
if the sharp panel hardware is setup so that only the enable gpio is
needed, so that quite a narrow definition of "compatible".

Or is there some other scenario in which it could be used?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/e98ffdd7/attachment.sig>
