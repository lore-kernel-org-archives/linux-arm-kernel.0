From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 9 Dec 2010 13:23:55 -0500 (EST)
Subject: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
In-Reply-To: <201012091232.31577.vapier@gentoo.org>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
	<201012091107.51911.vapier@gentoo.org> <4D0107AA.2020909@st.com>
	<201012091232.31577.vapier@gentoo.org>
Message-ID: <alpine.LFD.2.00.1012091313270.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Dec 2010, Mike Frysinger wrote:

> On Thursday, December 09, 2010 11:45:30 Carmelo AMOROSO wrote:
> > On 12/9/2010 5:07 PM, Mike Frysinger wrote:
> > > On Thursday, December 09, 2010 10:56:26 Carmelo AMOROSO wrote:
> > >> I agree with you that the Kconfig and Makefile changes are not arch
> > >> specific, so these changes can be moved to a common code (even if I
> > >> don't know if other archs do support SSP).
> > >> In the current kernel, only x86 and ARM added this support, so I'm
> > >> wondering if, moving SSP to the common Makefile, it needs to depend on
> > >> x86, ARM, SH being configured ?
> > > 
> > > i'm not sure it does.  ssp is designed to be arch independent, so really
> > > you only need a new enough gcc version.  which means i dont think it
> > > needs to depend on any arch code and you can simply add to the Makefile
> > > a compiler check.
> > 
> > agreed, but if arch wants to implement the per-task canary feature, some
> > change into arch specific code is required.
> 
> yes, but that doesnt mean the common symbol definition needs to be duplicated

We are talking about only one symbol here, which symbol is also 
dependent on the way this feature is implemented in gcc (e.g. on x86 the 
implementation is totally different and this symbol isn't used).  So I 
don't see a huge gain by defining this symbol in generic code, given the 
number of lines involved in the addition of a new file, just for a 
single symbol.

> gcc will reference both __stack_chk_fail and __stack_chk_guard depending on 
> the code. 

Not exactly.  gcc will reference __stack_chk_fail which incidentally is 
already defined in kernel/panic.c for everyone to use.  But 
__stack_chk_guard is not universally used on all architectures.

> i think you only need to test that gcc accepts -fstack-protector 
> and then assume the rest ... i dont think you need to come up with random 
> pieces of code and cajole the symbol references out of gcc.

Would you care to elaborate?

> along those lines, i see your patch adding __stack_chk_guard, but where is 
> __stack_chk_fail ?

See above.


Nicolas
