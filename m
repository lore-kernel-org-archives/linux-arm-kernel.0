From: joseph@codesourcery.com (Joseph S. Myers)
Date: Wed, 2 Feb 2011 17:39:32 +0000 (UTC)
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <AANLkTin6qEeN7XZuwePNWqS8i_aDY586V+sOqgD5pPQA@mail.gmail.com>
References: <201102021700.20683.arnd@arndb.de>
	<AANLkTin6qEeN7XZuwePNWqS8i_aDY586V+sOqgD5pPQA@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1102021728350.18796@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Feb 2011, Richard Guenther wrote:

> The pointer conversions already invoke undefined behavior as specified by the
> C standard (6.3.2.3/7).

I would say: the conversions are undefined if the pointer is 
insufficiently aligned for any of the pointer types involved (source, 
destination or intermediate), where the appropriate alignment for a packed 
type is 1.  Thus, the conversion from packed to non-packed is OK iff the 
pointer target is sufficiently aligned for the non-packed type.

In general from a sequence of casts the compiler is permitted to deduce 
that the pointer is sufficiently aligned for whatever type in the sequence 
has the greatest alignment requirement (the middle-end may not have that 
information at present, but the front end could insert some form of 
alignment assertion if useful for optimization).  *But* that is what is 
permitted in standards terms; it is not necessarily safe in practice.  In 
particular, on non-strict-alignment targets such as x86 people do in 
practice assume that unaligned accesses are OK at the C level, not just 
the assembly level (glibc does so, for example), so it might be a bad idea 
to assume alignment in a way that would cause that to break.

-- 
Joseph S. Myers
joseph at codesourcery.com
