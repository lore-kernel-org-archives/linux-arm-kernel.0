From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Nov 2012 12:29:39 -0500 (EST)
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <50A0F390.7060800@gmail.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121112102354.GA2346@mudshark.cambridge.arm.com>
 <50A0F390.7060800@gmail.com>
Message-ID: <alpine.LFD.2.02.1211271220270.4576@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Nov 2012, Rob Herring wrote:
> On 11/12/2012 04:23 AM, Will Deacon wrote:
> > On Sun, Nov 11, 2012 at 03:20:40AM +0000, Rob Herring wrote:
> >> +static inline void set_my_cpu_offset(unsigned long off)
> >> +{
> >> +	asm volatile("mcr p15, 0, %0, c13, c0, 4	@ set TPIDRPRW" : : "r" (off) : "cc" );
> >> +}
> > 
> > You don't need the "cc" here.
> 
> You would think so, but the compiler drops this instruction if you
> don't. set_cr does the same thing.

If set_cr does it, that's because of historical reasons.  A long long 
time ago, you could use predicates inside inline assembly statements.  
The %? was needed to conditionally execute the included instructions in 
case gcc had decided not to branch over your code.  So you had to write:

	asm volatile("mcr%? p15, 0, %0, c13, c0, 4" : : "r" (off));

Or, if you didn't want to bother with %?, you had to clobber the 
condition code to force gcc to emit a branch over the inline assembly 
block when it shouldn't have been executed.

This subtlety was the source of many bugs as most people didn't use %? 
properly, so CC is always assumed to be clobbered by inline assembly 
now.


Nicolas
