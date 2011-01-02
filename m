From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 2 Jan 2011 10:00:19 +0100
Subject: [PATCH 1/3] hvc_dcc: Fix bad code generation by marking
	assembly volatile
In-Reply-To: <alpine.LFD.2.00.1012201638150.10437@xanadu.home>
References: <1292649385-28771-1-git-send-email-sboyd@codeaurora.org>
	<1292875718-7980-1-git-send-email-sboyd@codeaurora.org>
	<1292875718-7980-2-git-send-email-sboyd@codeaurora.org>
	<alpine.LFD.2.00.1012201638150.10437@xanadu.home>
Message-ID: <20110102090019.GC32469@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > diff --git a/drivers/char/hvc_dcc.c b/drivers/char/hvc_dcc.c
> > index 6470f63..155ec10 100644
> > --- a/drivers/char/hvc_dcc.c
> > +++ b/drivers/char/hvc_dcc.c
> > @@ -33,8 +33,7 @@
> >  static inline u32 __dcc_getstatus(void)
> >  {
> >  	u32 __ret;
> > -
> > -	asm("mrc p14, 0, %0, c0, c1, 0	@ read comms ctrl reg"
> > +	asm volatile("mrc p14, 0, %0, c0, c1, 0	@ read comms ctrl reg"
> >  		: "=r" (__ret) : : "cc");
> >  
> >  	return __ret;

Is volatile needed here? If __dcc_getstatus() return value is
discarded, we want assembly discarded, right?


> > @@ -58,7 +57,7 @@ static inline char __dcc_getchar(void)
> >  {
> >  	char __c;
> >  
> > -	asm("mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
> > +	asm volatile("mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
> >  		: "=r" (__c));
> >  
> >  	return __c;

Same here?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
