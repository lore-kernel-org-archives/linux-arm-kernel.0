From: vapier@gentoo.org (Mike Frysinger)
Date: Thu, 9 Dec 2010 16:14:24 -0500
Subject: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
In-Reply-To: <alpine.LFD.2.00.1012091313270.10437@xanadu.home>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
	<201012091232.31577.vapier@gentoo.org>
	<alpine.LFD.2.00.1012091313270.10437@xanadu.home>
Message-ID: <201012091614.26353.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 09, 2010 13:23:55 Nicolas Pitre wrote:
> On Thu, 9 Dec 2010, Mike Frysinger wrote:
> > On Thursday, December 09, 2010 11:45:30 Carmelo AMOROSO wrote:
> > > On 12/9/2010 5:07 PM, Mike Frysinger wrote:
> > > > On Thursday, December 09, 2010 10:56:26 Carmelo AMOROSO wrote:
> > > >> I agree with you that the Kconfig and Makefile changes are not arch
> > > >> specific, so these changes can be moved to a common code (even if I
> > > >> don't know if other archs do support SSP).
> > > >> In the current kernel, only x86 and ARM added this support, so I'm
> > > >> wondering if, moving SSP to the common Makefile, it needs to depend
> > > >> on x86, ARM, SH being configured ?
> > > > 
> > > > i'm not sure it does.  ssp is designed to be arch independent, so
> > > > really you only need a new enough gcc version.  which means i dont
> > > > think it needs to depend on any arch code and you can simply add to
> > > > the Makefile a compiler check.
> > > 
> > > agreed, but if arch wants to implement the per-task canary feature,
> > > some change into arch specific code is required.
> > 
> > yes, but that doesnt mean the common symbol definition needs to be
> > duplicated
> 
> We are talking about only one symbol here, which symbol is also
> dependent on the way this feature is implemented in gcc (e.g. on x86 the
> implementation is totally different and this symbol isn't used).  So I
> don't see a huge gain by defining this symbol in generic code, given the
> number of lines involved in the addition of a new file, just for a
> single symbol.

you're right, a few targets dont have any symbol at all and do it through TLS.  
although that is more of an exception than a rule, so i'd still like to see 
the symbol in a common file.  perhaps reverse selected by the arch Kconfig 
like "select ARCH_WANT_STACK_CHK_GUARD".  or perhaps invert the logic so only 
the funky arches get punished.

i might highlight that the way gcc/i386 manages its canary is dependent upon 
the C library it was compiled against, but i dont want to poke that nest as 
i'm not interested in making it work on that arch ;).

> > i think you only need to test that gcc accepts -fstack-protector
> > and then assume the rest ... i dont think you need to come up with random
> > pieces of code and cajole the symbol references out of gcc.
> 
> Would you care to elaborate?

i simply mean that any makefile code checking for support need only look for 
gcc supporting -fstack-protector.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101209/057b6444/attachment.sig>
