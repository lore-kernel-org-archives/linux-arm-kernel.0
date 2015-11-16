From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 14:15:58 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <alpine.DEB.2.10.1511161230220.25844@digraph.polyomino.org.uk>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <5753873.3bKWvUrKmj@wuerfel>
 <alpine.DEB.2.10.1511161230220.25844@digraph.polyomino.org.uk>
Message-ID: <4164423.46Jfedud5Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 November 2015 12:34:55 Joseph Myers wrote:
> On Mon, 16 Nov 2015, Arnd Bergmann wrote:
> 
> > > It's not a matter of leaving anything out - these would simply use 64-bit 
> > > off_t (__off_t and __off64_t would be the same type) and the *64 versions 
> > > would be aliases, exactly the same as on 64-bit architectures.  (And 
> > > _FILE_OFFSET_BITS handling would also be exactly the same as on 64-bit 
> > > architectures.)  I see no reason for the set of off_t-related symbols that 
> > > exist, or which symbols are aliases of which others, to vary between pure 
> > > 64-bit systems and ILP32 ABIs (for 32-bit or 64-bit architectures) that 
> > > simply happen to have had 64-bit off_t from the start.
> > 
> > Ok, fair enough. So we just change the global __OFF_T_TYPE definition
> > in bits/typesizes.h and override it for all the existing 32-bit ports,
> > correct?
> 
> Well, it's sysdeps/unix/sysv/linux/generic/bits/typesizes.h that's 
> relevant - so if future generic architectures will use 64-bit off_t, I 
> suppose the existing file could be cloned for existing generic 
> architectures with 32-bit support. 

Ok, got it.

> And all the types involved in struct stat are affected (e.g. ino_t),
> not just off_t. 

ino_t seems to be the only other type in 'struct stat' that depends
on _FILE_OFFSET_BITS in glibc. On the kernel side, we don't care about
__kernel_ino_t any more, we just leave that defined as 'unsigned long'
while using a plain 'unsigned long long' for 'st_ino' in struct stat64
(and don't use __kernel_ino_t anywhere else either).

> And getting the aliases 
> right may involve disentangling the different meanings of wordsize-64 into 
> different sysdeps directories.  ("off_t is off64_t" and "stat is stat64" 
> are not the same thing.  See MIPS n64.)  And the design work needs to be 
> done on libc-alpha, not in a random discussion elsewhere.

Sure. For the moment, we have all the information we need for the kernel
side at least: we will keep using only 64-bit __kernel_loff_t on the
system call side in new architecture ports and let you figure out how
to work with that on the glibc side whenever the next 32-bit port arrives,
which I assume will be arm64-ilp32.

The 'struct stat' discussion will of course come back soon when we get to
the 64-bit time_t patches, or when we introduce the extended stat syscall,
whichever happens first.

Thanks a lot for your help!

	Arnd
