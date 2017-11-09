From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 9 Nov 2017 14:48:10 +0000
Subject: [PATCH] arm64/debug: don't duplicate filenames.
In-Reply-To: <20171109144136.n4iser235446sv3x@cedar>
References: <20171109121440.6872-1-jamie.iles@oracle.com>
 <20171109123503.GB22781@e103592.cambridge.arm.com>
 <20171109130851.ozarqoy4u3uag5so@cedar>
 <20171109143121.GC22781@e103592.cambridge.arm.com>
 <20171109144136.n4iser235446sv3x@cedar>
Message-ID: <20171109144809.GD22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 02:41:36PM +0000, Jamie Iles wrote:
> On Thu, Nov 09, 2017 at 02:31:22PM +0000, Dave Martin wrote:
> > On Thu, Nov 09, 2017 at 01:08:51PM +0000, Jamie Iles wrote:
> > > Hi Dave,
> > > 
> > > On Thu, Nov 09, 2017 at 12:35:04PM +0000, Dave Martin wrote:

[...]

> > > > Or is the linker not removing duplicates that some from the same source
> > > > file?
> > > 
> > > In my testing, yes, the linker is merging them.
> > 
> > So, playing devil's advocate here, what is this fixing?
> 
> It's caused some confusion looking at object files, it's certainly not a 
> critical bug!
> 
> > It doesn't really matter where in the toolchain the duplicates get
> > removed, just that it happens somewhere...
> > 
> > It looks like ld -r doesn't do the deduplication, so there may be a fair
> > amount of duplicates before the final linux of vmlinux -- which I guess
> > could be an issue if BUG() is used in macros that get expanded all over
> > the place.
> 
> Ah, interesting.  Testing with a loadable module, this means that there 
> are duplicates in modules.  With mainline:
> 
>   strings ./fs/ext4/ext4.ko | grep -c "inode\.c"
>   61
> 
> and with my patch:
> 
>   strings ./fs/ext4/ext4.ko | grep -c "inode\.c"
>   4
> 
> Thanks,
> 
> Jamie

That's a more convincing argument...  I had forgotten that modules
weren't fully linked.

So this does look like a good idea.  I have some comments, but I'll
reply to the original patch (where there is code).

Cheers
---Dave
