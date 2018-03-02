From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 2 Mar 2018 13:46:47 +0100
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302111931.GX9418@n2100.armlinux.org.uk>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
Message-ID: <20180302124647.sfhnto77wgdh5sv6@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


So, maybe some words why I accepted this patch.

On Fri, Mar 02, 2018 at 11:19:31AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> > Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> > so do not treat it as an error.  If interrupt 0 was configured, the driver
> > would exit the probe early, before finishing initialization, but with
> > 0-exit status.
> 
> The official position (as stated by Linus) is that interrupt zero is
> not a valid interrupt for peripheral drivers (it may be valid within
> architecture code for things like the x86 PIT, but nothing else.)

I am aware of that situation and I totally agree with the reasoning.

> You need to number your platform interrupts from one rather than zero.

Ack.

> Note that there have been patches proposed to make platform_get_irq()
> return an error rather than returning a value of zero, so changing
> the driver in this way is not a good idea.

I'd much agree to such an approach, yet I didn't see it coming along so
far for years(?) now.

The reason I applied this patch is consistency with the current
interface. The code is wrong with the way platform_get_irq right now
works. This is independent of platform_get_irq should work, I thought.
This needs to be fixed in a seperate series. This patch will not harm
that transition.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/9150d762/attachment.sig>
