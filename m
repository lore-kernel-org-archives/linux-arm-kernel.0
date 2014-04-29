From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 29 Apr 2014 08:26:01 +0300
Subject: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
In-Reply-To: <20140428164528.GM20807@atomide.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
 <535A42D6.5090107@ti.com> <535A4470.2000509@ti.com> <535A5C0A.7040808@ti.com>
 <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com>
 <535DFAAE.1010606@ti.com> <20140428164528.GM20807@atomide.com>
Message-ID: <535F37E9.8090609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/04/14 19:45, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140427 23:53]:
>> On 25/04/14 18:31, Tony Lindgren wrote:
>>
>>> Chances are any mux register in the syscon area already works with
>>> pinctrl-single,pins or pinctrl-single,bits option. The ones in the
>>> padconf area should be already mapped so the driver just has to
>>> request them.
>>
>> If using the padconf (say omap4_padconf_global for omap4), doesn't that
>> mean we need to have platform specific bits in the driver? Isn't that
>> something we've been trying to remove all the time?
> 
> No, it's all done in a Linux generic way during driver probe, see
> drivers/base/pinctrl.c. You just need to define the default pins
> in the .dts files. If you need dynamic remuxing in the driver,
> you can define other named states that the driver can then toggle
> with pinctrl_select_state().

omap4_padconf_global is a syscon node, not pinctrl. As syscon just gives
a raw regmap to its memory area, the driver needs to know about the OMAP
control registers to use it.

Pinctrl-single cannot be used for CONTROL_DSIPHY register, as the
register contents are a bit funny and DSI1 and DSI2 bits are mixed
together. And CONTROL_DSIPHY is already in the memory region defined by
the omap4_padconf_global, so I guess it wouldn't be good to map parts of
the same memory region in a pinctrl node.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/78e8b482/attachment.sig>
