From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 23 Feb 2016 15:38:12 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
Message-ID: <56CC60C4.6040908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/02/16 15:16, Linus Walleij wrote:
> On Tue, Feb 23, 2016 at 2:00 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 
>> That would be almost the same as what's already in this patch, except
>> (if I'm not mistaken) the detection part could be in platform code, and
>> the fbdev driver itself would know nothing about board specific
>> detection or board specific panel lists.
> 
> In this patch set the board/platform-specific plugins are separated
> out adding the opaque .board_init() and .panel_init() to the driver.
> The platform-specific code is in completely separate files this way,
> and the CLCD driver itself just handles various versions of that
> IP block.

I see. Yes, it's in separate files but still part of the fbdev driver.

One thing to mention is that I'm looking at this maybe from a slightly
different perspective.

TI makes SoCs which may be used on a lot of different boards from
different vendors. I will not allow any solution on TI display subsystem
that would contain any board specific data, as that would quickly expand
to an unmaintainable mess. All the display data has to come from the
bootloader.

Maybe Versatile is different. If CLCD is only used on that board, or a
small family of boards, from one vendor, I guess it is maintainable to
have board specific driver parts for CLCD. But if CLCD can be used by
many vendors in many different boards, I'd steer clear of board specific
driver code.

>> So maybe that would be a bit cleaner. Still ugly, I think =). I really
>> don't like having possible-panels in the Schr?dinger's DT data
>> (http://www.angryflower.com/387.html).
> 
> OK I will focus my work on the DT-augment code instead.

Yeah, I don't know if that will fly either, so I think it's better to
see if these discussion go somewhere first.

>> That said, maybe this is the best way to deal with Versatile, without
>> requiring any change to the bootloader or the boot mechanism.
> 
> Depends on if the OF core maintainers will accept my patches to
> dynamically alter DT properties at runtime. If I can't do that then
> I have to go back to the Schr?dinger patch.
> 
>> What is the current status of Versatile? Have we had working display
>> with Versatile when booting with device tree? Or has the display been
>> supported only with legacy boot?
> 
> Versatile is DT only as of kernel v4.5. The DT boot uses AUXDATA
> which is the Frankenstein solution, bolting on a boardfile piece
> to the DT boot and ignoring the existing panel bindings, and of
> course standing in the way of cleaning things up.

Ok. I feel everyone is trying to push the ugly part out of their domain.
I want the board specific hacks out of fbdev. Bootloader people don't
want it there. arch/arm/ people don't want it there. =)

So what you're saying is that Versatile boots now with DT, and supports
display without any panel info in the DT data? If so, it means that when
you add panel data to the .dts, the old .dts will not support display
anymore, except if you leave all the current boardfile stuff there.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160223/9c052c07/attachment.sig>
