From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Oct 2012 10:37:12 +0100
Subject: [PATCH 03/10] tty: pxa: configure pin
In-Reply-To: <CACRpkdY-XyagxGU_ya_FZirzbqStTirOC5nuBBwwFY3f4bBTYA@mail.gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-3-git-send-email-haojian.zhuang@gmail.com>
 <508080CB.5010904@wwwdotorg.org>
 <CACRpkdb5Jiw71jBLDXpf2VTJQx7_gABqs03_20CeCLbVT=JkaA@mail.gmail.com>
 <5085AC06.8070508@wwwdotorg.org>
 <CACRpkdY-XyagxGU_ya_FZirzbqStTirOC5nuBBwwFY3f4bBTYA@mail.gmail.com>
Message-ID: <20121023093711.GS4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 11:26:40AM +0200, Linus Walleij wrote:

> I thought about that, but it does not allow us to control the
> resource activation/deactivation order.

> In some drivers the suspend() path could be:

> - pins to sleep
> - clk_disable
> - disable external regulator
> - release power domain

> In others:

> - clk_disable()
> - disable external regulator
> - pins to sleep()
> - release power domain

> Ulf Hansson ran into this a while back.

> Just like with the notifier approach, this approach assumes that either
> the ordering above doesn't matter, or that it is the same for all drivers.

Can we handle this with power domains - if different devices require
different orderings they can be placed in power domains which implement
the appropriate orderings for them?

> We don't have hogs, bus notifiers and the like for regulators,
> and IIRC Mark disliked the idea. Basically I think it's better if
> all resources are atleast handled the same way.

It'd be OK to have something that was manually activated for specific
regulators but it's not sane to try and do something generic as you'll
end up powering off all your wakeup sources which tends not to work so
well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/18171929/attachment.sig>
