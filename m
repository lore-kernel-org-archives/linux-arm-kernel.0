From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 May 2016 12:49:11 +0200
Subject: [PATCH 01/23] all: syscall wrappers: add documentation
In-Reply-To: <20160527093052.GB7865@e104818-lin.cambridge.arm.com>
References: <6293194.tGy03QJ9ME@wuerfel> <13240365.okADkKsTBJ@wuerfel>
 <20160527093052.GB7865@e104818-lin.cambridge.arm.com>
Message-ID: <5422652.7gdoDlB8u0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 27, 2016 10:30:52 AM CEST Catalin Marinas wrote:
> On Fri, May 27, 2016 at 10:42:59AM +0200, Arnd Bergmann wrote:
> > On Friday, May 27, 2016 8:03:57 AM CEST Heiko Carstens wrote:
> > > > > > > Cost wise, this seems like it all cancels out in the end, but what
> > > > > > > do I know?
> > > > > > 
> > > > > > I think you know something, and I also think Heiko and other s390 guys
> > > > > > know something as well. So I'd like to listen their arguments here.
> > > 
> > > If it comes to 64 bit arguments for compat system calls: s390 also has an
> > > x32-like ABI extension which allows user space to use full 64 bit
> > > registers. As far as I know hardly anybody ever made use of that.
> > > 
> > > However even if that would be widely used, to me it wouldn't make sense to
> > > add new compat system calls which allow 64 bit arguments, simply because
> > > something like
> > > 
> > > c = (u32)a | (u64)b << 32;
> > > 
> > > can be done with a single 1-cycle instruction. It's just not worth the
> > > extra effort to maintain additional system call variants.
> > 
> > For reference, both tile and mips also have separate 32-bit ABIs that are
> > only used on 64-bit kernels (aside from the normal 32-bit ABI). Tile
> > does it like s390 and passes 64-bit arguments as pairs, while MIPS
> > and x86 and pass them as single registers.
> 
> AFAIK, x32 also requires that the upper half of a 64-bit reg is zeroed
> by the user when a 32-bit value is passed. We could require the same on
> AArch64/ILP32 but I'm a bit uneasy on trusting a multitude of C
> libraries on this.

It's not about trusting a C library, it's about ensuring malicious code
cannot pass argumentst that the kernel code assumes will never happen.

	Arnd
