From: emil@limesaudio.com (Emil Lundmark)
Date: Fri, 7 Oct 2016 15:55:10 +0200
Subject: [PATCH 2/2] ARM: imx: improve precision of AV PLL to 1 Hz
In-Reply-To: <20161007094828.3f967c93@ipc1.ka-ro>
References: <1475752331-19525-1-git-send-email-emil@limesaudio.com>
 <1475752331-19525-2-git-send-email-emil@limesaudio.com>
 <20161007094828.3f967c93@ipc1.ka-ro>
Message-ID: <20161007135509.GA17556@lime>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 09:48:28AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> On Thu,  6 Oct 2016 13:12:11 +0200 Emil Lundmark wrote:
> > The audio and video PLLs are designed to have a precision of 1 Hz if some
> > conditions are met. The current implementation only allows a precision that
> > depends on the rate of the parent clock. E.g., if the parent clock is 24
> > MHz, the precision will be 24 Hz; or more generally the precision will be
> > 
> >     p / 10^6 Hz
> > 
> > where p is the parent clock rate. This comes down to how the register
> > values for the PLL's fractional loop divider is chosen.
> > 
> > The clock rate calculation for the PLL is
> > 
> >     PLL output frequency = Fref * (DIV_SELECT + NUM / DENOM)
> > 
> > or with a shorter notation
> > 
> >     r = p * (d + a / b)
> > 
> > In addition to all variables being integers, we also have the following
> > conditions:
> > 
> >     27 <= d <= 54
> > 
> >     0 <= a <= 2^30-1
> >
> Wrong. 'a' is a _signed_ number (see below)!
> So this should be:

Correct, good catch! It is confusing that the denominator is defined as
'u32 mfn', I think it should be changed to 's32 mfn' instead.

> -2^29 <= a < 2^29
> 
> >     0 <  b <= 2^30-1
> >     a < b
> > 
> > Here, d, a and b are register values for the fractional loop divider. We
> > want to chose d, a and b such that f(p, r) = p, i.e. f is our round_rate
> > function. Currently, d and b are chosen as
> > 
> >     d = r / p
> >     b = 10^6
> > 
> > hence we get the poor precision. And a is defined in terms of r, d, p and
> > b:
> > 
> >     a = (r - d * p) * b / p
> > 
> > I propose that if p <= 2^30-1 (i.e., the max value for b), we chose b as
> > 
> >     b = p
> > 
> According to the Reference Manual the "Absolute value should be less
> than denominator"
> |18.7.9 Numerator of Audio PLL Fractional Loop Divider Register
> |           (CCM_ANALOG_PLL_AUDIO_NUM)
> |This register contains the numerator (A) of Audio PLL fractional loop divider.(Signed
> |number), absolute value should be less than denominator
> |Absolute value should be less than denominator
> 

Yes, this changes everything. Lets revise my argument. We have the
following:

    |a| < b
    d = r / p
    a = (r - d * p) * b / p

If b = p, the expressions above still holds. Proof:

    |a| < b

    |(r - d * p) * b / p| < b

    |r - d * p| < p

Which have two solutions, one of them is when p < 0, so we can skip that
one. The other is when p > 0 and

    p * (d - 1) < r < p * (d + 1)

Substitute d = r / p

    (r - p) < r < (r + p)  <=> p > 0

So, as long as p > 0, we can chose b = p.

However, we still have the constraint that b <= 2^30-1, so p <= 2^30-1.
Which means that my proposed patch actually works, only my initial
reasoning was wrong.

For even more nitpicking, would it not be better to chose d = round(a / b)?
Now, we essentially have d = floor(a / b) because of the integer division.
So, with the current choice for d, would we not loose precision if
p > 2^29-1?

The question is, should we always chose b = p and ignore the precision loss
if p > 2^30-1 (or p > 2^29-1)?

-- 
Emil Lundmark
