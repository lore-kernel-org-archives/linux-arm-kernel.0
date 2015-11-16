From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 12:00:17 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <alpine.DEB.2.10.1511161001250.25844@digraph.polyomino.org.uk>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <5648B5E3.3060700@ezchip.com>
 <alpine.DEB.2.10.1511161001250.25844@digraph.polyomino.org.uk>
Message-ID: <4814795.z9jdqoW8IP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 November 2015 10:16:35 Joseph Myers wrote:
> On Sun, 15 Nov 2015, Chris Metcalf wrote:
> 
> > I've added Rich, Paul, Joseph, and Mike to the cc's as they are probably 
> > a good subset of libc-alpha to help comment on these issues.  My sense 
> > is that right now, it wouldn't be possible to add a 32-bit architecture 
> > with a non-32-bit default for _FILE_OFFSET_BITS.  And, obviously, this 
> > is why, when I added the tilegx32 APIs to glibc in 2011, I needed to 
> > provide _FILE_OFFSET_BITS=32 support.
> 
> x32 uses 64-bit off_t only.  That's not a problem; the problems are 
> tv_nsec not of type long, a bug we should avoid for all new ports (padding 
> on tv_nsec is fine; treating that padding as a significant high part of a 
> 64-bit value on input to glibc / kernel interfaces isn't), and maybe some 
> other types being 64-bit unnecessarily, although as far as I know the 
> suggested issues there 
> <https://sourceware.org/bugzilla/show_bug.cgi?id=16438> are all 
> theoretical.

Let's not get into the tv_nsec discussion today, that is not thankfully
not relevant for arm64 any more at this point. The system call ABI for
arm64/ilp32 is now the same as for any other 32-bit architecture using
the generic ABI, the question we're trying to solve here is only whether it
is ok for new 32-bit glibc ports to only offer a 64-bit off_t as the kernel
currently does (using __kernel_loff_t) or if we still need to support the
_FILE_OFFSET_BITS=32 case.

If I got you right, we can use 64-bit off_t now, so we just need someone
to figure out how to make that the default in glibc for new architectures
while keeping the existing 32-bit architectures unchanged.

	Arnd
