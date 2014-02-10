From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 13:58:45 +0000
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <20140207170903.GT5976@mudshark.cambridge.arm.com>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140207170903.GT5976@mudshark.cambridge.arm.com>
Message-ID: <20140210135845.GV26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 05:09:03PM +0000, Will Deacon wrote:
> On Fri, Feb 07, 2014 at 04:19:15PM +0000, Fabrice GASNIER wrote:
> > +#define local_abt_enable()					\
> > +	({							\
> > +		unsigned long temp;				\
> > +	__asm__ __volatile__(					\
> > +	"mrs	%0, cpsr		@ sta\n"		\
> > +"	bic	%0, %0, %1\n"					\
> > +"	msr	cpsr_c, %0"					\
> > +	: "=r" (temp)						\
> > +	: "r" (PSR_A_BIT)					\
> 
> Can you use "i" instead of a register for this constant?

As the PSR A bit isn't in bits 7-0, cpsr_c isn't what's required here.
It needs something different... that's why my previous patch for you
didn't work.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
