From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 21:30:29 +0200
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <alpine.DEB.2.10.1603291551420.20115@digraph.polyomino.org.uk>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <3298847.t7vI4YM3gJ@wuerfel>
 <alpine.DEB.2.10.1603291551420.20115@digraph.polyomino.org.uk>
Message-ID: <3467083.D7LuvS9l35@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 15:54:52 Joseph Myers wrote:
> On Tue, 29 Mar 2016, Arnd Bergmann wrote:
> 
> > In glibc, I think we need to define fewer entry points, not more.
> > Instead of having both lseek and lseek64, only one of them should
> > be provided, and that should always take a 64-bit offset, calling
> > into the kernel with the _llseek syscall entry.
> 
> lseek64 is part of the public API, on all platforms.  It should be aliased 
> to lseek where possible.

Right, makes sense.

> Strictly, it would be possible to provide it in the API without it being 
> part of the ABI, by arranging the headers so that calls to lseek64 result 
> in objects with a reference to lseek (because it uses the off64_t typedef, 
> it's not valid to declare it yourself rather than including a header that 
> declares it).  I don't think it would be a good idea for a new 
> sub-architecture port to try introducing such a difference from all other 
> ports, however.

How do we do it then? Should we just define __USE_FILE_OFFSET64
unconditionally for all new 32-bit architectures and leave the
code dealing with 32-bit off_t/ino_t in place but unreachable, to
minimize the differences?

Or should all the obsolete types be defined the same way as their
replacements so we have 64-bit __OFF_T_TYPE/__INO_T_TYPE
and use the same binary implementation regardless of FILE_OFFSET_BITS?

	Arnd
