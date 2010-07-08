From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Jul 2010 10:43:31 +0100
Subject: [PATCH 2/4] ARM: atomic ops: reduce critical region in
	atomic64_cmpxchg
In-Reply-To: <alpine.LFD.2.00.1007080045450.6020@xanadu.home>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
	<1277906688-12065-2-git-send-email-will.deacon@arm.com>
	<1277906688-12065-3-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1007080045450.6020@xanadu.home>
Message-ID: <004c01cb1e82$070aa130$151fe390$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> > diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> > index e9e56c0..4f0f282 100644
> > --- a/arch/arm/include/asm/atomic.h
> > +++ b/arch/arm/include/asm/atomic.h
> > @@ -358,8 +358,8 @@ static inline u64 atomic64_cmpxchg(atomic64_t *ptr, u64 old, u64 new)
> >
> >  	do {
> >  		__asm__ __volatile__("@ atomic64_cmpxchg\n"
> > -		"ldrexd		%1, %H1, [%2]\n"
> >  		"mov		%0, #0\n"
> > +		"ldrexd		%1, %H1, [%2]\n"
> >  		"teq		%1, %3\n"
> >  		"teqeq		%H1, %H3\n"
> >  		"strexdeq	%0, %4, %H4, [%2]"
> 
> I'm not sure you gain anything here.  The ldrexd probably requires at
> least one result delay cycle which is filled by the  mov instruction.
> By moving the mov insn before the ldrexd you are probably making the
> whole sequence one cycle longer.

You're right. In fact, thinking about it, this patch is largely
superficial because if the core can do exclusive load/stores then
the mov will be issued down a separate pipeline anyway.

I'll drop this one from the patch series and submit the other three.

Thanks,

Will
