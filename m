From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Oct 2015 16:16:05 +0000
Subject: [PATCH] ARM: SWP emulation: Restore original *data when failed
In-Reply-To: <20151027154424.GG1689@arm.com>
References: <1444791077-26020-1-git-send-email-shengjiu.wang@freescale.com>
 <20151015082417.GX32532@n2100.arm.linux.org.uk>
 <20151015083629.GA32630@shlinux2>
 <20151015085700.GY32532@n2100.arm.linux.org.uk>
 <561F6F3B.6030607@arm.com> <20151015130247.GB29301@arm.com>
 <561FA948.5080505@arm.com> <5620ACB8.20908@arm.com>
 <20151016103729.GA6613@e104818-lin.cambridge.arm.com>
 <20151027154424.GG1689@arm.com>
Message-ID: <20151028161604.GI18966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 03:44:24PM +0000, Will Deacon wrote:
> On Fri, Oct 16, 2015 at 11:37:29AM +0100, Catalin Marinas wrote:
> > On Fri, Oct 16, 2015 at 08:52:24AM +0100, Vladimir Murzin wrote:
> > > > On 15/10/15 14:02, Will Deacon wrote:
> > > >> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> > > >> index bcee7abac68e..6039d1eb5912 100644
> > > >> --- a/arch/arm64/kernel/armv8_deprecated.c
> > > >> +++ b/arch/arm64/kernel/armv8_deprecated.c
> > > >> @@ -284,12 +284,12 @@ static void register_insn_emulation_sysctl(struct ctl_table *table)
> > > >>  	__asm__ __volatile__(					\
> > > >>  	ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,	\
> > > >>  		    CONFIG_ARM64_PAN)				\
> > > >> -	"	mov		%w2, %w1\n"			\
> > > >> -	"0:	ldxr"B"		%w1, [%3]\n"			\
> > > >> -	"1:	stxr"B"		%w0, %w2, [%3]\n"		\
> > > >> +	"0:	ldxr"B"		%w2, [%3]\n"			\
> > > >> +	"1:	stxr"B"		%w0, %w1, [%3]\n"		\
> > > >>  	"	cbz		%w0, 2f\n"			\
> > > >>  	"	mov		%w0, %w4\n"			\
> > > >>  	"2:\n"							\
> > > >> +	"	mov		%w1, %w2\n"			\
> > > >>  	"	.pushsection	 .fixup,\"ax\"\n"		\
> > > >>  	"	.align		2\n"				\
> > > >>  	"3:	mov		%w0, %w5\n"			\
> > > 
> > > On the second thought looks like we still update *data in case stxr
> > > fails (or I need more coffee).
> > 
> > I'm on the second cup and I see the same problem. Even if stxr fails, we
> > fall back through "mov %w1, %w2", so *data is always updated with the
> > loaded value. Maybe something like below on top of Will's patch:
> 
> Yeah, sorry, my original patch was an untested mess. I think we can avoid
> the "cc" clobber by adding a branch to the slow-path, as below.
> 
> Still needs testing, mind.

Right, it passes the simple test case I wrote (which fails under mainline).

Will
