From: oss@buserror.net (Scott Wood)
Date: Tue, 12 Apr 2016 00:54:18 -0500
Subject: [RFC PATCH 2/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-009971
In-Reply-To: <570B7486.3080204@arm.com>
References: <1460341353-15619-1-git-send-email-oss@buserror.net>
 <1460341353-15619-3-git-send-email-oss@buserror.net>
 <570B7486.3080204@arm.com>
Message-ID: <1460440458.32510.110.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-04-11 at 10:55 +0100, Marc Zyngier wrote:
> On 11/04/16 03:22, Scott Wood wrote:
> > @@ -52,6 +53,20 @@ extern bool arm_arch_timer_reread;
> >  	_val; \
> >  })
> >  
> > +#define ARCH_TIMER_TVAL_REWRITE(pv, val) do { \
> > +	u64 _cnt_old, _cnt_new; \
> > +	int _timeout = 200; \
> > +	do { \
> > +		asm volatile("mrs %0, cntvct_el0;" \
> > +			     "msr cnt" pv "_tval_el0, %2;" \
> > +			     "mrs %1, cntvct_el0" \
> > +			     : "=&r" (_cnt_old), "=r" (_cnt_new) \
> > +			     : "r" (val)); \
> > +		_timeout--; \
> > +	} while (_cnt_old != _cnt_new && _timeout); \
> > +	WARN_ON_ONCE(!_timeout); \
> > +} while (0)
> > +
> 
> Given how many times you've written that loop, I'm sure you can have a
> preprocessor macro that will do the right thing.

I did use a preprocessor macro.  Are you asking me to consolidate the read and
write macros?  That seems like it would create a mess that's worse than an
extra instance of a simple loop.

-Scott
