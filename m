From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 10 Sep 2013 17:00:47 +0100
Subject: [GIT PULL 0/3] ARM: SoC: Second round of changes for v3.12
In-Reply-To: <CA+55aFyRUZMJiotV0kAUoeEFpFdvK2r-3rXuS7NO4jHoQ+OkPA@mail.gmail.com>
References: <1378766555-9679-1-git-send-email-khilman@linaro.org>
 <CA+55aFxNbH+G6DVQNxE9di_btA5hxFH93af_vjN2v0eH8e5W-g@mail.gmail.com>
 <1378825549.2627.316.camel@shinybook.infradead.org>
 <CA+55aFyRUZMJiotV0kAUoeEFpFdvK2r-3rXuS7NO4jHoQ+OkPA@mail.gmail.com>
Message-ID: <1378828847.2627.347.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-09-10 at 08:31 -0700, Linus Torvalds wrote:
> 
> Don't be silly. Nobody wants an extra chip. Especially not one that is
> programmable separately from the hardware. 

But if I've got device <foo> attached to pin 15 of a GPIO controller
<bar>, surely that has to be programmed separately from the synthesis of
the two components <foo> and <bar>?

Yeah, if they really are all soft IP and we're *really* doing a whole
system on a single chip, we can do it all at the same time. But it isn't
always like that.

> It's not even what I asked for. I talked about discoverable buses. How
> hard is that to understand? No extra chips, no eeprom, just a bus with
> a notion of configuration cycles. It doesn't even have to be as
> complicated as PCI, it could easily be a read-only model.

Setting aside the inter-component connections that are used to describe
a *board* rather than just a bag full of components, that's still far
from trivial to get right.

Let's assume you can take the same information we have in the
device-tree, and put it in the device itself to be accessed via
'configuration cycles'. Yes, you can certainly avoid having physically
separate EEPROMs for it.

But look at the abortion we've made ourselves of defining the 'bindings'
? the schemas which this extra information needs to conform to, in order
to support the full range of devices of a given type. That's where the
pain has *actually* been, and I suspect that's what's responsible for
the merge issues you were dealing with. Would that really be improved by
trying to force the various vendors of soft-IP peripherals do it
instead? Getting *them* to play along would be like herding cats... and
then they'd have to get their *customers*, who use their designs, to do
it right too in order for it to really work.

It's all very well saying "put it on the device and access it through
configuration cycles", but that doesn't actually address the part of the
problem that's been *most* problematic. If anything, I suspect it would
make it orders of magnitude worse.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130910/b0b1eb5b/attachment.bin>
