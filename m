From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Oct 2012 12:58:07 +0100
Subject: [PATCH 03/10] tty: pxa: configure pin
In-Reply-To: <CACRpkdb+DkZbTDZamGMN+9t07kPktuA_3QtHQJFv+Vu859r7KA@mail.gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-3-git-send-email-haojian.zhuang@gmail.com>
 <508080CB.5010904@wwwdotorg.org>
 <CACRpkdb5Jiw71jBLDXpf2VTJQx7_gABqs03_20CeCLbVT=JkaA@mail.gmail.com>
 <5085AC06.8070508@wwwdotorg.org>
 <CACRpkdY-XyagxGU_ya_FZirzbqStTirOC5nuBBwwFY3f4bBTYA@mail.gmail.com>
 <20121023093711.GS4477@opensource.wolfsonmicro.com>
 <CACRpkdb+DkZbTDZamGMN+9t07kPktuA_3QtHQJFv+Vu859r7KA@mail.gmail.com>
Message-ID: <20121023115806.GX4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 11:59:30AM +0200, Linus Walleij wrote:
> On Tue, Oct 23, 2012 at 11:37 AM, Mark Brown
> > On Tue, Oct 23, 2012 at 11:26:40AM +0200, Linus Walleij wrote:

> > Can we handle this with power domains - if different devices require
> > different orderings they can be placed in power domains which implement
> > the appropriate orderings for them?

> clocks, regulators, pins and all in power domains?

> Then we should rename them "device resource domains" or
> something...

We can call them Ichabod for all I care...

> I have a strong sense of system-wide all-or-nothing approaches
> to this problem.

> - Either we use "power" domains to handle every resource the
>  device has.
> - Or the device driver manages it's own resources.

> I find it pretty hard to build consensus around either idea.

Well, I don't think we want all or nothing approaches here.  One problem
is that we don't have a home for the SoC integration so we're trying to
shove it all into the drivers which just leads to a stack of pointless
boilerplate when the driver isn't actually doing anything beyond the
basic pattern of turning everything off when it goes idle and turning it
on again when it needs to do something.  Having to open code that stuff
in the drivers and then deal with the stubbing and error handling so the
error handling in the drivers is painful.  There's also another axis
where things aren't part of a SoC but are separate devices so you want
to carry things along with the driver rather than have a separate bit of
code which is required to glue things into the platform.

For example it seems fairly clear to me that things like the pinctrl
integration I see in something like sound/soc/fsl/imx-audmux.c shouldn't
really be there as we're just setting up a static configration on boot.
On the other hand where things are directly involved with the active
operation of a device like changing clock rates then clearly the driver
needs to know about and manage things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/48f227e3/attachment.sig>
