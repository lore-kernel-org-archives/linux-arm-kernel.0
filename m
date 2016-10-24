From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Oct 2016 17:42:55 +0100
Subject: [PATCH] arm64: Neaten show_regs, remove KERN_CONT
In-Reply-To: <1477326477.1984.2.camel@perches.com>
References: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
 <20161024113131.GH15620@leverpostej>
 <1477326477.1984.2.camel@perches.com>
Message-ID: <20161024164255.GN15620@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 09:27:57AM -0700, Joe Perches wrote:
> On Mon, 2016-10-24 at 12:31 +0100, Mark Rutland wrote:
> > On Sun, Oct 23, 2016 at 01:40:49PM -0700, Joe Perches wrote:
> > > commit db4b0710fae9 ("arm64: fix show_regs fallout from KERN_CONT changes")
> > > corrected the KERN_CONT fallout from commit 4bcc595ccd80
> > > ("printk: reinstate KERN_CONT for printing continuation lines"), but
> > > the code still has unnecessary KERN_CONT uses.  Remove them.
> > 
> > Why are these unnecessary KERN_CONTs a larger problem than duplicating
> > the format string for a third time? Having to duplicate it at all was
> > annoying enough.
> 
> Not printing partial lines is the best solution to avoiding
> message output interleaving.

Would you mind mentioning that explicitly in the commit message? That
makes it obvious what the benefit of avoiding KERN_CONT is.

> > Overall, to avoid messing with the KERN_CONT mess it'd be nicer to
> > format this all into a buffer (with the format string only existing the
> > once) and subsequently print it with one printk call
> 
> A single printk call would get one timestamp which would
> make for ragged/staggered reading.

That does not appear to be the case; as fr as I can tell the core prints a
timestamp per line as required. If I run:

	printk("TEST\nLINE1\nLINE2\nLINE3\nLINE4\n");

... with "printk.time=1", over the UART:

	[   41.201864] TEST
	[   41.201864] LINE1
	[   41.201864] LINE2
	[   41.201864] LINE3
	[   41.201864] LINE4

... with "printk.time=1", via the $(dmesg):

	[   41.201864] TEST
	[   41.201864] LINE1
	[   41.201864] LINE2
	[   41.201864] LINE3
	[   41.201864] LINE4

... with "printk.time=0", over the UART:

	TEST
	LINE1
	LINE2
	LINE3
	LINE4

... with "printk.time=0", via the $(dmesg):

	TEST
	LINE1
	LINE2
	LINE3
	LINE4

... with "printk.time=0", via $(dmesg -T):

	[Mon Oct 24 17:38:37 2016] TEST
	[Mon Oct 24 17:38:37 2016] LINE1
	[Mon Oct 24 17:38:37 2016] LINE2
	[Mon Oct 24 17:38:37 2016] LINE3
	[Mon Oct 24 17:38:37 2016] LINE4

Thanks,
Mark.
