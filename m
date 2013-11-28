From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 28 Nov 2013 09:29:31 +0100
Subject: [PATCH v2 0/2] clk: add clk accuracy support
In-Reply-To: <20131127231125.7995.qmail@science.horizon.com>
References: <20131127231125.7995.qmail@science.horizon.com>
Message-ID: <5296FEEB.7070205@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 28/11/2013 00:11, colin at horizon.com wrote:
> Um, do you have a definition somewhere (like in comments) of the definition
> of the accuracy you're using?  So multiple people can add consistent values?
>
> Is this the standard deviation (67% confidence), 2 standard deviations
> (95%), 3 (99%), or something else?
>
> What averaging time is this computed over?  Usually clock stability (which
> I recognize is not accuracy) is expressed using the Allan deviation,
>
> http://tf.nist.gov/general/glossary.htm#allandeviation
>
> This is because real clocks have unbounded asymptotic error.  Over long
> time intervals, have a random frequency walk characteristic, where the
> frequency error after time T is proportional to sqrt(T).
>
> So an oscillator which is stable to 1ppb over a T second interval will be
> stable to 2ppb over a 4T second interval, 3ppb over a 9T second interval,
> and so on.
>
> Since accuracy is limited by stability, and there's no upper bound on
> instability, there's actually no upper bound on inaccuracy, either.
>
> (Admittedly, your typical crystal oscillators have their stability
> limited by environmental instability, particularly temperature, which
> dwarfs the frequency flicker noise limit.)
>
>
> On the flip side, some systems are synchronized to UTC by various means.
> This means (if we either neglect UTC's far sub-ppb instability, or just
> define it as "perfect") that the inaccuracy over a long enough averaging
> interval is zero.
>
> But if it only synchronizes once a day, there can be significant
> inaccuracy between synchronization.  Should the accuracy specification
> reflect that shorter-term instability?
>
>
> Finally, you can't specify *too* short an interval, because clocks also
> have increasing error over small time intervals.  Below 10 seconds or
> so, white noise cycle-to-cycle jitter dominates, and the fewer cycles
> you average over, the larger it appears to be.
>
>
> A clear definition would help people understand what numbers to put in.

Thanks for these informations, it helped me understand the different sources
of inaccuracies of a crystal.
As I said earlier, I'm not an expert in this area, and all your comments and
feedbacks are welcome.
BTW does this apply to other clk generators (RC oscillators, PLLs, ...), 
or is this only
applicable to crystal oscillators ?

Regarding the exact definition of accuracy, I guess in case of crystals 
this has more
to do with stability.

I found something called "Total stability" in several datasheet
(e.g. http://www.silabs.com/Support%20Documents/TechnicalDocs/si510-11.pdf).
Is this something applicable to our case ?

Keep in mind that the primary goal of the clk accuracy retrieval is to 
give a clock
user a way to choose the most accurate clock among several available clocks.
This means we don't need the value to be extremely precise, but at least 
(as you
stated) these values should represent the same things.

Best Regards,

Boris
