From: rabin@rab.in (Rabin Vincent)
Date: Wed, 24 Feb 2010 01:12:53 +0530
Subject: [PATCH 02/10] ARM: ftrace: document mcount formats
In-Reply-To: <20100222192009.GA13527@pengutronix.de>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-3-git-send-email-rabin@rab.in>
	<20100213203748.GC16528@pengutronix.de>
	<20100222180624.GA4061@debian>
	<20100222192009.GA13527@pengutronix.de>
Message-ID: <20100223194253.GB6325@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2010 at 08:20:09PM +0100, Uwe Kleine-K?nig wrote:
> On Mon, Feb 22, 2010 at 11:36:24PM +0530, Rabin Vincent wrote:
> > On Sat, Feb 13, 2010 at 09:37:48PM +0100, Uwe Kleine-K?nig wrote:
> > > On Sun, Feb 14, 2010 at 01:18:30AM +0530, Rabin Vincent wrote:
> > > > + * With both the mcount types, we need to restore the original lr before
> > > > + * returning.  In the __gnu_mcount_nc, version we're allowed to clobber ip.
> > > > + * No other registers should be clobbered.
> > > > + */
> > > Very nice.
> > > 
> > > Maybe make the last two sentences:
> > > 
> > > In the __gnu_mcount_nc case the ip register is clobbered which is OK as
> > > the calling convention for ARM allow clobbering this value for
> > > subroutines and it doesn't contain parameters.
> > 
> > Won't quoting calling conventions here be misleading?  The mcounts don't
> > following normal convention for the other bits (we can't clobber even
> > the registers that are normally caller-saved, we need to restore lr,
> > etc.)
> actually mcount is a function in the middle of a function call.  So it
> must be transparent for both the caller and the callee.  As the called
> function needs to know the return address, mcount must not clobber it.
> And as ip is don't care and can be clobbered mcount can use it as it
> likes.

OK.  How about this for the last paragraph:

 mcount can be thought of as a function called in the middle of a
 subroutine call.  As such, it needs to be transparent for both the
 caller and the callee: the original lr needs to be restored when
 leaving mcount, and no registers should be clobbered.  (In the
 __gnu_mcount_nc implementation, we clobber the ip register.  This
 is OK because the ARM calling convention allows it to be clobbered
 in subroutines and doesn't use it to hold parameters.)

Rabin
