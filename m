From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 6 Oct 2015 21:51:22 +0100
Subject: [PATCH 3/3] hwrng: st: Use real-world device timings for timeout
In-Reply-To: <20151006193757.GY21513@n2100.arm.linux.org.uk>
References: <1444142640-14721-1-git-send-email-lee.jones@linaro.org>
 <1444142640-14721-3-git-send-email-lee.jones@linaro.org>
 <20151006193757.GY21513@n2100.arm.linux.org.uk>
Message-ID: <20151006205122.GF17172@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Oct 2015, Russell King - ARM Linux wrote:
> On Tue, Oct 06, 2015 at 03:44:00PM +0100, Lee Jones wrote:
> > Samples are documented to be available every 0.667us, so in theory
> > the 8 sample deep FIFO should take 5.336us to fill.  However, during
> > thorough testing, it became apparent that filling the FIFO actually
> > takes closer to 12us.
> 
> Is that measured?

I measured it using ktime.  Hopefully that was adequate.

> > +/*
> > + * Samples are documented to be available every 0.667us, so in theory
> > + * the 8 sample deep FIFO should take 5.336us to fill.  However, during
> > + * thorough testing, it became apparent that filling the FIFO actually
> > + * takes closer to 12us.
> > + */
> > +#define ST_RNG_FILL_FIFO_TIMEOUT	12
> 
> I hope you're not using such a precise figure with udelay().  udelay()
> is not guaranteed to give exactly (or even at least) the delay you
> request.  It's defined to give an approximate delay.
> 
> Many people have a problem understanding that, so I won't explain why
> it is that way, just accept that it is and move on... it's not going
> to magically get "fixed" because someone has just learnt about this. :)

Thanks for the info.  I did do testing, again using ktime, to make
sure and on our platform (is it platform specific?) I measured
udelay(1) to be ~1100ns.  After moving to a 12us timeout and reading
many MBs of randomness I am yet to receive any more timeouts.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
