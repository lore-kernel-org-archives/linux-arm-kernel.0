From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 15 Aug 2011 19:18:36 +0300
Subject: GPMI-NAND Status?
In-Reply-To: <20040.45443.810005.525431@ipc1.ka-ro>
References: <20110805135133.GA26981@pengutronix.de>
	<20110814081139.GD17063@parrot.com>
	<20040.45443.810005.525431@ipc1.ka-ro>
Message-ID: <1313425121.8691.31.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-08-15 at 07:41 +0200, Lothar Wa?mann wrote:
> > As explained in the thread linked above, this issue should be fixed in your
> > flashing tool, _not_ in your driver. The nand device you are using does not
> > support programming pages multiple times in a row; pretending it does in the
> >
> It's not a problem of the device (Samsung K9F1G08U0B in my case)! The
> problem is that the controller generates an ECC code that is non-FF
> for all-FF data, which JFFS2 cannot handle properly.

I believe that it does not matter for the kernel community that your
specific device can survive multiple writes. I certainly does matter for
you, so if you want a quick fix - just change your kernel, but I would
not recommend to do this.

We (the community) care about the _general_ case - in general, only one
write is allowed, period. Once the JFFS2 or/and the flashing tool is
fixed - the problem will go away.

Let me put it this way - hacking the driver will just hide the issue
deeper - we'll have this issue popped up again a bit later and because
of hacks like that [1] it will be more confusing. Let's avoid this.

Also, someone pointed in that thread that if I write data to NAND - I
want my data to be ECC-protected. Please, explain why my data should be
unprotected if it happened to be just 2KiB of 0xFFs covering whole NAND
page?

Ivan provided much better explanation, showing that even with NOP 4
flashes there may be problems (e.g., 1 write of all 0xFFs + 4 writes
from the user).

[1] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037181.html

-- 
Best Regards,
Artem Bityutskiy
