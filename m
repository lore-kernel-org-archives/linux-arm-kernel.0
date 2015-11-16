From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 13:12:02 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <alpine.DEB.2.10.1511161159290.25844@digraph.polyomino.org.uk>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <4389139.prTLIyjV9Z@wuerfel>
 <alpine.DEB.2.10.1511161159290.25844@digraph.polyomino.org.uk>
Message-ID: <5753873.3bKWvUrKmj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 November 2015 12:03:09 Joseph Myers wrote:
> On Mon, 16 Nov 2015, Arnd Bergmann wrote:
> 
> > There are two separate aspects here:
> > 
> > a) leave out the support for all __off_t based syscalls (__ftruncate,
> >    __lseek, __lxstat, __pread, __preadv, __pwrite, __pwritev, __truncate,
> >    __xstat) as they are no longer needed, and change the handling of
> >    _FILE_OFFSET_BITS so that we default to 64 and error out for anything
> >    else.
> >    This needs to be done for all new 32-bit architectures if you think we
> >    should use a 64-bit off_t from now on, it's not arm64 specific.
> 
> It's not a matter of leaving anything out - these would simply use 64-bit 
> off_t (__off_t and __off64_t would be the same type) and the *64 versions 
> would be aliases, exactly the same as on 64-bit architectures.  (And 
> _FILE_OFFSET_BITS handling would also be exactly the same as on 64-bit 
> architectures.)  I see no reason for the set of off_t-related symbols that 
> exist, or which symbols are aliases of which others, to vary between pure 
> 64-bit systems and ILP32 ABIs (for 32-bit or 64-bit architectures) that 
> simply happen to have had 64-bit off_t from the start.

Ok, fair enough. So we just change the global __OFF_T_TYPE definition
in bits/typesizes.h and override it for all the existing 32-bit ports,
correct?

	Arnd
