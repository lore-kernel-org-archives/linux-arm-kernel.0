From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 12:29:57 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071121.53302.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071014.03632.arnd@arndb.de>
 <CAN1soZwwr21=JV=NE81aey-1nSMzg-37fXG7zjouALJaU345Fg@mail.gmail.com>
 <201205071121.53302.arnd@arndb.de>
Message-ID: <20120507112956.GJ4415@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 11:21:53AM +0000, Arnd Bergmann wrote:

> Can you explain why you need this kind of arbitration to start with?
> Can't you just ensure that each client of the max8925 only sees a fixed
> set of nonconflicting registers, and provide a higher-level abstractions
> for the registers that are indeed shared between clients?

This is nothing to do with arbitration or sharing.  It's for the case
where you have a set of IP blocks on the chip (and possibly over a
series of different chips) all with the same register map within the IP
block - you need a way to tell the function driver for the IP block
where it is in the chip register map.  A similar thing happens (without
issue) for the interrupts within the chip.

You'd never expect any collisions to need arbitrating, it's purely about
telling the function driver where to find the IP without having to open
code this.  Anything which is actually shared would be handled in the
MFD core for the device normally, or with some other API like genirq.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/c9432b9c/attachment-0001.sig>
