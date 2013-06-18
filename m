From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Jun 2013 19:33:59 +0100
Subject: [PATCH v4 02/10] pinctrl: mvebu: dove pinctrl driver
In-Reply-To: <20130618151116.GZ2718@n2100.arm.linux.org.uk>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130618113606.GA26763@n2100.arm.linux.org.uk>
 <CACRpkdZTVN2O-Rv4u-Ccb9EzV0At3zc7GYQyTq=HkseOi=GTeg@mail.gmail.com>
 <20130618151116.GZ2718@n2100.arm.linux.org.uk>
Message-ID: <20130618183359.GR1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 04:11:16PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 18, 2013 at 05:02:49PM +0200, Linus Walleij wrote:
> > Nowadays I would do the above with regmap_update_bits().

> > Mutual exclusion for read-modify-write of individual bits in a
> > register is one of those cases where doing a regmap over
> > a memory-mapped register range makes a lot of sense.
> > (drivers/mfd/syscon.c being a nice example)

> So, for that solution we need to have some kind of global regmap per
> register or somesuch.  Then you run into regmap needing a struct
> device - well, with a shared register, which struct device do you
> use, or do you have to invent one?

> That sounds more heavy-weight than is really necessary.

Yes, regmap is far too heavyweight for a lot of these things - it
shouldn't really go in performance critical at the CPU level paths, it's
designed around things where I/O costs are considerable and worth
avoiding.

I do think that this is a very good idea - with the I2C/SPI drivers I
was reviewing prior to regmap there were always just far too many simple
bugs with read/modify/write cycles so factoring out the code really
helped with review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/8db087fa/attachment.sig>
