From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 18 Sep 2012 20:07:37 +0100
Subject: Bad traps for unaligned access in STM instruction
In-Reply-To: <20120918153119.GC8632@vicerveza.homeunix.net>
References: <20120915104602.GY1943@vicerveza.homeunix.net>
 <20120915105151.GZ1943@vicerveza.homeunix.net>
 <20120918152502.GB2110@linaro.org>
 <20120918153119.GC8632@vicerveza.homeunix.net>
Message-ID: <20120918190737.GC2110@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 05:31:19PM +0200, Llu?s Batlle i Rossell wrote:
> On Tue, Sep 18, 2012 at 04:25:02PM +0100, Dave Martin wrote:
> > On Sat, Sep 15, 2012 at 12:51:51PM +0200, Llu?s Batlle i Rossell wrote:
> > > On Sat, Sep 15, 2012 at 12:46:02PM +0200, Llu?s Batlle i Rossell wrote:
> > > > I'll start looking at the arm traps for unaligned accesses, but maybe someone
> > > > here can give a quick answer.
> > > 
> > > Ah stupid me, here goes the quick answer. I had mode 'warn', and not
> > > 'fixup+warn'. With 'fixup' enabled, all works fine.
> > > 
> > > I was used to mips, where I think there isn't a 'warn' that doesn't 'fixup'.
> > 
> > What source are you actually trying to build/run here?  The "fixup" alignment
> > mode is primarily a workaround for incorrect code, because the legacy rotated
> > unaligned access behaviour would cause really weird things to happen silently
> > in the offending code.  (Although misaligned LDM/STM was never permitted by
> > the architecture anyway, and normally indicates badly-written code.)
> > 
> > Pure C code should never trigger alignment faults fixups unless it
> > violates the C language specification.
> > 
> > Assembler should not trigger faults at all, because it's arch-specific
> > and so you can and should fix it not to cause faults.  Optimising code
> > in assembler becomes pointless if you write or use it in a way which
> > triggers unnecessary faults into the kernel.
> > 
> > If you are getting faults in compiled code and the source code follows
> > the C standard with regard to alignment requirements, this suggests a
> > bug in the compiler.
> 
> This happened in the btrfs userland code, where there are packed structs, and
> structs stored at some offsets of datablocks. Offsets like '+17 bytes' since
> block start loaded from disk, and so.
>
> Then, some functions take pointers to structs. The "datablock+17bytes" is passed
> to processing functions as a pointer to struct. The code in those functions,
> expects that the structs are properly aligned.

Right, so this is not portable C code.  It will work with some
architecture/compiler combinations, but the C language makes no
guarantee about it.

If the structure members are naturally aligned internally but the whole
structure is misaligned, then simple pointer casting tricks will
work with some arches/compilers, as the btrfs tools apparently assume.


Where this doesn't work...

If the structures are truly packed (i.e., padding bytes are removed so
that members are not naturally aligned internally), then you have no choice
except to access them using packed structure types, or implement a load of
accessors to get at the individual members.

Otherwise, if you are sure that the internal layout of the strcuture will
be the same with or without the packed attribute, you can access the
structs with packed structure types to cope with the misalignment ... but
with some performance cost on some architectures.


(Note that you still can't have void foo(struct bar *p) { } if p might
be misaligned for struct bar, even if foo() uses clever misaligned
accessors internally.  This is because that function declaration is a
guarantee to the compiler that at run-time your program ensures that p
will always be suitably aligned for a struct bar on every call.  If
the alignment requirement is > 1 byte, you may find that the compiler
unexpectedly ignores or masks off the bottom bits of in some situations
-- I've seen real examples of this happening.)


> Is the best way to deal with it, to allocate the structs in stack, copy from
> unaligned places to stack, and then work with those stack struct pointers?

Fixes, in decreasing order of preference (just my opinion, of course):

1) The preferred fix would be to naturally align all elements in the _on-disk_
data structures, so that there is never any need to munge them around.  The
ext2/3/4 implementations and the ELF file format do a pretty good job of
this for example...  but I suspect that is may be too late for fix this
for btrfs (?)

2) Do what you suggest and memcpy the structures from/to their packed
locations into properly declared storage.  This could be made build-time
selectable based on the target-arch, to avoid the extra copy on arches
where it doesn't matter, at the expense of adding a little complexity
to the source code.

If the on-disk structures may be in a foreign endianness, you may have
some overhead already in some configurations, in which case the
memcpy might look less expensive.  But I would hope that btrfs is not
foreign-endian in most normal setups.  (I don't know anything about the
btfrs on-disk format though.)

memcpy may not be desirable if the amount of data the code manipulates
per structure on a typical run is much smaller than the whole structure,
because memcpy may dominate the overhead.  mkfs may generate enough
storage I/O delay to mask those overheads, though, depending on various
factors.

3) Alternatively, you need the argument types for all those functions to be
packed too.  This gets rather inelegant, because GCC attribute
handling is inelegant.  You'll also need it everywhere on the
affected call paths.  Also, GCC tends to generate rather inefficient
code for accessing packed structures prior to ARMv6.  Basically
everything has to be split into byte accesses.  So you may want
alternate, non-packed versions of all those functions too if you hit
performance problems.  Attributes are also not portable between
toolchains (which you may or may not care about... but there should be
no good reason for something like mkfs.btrfs to be non-portable.)



If fixing the on-disk structures to align data naturally is not an option,
I guess the most straightforward solutions are to use memcpy() or
to put __attribute__ (( __packed__ )) on all your structure type
definitions everywhere, if you can do this without the definitions
no longer matching the on-disk structure layouts on any architecture.

Both will result some inefficiency, but I suspect the impact of the packed
attribute may be worse for ARM, at least prior to ARMv6.  You could try
both and run some benchmarks if you think that performance is likely to
be an issue.


> In an ideal userland software world, the counters of the traps would be zero.
> But they are not. And without fixup, the mkfs.btrfs fails to run properly, and
> creates a broken filesystem that crashes the kernel.

I agree with Nicolas: if you can crash or compromise the kernel with a
badly or maliciously formatted filesystem, that's a separate, serious
bug in the filesystem driver which absolutely needs to be fixed
(especially when typical desktop environments now like to automount every
filesystem within a 10m radius of your machine...)

Cheers
---Dave
