From: joseph@codesourcery.com (Joseph Myers)
Date: Tue, 29 Mar 2016 21:00:56 +0000
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <3398301.sy99ksJOyc@wuerfel>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <3467083.D7LuvS9l35@wuerfel>
 <alpine.DEB.2.10.1603292010080.15654@digraph.polyomino.org.uk>
 <3398301.sy99ksJOyc@wuerfel>
Message-ID: <alpine.DEB.2.10.1603292051150.15654@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Mar 2016, Arnd Bergmann wrote:

> > I think so (along with using wordsize-64 sysdeps directories as far as 
> > possible, like x32 does).  But design questions for a glibc port really 
> > belong on libc-alpha to get any sort of community consensus.
> 
> I thought the wordsize-64 stuff was for the x86 mode where they
> define __kernel_long_t as 64-bit. We don't really want to do that in
> the kernel for new 32-bit architectures, that would make the kernel
> ABI different from all the existing architectures.

In general the wordsize-64 directories cover various relations of the form 
"function X is an alias for function Y", which derive from "type X is 
ABI-compatible with type Y".  (Unfortunately, the precise set isn't 
well-defined, resulting in problems for cases that want a subset of those 
relations - e.g. MIPS n64 where struct stat and struct stat64 are 
different, and so sysdeps/unix/sysv/linux/wordsize-64 isn't used.)

The person doing the port will need to do a detailed review of the exact 
effects of the wordsize-64 directories in current glibc, and which of 
those effects are appropriate for this port, to determine what is 
appropriate, and to include that analysis with the port submission.

Many of the relations relate to things controlled by _FILE_OFFSET_BITS=64 
- if _FILE_OFFSET_BITS=64 does not affect the ABI of off_t, struct stat, 
etc., then many of the aliases are correct.  Some relations may relate to 
other things such as long and long long being ABI compatible - where an 
alias in the correct direction can be OK for long arguments (not returns) 
if a long argument is always sign-extended to long long when passed to a 
function, for example.

-- 
Joseph S. Myers
joseph at codesourcery.com
