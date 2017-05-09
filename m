From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Tue, 9 May 2017 17:18:43 -0500
Subject: Updating kernel.org cross compilers?
In-Reply-To: <ee8a7f2c-976d-fe2a-55f9-ab8eebbf22eb@arm.com>
References: <92b5ff36-ad2b-10bc-de4f-4774babd9625@arm.com>
 <20170430052957.GJ19687@gate.crashing.org>
 <ee8a7f2c-976d-fe2a-55f9-ab8eebbf22eb@arm.com>
Message-ID: <20170509221843.GZ19687@gate.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

On Tue, May 09, 2017 at 03:59:27PM +0100, Andre Przywara wrote:
> >> and adding --disable-multilib (for building x86-64 on a x86-64
> >> box without 32-bit libs)
> > 
> > Why is this needed?  What error are you seeing.
> 
> It was something along the lines of not finding 32-bit compat libraries
> (which I don't have on that build machine):
> ------------------------
> configure: error: I suspect your system does not have 32-bit development
> libraries (libc and headers). If you have them, rerun configure with
> --enable-multilib. If you do not have them, and want to build a
> 64-bit-only compiler, rerun configure with --disable-multilib.
> ------------------------
> 
> I don't think we need multilib for a kernel build, also we have an i386
> compiler for 32-bit kernels. So adding this flags allows x86_64 to be
> build on pure 64-bit systems.

Oh hrm, so it is building a native compiler?  I thought I got rid of
that everywhere, always build crosses instead.  I'll investigate.

> >> I was able to build (bare-metal) toolchains for
> >> all architectures except arc, m68k, tilegx and tilepro.
> > 
> > arc needs a more recent GCC; the other probably as well.  GCC 7 should
> > be out very soon, you probably want to wait for that :-)
> 
> Well, GCC 7 indeed builds better, but then again is a very new compiler.
> For instance in the moment it spits a lot of warnings when compiling the
> kernel (mostly due to some *printf analysis). It's not hard to fix, but
> this will take a while to trickle in and it's questionable whether this
> will be backported everywhere.
> So in addition to GCC 7.1 I'd like to have at least GCC 6.3 around,
> which builds kernels without warnings today.

If you don't want warnings, turn off the warnings or just don't look at
them...  or fix the problems?  Many of the new warnings point out actual
problems.

Many of those sprintf problems in the kernel have already been fixed.

> For GCC 6.3 (and probably before) arc was breaking because missing a
> (default) CPU type. Adding "--with-cpu=arc700" to EXTRA_GCC_CONF fixed
> that, but GCC 7 indeed builds fine, even without it.

There were other problems, also in binutils.

> Also I removed documentation (share/ directory, which won't be in
> MANPATH mostly anyway) from the tarball and stripped the (host) binaries
> to get the tarball size down (to about 16 MB per arch)

I used to make tarballs for everything together, which is about 200MB
using lzma (which compresses this *much* better than e.g. bzip2).  But
that is a while ago, the compiler grows in size really fast.

> I built both toolchains and kernels for almost all 31 supported
> architectures. Some kernel builds fails (sparc, sparc64, arc), but not
> due to toolchain issues, as it seems. Only sh4 complains:
> sh4-linux-gcc: error: command line option '-m4-nofpu' is not supported
> by this configuration.

Everything builds for me.  I do have a few local patches, also one for
that SuperH problem, yeah.  And my kernel trees are a few weeks old,
who knows what snuck in :-)


Segher
