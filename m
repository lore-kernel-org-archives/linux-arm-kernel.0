From: joe@perches.com (Joe Perches)
Date: Mon, 24 Oct 2016 09:27:57 -0700
Subject: [PATCH] arm64: Neaten show_regs, remove KERN_CONT
In-Reply-To: <20161024113131.GH15620@leverpostej>
References: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
 <20161024113131.GH15620@leverpostej>
Message-ID: <1477326477.1984.2.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-24 at 12:31 +0100, Mark Rutland wrote:
> On Sun, Oct 23, 2016 at 01:40:49PM -0700, Joe Perches wrote:
> > commit db4b0710fae9 ("arm64: fix show_regs fallout from KERN_CONT changes")
> > corrected the KERN_CONT fallout from commit 4bcc595ccd80
> > ("printk: reinstate KERN_CONT for printing continuation lines"), but
> > the code still has unnecessary KERN_CONT uses.  Remove them.
> 
> Why are these unnecessary KERN_CONTs a larger problem than duplicating
> the format string for a third time? Having to duplicate it at all was
> annoying enough.

Not printing partial lines is the best solution to avoiding
message output interleaving.

> Overall, to avoid messing with the KERN_CONT mess it'd be nicer to
> format this all into a buffer (with the format string only existing the
> once) and subsequently print it with one printk call

A single printk call would get one timestamp which would
make for ragged/staggered reading.
