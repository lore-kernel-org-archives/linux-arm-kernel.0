From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 24 Feb 2016 13:35:56 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <20160224105304.GM19428@n2100.arm.linux.org.uk>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com> <20160224105304.GM19428@n2100.arm.linux.org.uk>
Message-ID: <56CD959C.9050007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/16 12:53, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2016 at 03:38:12PM +0200, Tomi Valkeinen wrote:
>> Ok. I feel everyone is trying to push the ugly part out of their domain.
>> I want the board specific hacks out of fbdev. Bootloader people don't
>> want it there. arch/arm/ people don't want it there. =)
> 
> I think that is really really unfair.  No one is trying to push ugly
> bits out of their domain - this is being driven by Linus, who is
> trying to convert Versatile to DT.  There is no other agenda here.
> 
> Remember, I was the one who wrote the CLCD driver, and it was written
> to support the boards at the time using the best methods at the time.
> Things change, people's ideas of what's acceptable change.  What was
> acceptable when classes of boards were separate is no longer acceptable
> with single zImage.

That's fine. I've done the same. The point here is where should we aim
for with today's kernel? What's the good solution for the future boards?

> The board specific parts of CLCD were in arch/arm for a very long time,
> but that gets in the way of single zImage, and the solution adopted by
> the newly interested parties has been to move them to drivers/video
> to keep things working.

And I'm fine with having board specific parts in drivers/video when
needed. That's the only option when we really need a driver for the
board specific parts, i.e. we need to do something with the board
specific HW at runtime.

But that's not really the case with Versatile. Correct me if I'm wrong,
but there's just one panel connected to the board at a time and the
panel cannot be changed at runtime. We need to do the board specific
panel probing once at boot time, but other than that, there's no
difference to a single on-board panel.

To me it sounds that the cleanest solution to this is that the
bootloader does the detection (it's a trivial detection, isn't it? no
complex busses need to be used?), and just passes the kernel the correct
HW setup with DT.

Again, I understand there are lots of board out there without bootloader
doing that, so we may not get there with Versatile. But if someone comes
with patches for a new board, I'd like to have a good suggestion how to
handle similar cases the best way.

> That's how we're here: there isn't a conspiracy as you seem to be
> thinking.

I wasn't exactly serious there, as the smiley tried to imply...

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/6b6f3241/attachment.sig>
