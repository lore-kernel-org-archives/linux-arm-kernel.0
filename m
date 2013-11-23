From: marc.ceeeee@gmail.com (Marc C)
Date: Sat, 23 Nov 2013 12:11:41 -0800
Subject: [PATCH RESEND 3/5] ARM: brcmstb: add misc. DT bindings for brcm,
 brcmstb
In-Reply-To: <201311231937.38235.arnd@arndb.de>
References: <529003BB.9030604@gmail.com> <201311231937.38235.arnd@arndb.de>
Message-ID: <52910BFD.2010900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

> Normally the "compatible" string identifies the register layout and
> you keep the offsets in the device driver. Do you have strong reasons to do it
> differently here?

The register block that contains the reset registers also contains other
?general purpose? registers, which can potentially scoot the positions
of both ?sw-master-reset? and ?reset-source-enable?. Although we do
stress to the H/W designers that consistency between chips is important,
and that relative offsets of those registers should remain the same
between chip revisions, there is no guarantee that this will happen.

Now, rather than handling N revisions of the ?sun-top-ctrl? register
block at both the boot loader and kernel levels (N could get very large
as we continue to port support for more chips), I feel that a more
flexible solution would be to rely on the self-describing nature of the DT.

However, I do agree with your suggestion if the registers belong to a
standard and more-static block of registers, such as those for AHCI,
EHCI, or a network controller.

> I would also suggest moving this block into a separate file for the
> reset controller. Make sure you follow the rules from 
> Documentation/devicetree/bindings/reset/reset.txt, most importantly
> adding a "#reset-cells" property so other drivers can refer to this
> node using the reset API.

I will look into this.

Thank you for your feedback!
Marc C

On 11/23/13, 10:37 AM, Arnd Bergmann wrote:
> On Saturday 23 November 2013, Marc C wrote:
>> +This node describes the register block which is used for generic reset control.
>> +
>> +    - compatible: "brcm,brcmstb-sun-top-ctrl"
>> +    - properties:
>> +        o reg = <base_of_sun_top_ctrl_regs length>;
>> +        o reset-source-enable-reg = <offset_from_base>;
>> +        o sw-master-reset-reg = <offset_from_base>;
> 
> Normally the "compatible" string identifies the register layout and you keep the
> offsets in the device driver. Do you have strong reasons to do it differently
> here?
> 
> I would also suggest moving this block into a separate file for the reset
> controller. Make sure you follow the rules from
> Documentation/devicetree/bindings/reset/reset.txt, most importantly adding
> a "#reset-cells" property so other drivers can refer to this node using
> the reset API.
> 
> 	Arnd
> 
