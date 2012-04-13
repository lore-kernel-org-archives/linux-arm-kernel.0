From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Apr 2012 10:18:29 +0100
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <4F87EBFC.90000@stericsson.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F87EBFC.90000@stericsson.com>
Message-ID: <20120413091828.GJ3168@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 11:03:56AM +0200, Ulf Hansson wrote:

> But, how should those amba drivers that implements runtime PM
> support be able to switch of the vcore regulator during normal
> suspend? In normal suspend case we can not use

A generic AMBA driver should have no idea about the implementation of
the particular SoC that it's integrated on to.  This applies even more
to system suspend (where drivers can generally just assume that they
will loose all power normally) than it does to runtime suspend.

> pm_runtime_put/pm_runtime_put_sync to trigger the power domain
> runtime functions to switch of vcore. This is kind of more generic
> problem when dealing with power domains, but as said this patch will
> have consequences.

The power domain gets callbacks on the system suspend path too and can
do whatever is sensible there.

> As far as I can see, the power domain must then implement a
> suspend_noirq function to make sure same things is done as for the
> runtime_suspend function. Do you agree with this as well or is there
> another option?

Yes, the power domain should just be handling this transparently.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/f7c57571/attachment.sig>
