From: joseph@codesourcery.com (Joseph Myers)
Date: Mon, 16 Nov 2015 12:34:55 +0000
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <5753873.3bKWvUrKmj@wuerfel>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <4389139.prTLIyjV9Z@wuerfel>
 <alpine.DEB.2.10.1511161159290.25844@digraph.polyomino.org.uk>
 <5753873.3bKWvUrKmj@wuerfel>
Message-ID: <alpine.DEB.2.10.1511161230220.25844@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Nov 2015, Arnd Bergmann wrote:

> > It's not a matter of leaving anything out - these would simply use 64-bit 
> > off_t (__off_t and __off64_t would be the same type) and the *64 versions 
> > would be aliases, exactly the same as on 64-bit architectures.  (And 
> > _FILE_OFFSET_BITS handling would also be exactly the same as on 64-bit 
> > architectures.)  I see no reason for the set of off_t-related symbols that 
> > exist, or which symbols are aliases of which others, to vary between pure 
> > 64-bit systems and ILP32 ABIs (for 32-bit or 64-bit architectures) that 
> > simply happen to have had 64-bit off_t from the start.
> 
> Ok, fair enough. So we just change the global __OFF_T_TYPE definition
> in bits/typesizes.h and override it for all the existing 32-bit ports,
> correct?

Well, it's sysdeps/unix/sysv/linux/generic/bits/typesizes.h that's 
relevant - so if future generic architectures will use 64-bit off_t, I 
suppose the existing file could be cloned for existing generic 
architectures with 32-bit support.  And all the types involved in struct 
stat are affected (e.g. ino_t), not just off_t.  And getting the aliases 
right may involve disentangling the different meanings of wordsize-64 into 
different sysdeps directories.  ("off_t is off64_t" and "stat is stat64" 
are not the same thing.  See MIPS n64.)  And the design work needs to be 
done on libc-alpha, not in a random discussion elsewhere.

-- 
Joseph S. Myers
joseph at codesourcery.com
