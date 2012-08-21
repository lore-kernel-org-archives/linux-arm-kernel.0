From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 17:09:24 +0300
Subject: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
In-Reply-To: <20120821140803.GK7995@opensource.wolfsonmicro.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
 <20120821124243.GG10347@arwen.pp.htv.fi>
 <20120821132222.GF7995@opensource.wolfsonmicro.com>
 <20120821132741.GI10347@arwen.pp.htv.fi>
 <20120821134936.GH7995@opensource.wolfsonmicro.com>
 <20120821135240.GJ10347@arwen.pp.htv.fi>
 <20120821140803.GK7995@opensource.wolfsonmicro.com>
Message-ID: <20120821140923.GL10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 21, 2012 at 03:08:03PM +0100, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 04:52:41PM +0300, Felipe Balbi wrote:
> 
> > Fair enough, we have "quiet", but I'm not sure that's enough argument to
> > allow any simple driver to start poluting dmesg with whatever random
> > messages.
> 
> I think if the driver is just logging to say "I'm running" that's noise
> and I do push back on that routinely myself; if the driver is providing
> information it's discovered from the running system then that seems much
> more useful and we should have a sensible way of getting that out in a
> place where users are likely to find.

fair enough. But look at the messages which that driver is printing:

+       regmap_read(smsc->regmap, SMSC_DEV_ID, &ret);
+       dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);
+
+       regmap_read(smsc->regmap, SMSC_DEV_REV, &ret);
+       dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);
+
+       regmap_read(smsc->regmap, SMSC_VEN_ID_L, &ret);
+       dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);
+
+       regmap_read(smsc->regmap, SMSC_VEN_ID_H, &ret);
+       dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);

You can't possibly understand what that'll print. First of all, VEN_ID_H
and VEN_ID_L should be ORed together. Second, the user will see the same
message four times in a row, with different values, but see that driver
claims that all four values refer to the device id. What this should do,
is at least combine all four messages into a single one of the format:

dev_(dbg|info)(&i2c->dev, "SMSCxxx devid: %02x rev: %02x venid: %02x\n",
	devid, rev, (venid_h << 8) | venid_l);

or something similar.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/bf7435e6/attachment.sig>
