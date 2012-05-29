From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2012 10:39:48 +0100
Subject: [PATCH v2] mtd mxc_nand: use 32bit copy functions
In-Reply-To: <20120529093629.GQ30400@pengutronix.de>
References: <1338279369-25915-1-git-send-email-s.hauer@pengutronix.de>
 <20120529091254.GY3710@pengutronix.de>
 <20120529093629.GQ30400@pengutronix.de>
Message-ID: <20120529093948.GG12217@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 11:36:29AM +0200, Sascha Hauer wrote:
> On Tue, May 29, 2012 at 11:12:54AM +0200, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Tue, May 29, 2012 at 10:16:09AM +0200, Sascha Hauer wrote:
> > > The following commit changes the function used to copy from/to
> > > the hardware buffer to memcpy_[from|to]io. This does not work
> > > since the hardware cannot handle the byte accesses used by these
> > > functions. Instead of reverting this patch introduce 32bit
> > > correspondents of these functions.
> > Hmm, I didn't run an mtd test suite, but on mx27 it worked for me. IMHO
> > it's surprising that memcpy used to work, but memcpy_fromio doesn't. I
> > wouldn't expect a different semantic (apart from normal vs. __iomem
> > memory). And I wonder what will break when ARM's memcpy_fromio et al.
> > is optimized.
> 
> Have a look at the (ARM) implementation of memcpy_fromio:
> 
> void _memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
> {
> 	unsigned char *t = to;
> 	while (count) {
> 		count--;
> 		*t = readb(from);
> 		t++;
> 		from++;
> 	}
> }
> 
> Appearently this uses byte accesses which do not work on NFC SRAM,
> whereas memcpy uses optimized (so 32bit whenever possible) accesses.
> If someone would implement an optimized version of memcpy_fromio, it
> would work for the NFC aswell.
> 
> btw on i.MX27 byte accesses also do not work on NFC SRAM, so I doubt
> this worked for you.

And then when you ask for an odd alignment or an odd number of bytes...
