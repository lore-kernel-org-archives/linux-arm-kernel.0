From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 18 Feb 2016 13:52:32 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <20160217213250.GK19428@n2100.arm.linux.org.uk>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
 <20160217213250.GK19428@n2100.arm.linux.org.uk>
Message-ID: <56C5B080.9090007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 17/02/16 23:32, Russell King - ARM Linux wrote:
> On Wed, Feb 17, 2016 at 05:17:33PM +0100, Linus Walleij wrote:
>> As Russell points out: it's a register that contains a number saying what
>> panel is connected.
>>
>> So it is plug-n-play and I want to preserve this in the patch.
>>
>> The alternative is to make one DTS per display type connected, but that is
>> loosing all the nice plug'n'play :(
> 
> That's totally insane: we're talking about what's plugged in through
> an external connector.  It's not an "internal" device connector.
> These displays are external separate boxes to the board.
> 
> We don't have separate DT files just because we plugged in a USB device
> to a board., or a SDIO card, or an external HDD.

That's because USB, SDIO, HDD are all standard piece of HW, and any
probing can be done via the bus.

For panels we need DT fragments. The question is where these fragments
are and, possibly, who who loads them.

>> But if an overlay can do the same, I'm game for it.
> 
> That's rather eww, because that means you need to either build the
> overlay into the kernel (which IIRC then ties the base DT file to
> that exact kernel) or it needs to sit in userland, which means no
> LCD display until userland is up and running.  It doesn't sound very
> satisfactory, IMHO.

I don't think there are any satisfactory solutions to this.

For me the eww'est option is what this patch does, adding lots of panels
to the .dts, even if the panels are not connected, and having a board
specific fbdev driver. On the other hand, it's easy solution.

One a bit more general question here is: who should know the details of
the board? Is it the bootloader, kernel or userspace? I think the aim
has been to make the kernel drivers generic, not board specific. If so,
it hints either towards the bootloader or userspace. If userspace, the
panels will only be enabled later, when userspace is up.

In my opinion the best option would be to use DT overlays, but so that
the bootloader would supply them, or construct the dtb. But afaik that's
not possible at the moment. And perhaps I think that's the best option
only because I don't work with the bootloaders =).

So, I don't like this, but I don't have a good suggestion how to do it
better with the infrastructure in place at the moment.

We (TI) are struggling with the same problem at the moment (we don't
even have detection capability in all cases), and so far I've refused to
start adding board specific hacks to the display drivers. So I'm very
interested to find a good solution to this too.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160218/768efc8c/attachment.sig>
