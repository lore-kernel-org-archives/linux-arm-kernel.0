From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Oct 2016 15:32:37 +0100
Subject: [PATCH] arm64: Neaten show_regs, remove KERN_CONT
In-Reply-To: <1477326477.1984.2.camel@perches.com>
References: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
 <20161024113131.GH15620@leverpostej>
 <1477326477.1984.2.camel@perches.com>
Message-ID: <20161025143237.GD8898@leverpostej>
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

Looking further, it seems that KERN_CONT is terminally broken. The core
code somehow swallows newlines from some KERN_CONT prints in a
non-deterministic fashion, and also appears to insert newlines from thin
air. This happens in the absence of intervening printks.

With the current code in v4.9-rc2, we get output like:

x29: 0000ffffe4938c80 x28: 0000000000000000 
x27: 0000000000000000 x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000 
x23: 0000000000000000 x22: 0000000000000000 
x21: 0000000000400470 x20: 0000000000000000 
x19: 0000000000000000 x18: 0000ffffe4938b60 
x17: 0000000000411000 x16: 0000ffff82f72c9c 
x15: 0000ffff830c8000 x14: 0000000000000040 
x13: 0000ffff830c8028 x12: 0000000000008738 
x11: 0000000000000008 
x10: 00000000ffffffff 
x9 : 0000ffff830b4e40 x8 : 2f2f2f2f2f2f2f2f 
x7 : b3b3bab7acff8b8a x6 : 0000ffff83097aa8 
x5 : 54d58839205d3679 x4 : 0000000000000000 
x3 : 00000000004005d0 x2 : ffff000000000000 
x1 : 0000ffffe4938e08 x0 : ffff000000000000 

... or:

x29: 0000fffff6f6a600 x28: 0000000000000000 x27: 0000000000000000 x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000 x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000400470 x20: 0000000000000000 x19: 0000000000000000 x18: 0000fffff6f6a4e0 x17: 0000000000411000 x16: 0000ffffa6e1fc9c x15: 0000ffffa6f75000 x14: 0000000000000040 
x13: 0000ffffa6f75028 x12: 0000000000008738 x11: 0000000000000008 x10: 00000000ffffffff 
x9 : 0000ffffa6f61e40 x8 : 2f2f2f2f2f2f2f2f x7 : b3b3bab7acff8b8a x6 : 0000ffffa6f44aa8 
x5 : 874b6ebb9d5e2f3d x4 : 0000000000000000 x3 : 00000000004005d0 x2 : ffff000000000000 
x1 : 0000fffff6f6a788 x0 : ffff000000000000 

... and of course, the buffer shown by $(dmesg) or $(demsg -T) is equally
insane, but different.

I found that adding a space prior to newlines prevented them from being
swallowed, but $(dmesg) would still suffer from random additions.

Given all that, unless the core code is changed to as to behave
deterministically at least for trivial cases like this one, I think we
should avoid KERN_CONT like the plague.

So FWIW, so long as you fold in the changes I requested in my other
reply, please add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

... I'll go fix up show_pte() without pr_cont().

Thanks,
Mark.
