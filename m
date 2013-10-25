From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 25 Oct 2013 14:13:49 +0300
Subject: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
In-Reply-To: <526A4DEA.3050505@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
 <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com>
Message-ID: <526A526D.3010108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/13 13:54, Nishanth Menon wrote:

>>> would you not be depending on the weak IO pull done using mux to drive
>>> these GPIO pins since the GPIO is not requested and held?
>>
>> Yes. Is that not enough?
> 
> It depend on what the signal draw is and io drive strength which
> varies - original intent of weak pulls were to have a non-active
> default state which are overriden by GPIOs as needed. Else we would
> not be having strong pulls here in pads.
> 
> Typical padmux drive strength for OMAP4460 is around 100uA, min is
> around 50uA. meanwhile as Documentation/gpio.txt generically states,
> the buffers driving at 1.8v on OMAP4460 could be around 6mA or upto
> 8mA. Again, these depend on the specific pin in discussion and Data
> manual explain is larger detail
> 
> Lower current is fine if the switch is ok with it and risk for
> transients are reasonably safe. However, board designs generally
> assume the stronger GPIO drive strength.

Ok. Well, it definitely sounds safer to have a proper gpio pull there, then.

>>> Could we not use Documentation/devicetree/bindings/gpio/gpio.txt
>>> binding to map to the right GPIO and drive it using the GPIO module?
>>
>> Hmm, what do you mean?
>>
>> I do mux the pins to gpios, but there's nothing in the kernel that would
>> use those gpios. That's why we had the hack above, but I'd love to get
>> rid of it.
>>
>> Can I set the pins to GPIO mode, and set the GPIO to high/low in the .dts?
>>
>> If things were perfect, we probably would have a driver for the "switch"
>> part. I have no idea what kind of driver that would be, though, so at
>> the moment we've just gone with the use-LCD2-by-default route.
> 
> I meant you could, in theory provide the gpio numbers and pull
> directions in dts and allow the init to drive them as needed.
> 
> Something like:
> drivers/i2c/busses/i2c-gpio.c as a reference and use
> of_get_named_gpio/of_get_gpio to pick themup..

I'm still not quite following... What init are you referring to?

The problem here is that the gpios don't really belong to anyone in the
kernel, as we don't have a driver for the switch.

Or did you mean that we'd still have the code in dss-common.c, but just
get the gpio numbers from the .dts instead? That makes sense, although
I'd want to get rid of that code altogether.

Should we have support in the gpio-controller to define default values
for gpios? I don't think we can rely on the boot loader to set things
correctly.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131025/dfce2511/attachment.sig>
