From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 22:24 +0200
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <alpine.DEB.2.10.1603292010080.15654@digraph.polyomino.org.uk>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <3467083.D7LuvS9l35@wuerfel>
 <alpine.DEB.2.10.1603292010080.15654@digraph.polyomino.org.uk>
Message-ID: <3398301.sy99ksJOyc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 20:15:10 Joseph Myers wrote:
> On Tue, 29 Mar 2016, Arnd Bergmann wrote:
> 
> > How do we do it then? Should we just define __USE_FILE_OFFSET64
> > unconditionally for all new 32-bit architectures and leave the
> > code dealing with 32-bit off_t/ino_t in place but unreachable, to
> > minimize the differences?
> 
> Defining __USE_FILE_OFFSET64 unconditionally would prevent glibc from 
> building (see: how the patches a while back prototyping changing the 
> default had to disable the change when glibc itself is built).  A change 
> in the default, though desired (someone needs to pick up those patches 
> together with the analysis done of possible impact on distributions), 
> should not be tied to a new port, and would need to be discussed 
> thoroughly on libc-alpha.

Ok

> > Or should all the obsolete types be defined the same way as their
> > replacements so we have 64-bit __OFF_T_TYPE/__INO_T_TYPE
> > and use the same binary implementation regardless of FILE_OFFSET_BITS?
> 
> I think so (along with using wordsize-64 sysdeps directories as far as 
> possible, like x32 does).  But design questions for a glibc port really 
> belong on libc-alpha to get any sort of community consensus.

I thought the wordsize-64 stuff was for the x86 mode where they
define __kernel_long_t as 64-bit. We don't really want to do that in
the kernel for new 32-bit architectures, that would make the kernel
ABI different from all the existing architectures.

The kernel ABI for ilp32 follows the usual wordsize-32 definitions
to make it easy for glibc while avoiding the problems that came from
redefining __kernel_long_t.

	Arnd
