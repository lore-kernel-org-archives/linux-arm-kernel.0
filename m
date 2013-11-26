From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Nov 2013 19:25:43 +0000
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <alpine.LFD.2.10.1311261323280.9667@knanqh.ubzr>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
 <20131125233654.GV16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311252254200.9667@knanqh.ubzr>
 <20131126095430.GA16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311260834520.9667@knanqh.ubzr>
 <20131126134155.GB16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311261205300.9667@knanqh.ubzr>
 <20131126173659.GE16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311261323280.9667@knanqh.ubzr>
Message-ID: <20131126192543.GG16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 01:41:08PM -0500, Nicolas Pitre wrote:
> On Tue, 26 Nov 2013, Russell King - ARM Linux wrote:
> > If manual inspection fails you, try building a nommu or XIP kernel.
> 
> All right.  I did a build test of course.  What failed me is the 
> difficulty nowdays to have the desired config symbols enabled (or 
> left disabled for that matter) without other rules overriding manual 
> choices.

This is precisely why reading and understanding the file (as I did) is
much more important than chucking out emails on a mailing list.  I'd
already taken the time to see that there were _three_ levels if ifdef
there and the problem case was buried in the depths of that.

> I think your patch is therefore the best solution.  However, I'd suggest 
> you include this as well to enforce configuration validity:
> 
> #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> #undef PLAT_PHYS_OFFSET
> #endif
> 
> The idea as I explained in my previous email is to prevent wrong usage.

I don't believe it's necessary.  Why?

PLAT_PHYS_OFFSET gets defined in one of two ways:

1. We have a mach/memory.h
2. We have CONFIG_PHYS_OFFSET defined

CONFIG_PHYS_OFFSET will only be defined if ARM_PATCH_PHYS_OFFSET has been
disabled.  So that leaves us with needing a mach/memory.h to define it.

Now, if you consider that the majority of builds today use multiplatform
which requires there that there be no mach/memory.h, and that requires
the phys offset patching, we've already got way more than enough build
coverage to find mis-uses, especially with the amount of building that
Olof and myself do on the ARM kernel.

Moreover, this is no different from what it is today.  It hasn't suddenly
become more visible.

Hence, no matter what, such a change should not be part of fixing up
the original breakage.
