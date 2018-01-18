From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Thu, 18 Jan 2018 17:17:45 +0100
Subject: [PATCH v3 02/12] clk: sunxi-ng: Change formula for NKMP PLLs
In-Reply-To: <20180118105841.73rwj3he2exd7pno@flea.lan>
References: <20180117201421.25954-1-jernej.skrabec@siol.net>
 <20180117201421.25954-3-jernej.skrabec@siol.net>
 <20180118105841.73rwj3he2exd7pno@flea.lan>
Message-ID: <4724479.MCcHYbe7Bl@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne ?etrtek, 18. januar 2018 ob 11:58:41 CET je Maxime Ripard napisal(a):
> Hi,
> 
> On Wed, Jan 17, 2018 at 09:14:11PM +0100, Jernej Skrabec wrote:
> > This commit changes formula from this:
> > 
> > Freq = (parent_freq * N * K) / (M * P)
> > 
> > to this:
> > 
> > Freq = (parent_freq / M) * N * K / P
> > 
> > This improves situation when N is in the range 1-255. PLL parent clock
> > is almost always 24 MHz, which means that for N >= 180 original formula
> > overflows and result becomes useless. Situation can be improved if M is
> > used as predivider as it can be seen in the second formula. That way at
> > least M > 1 is considered, but it still leaves small gap for wrong result
> > when M = 1 and N >= 180.
> > 
> > Using M as predivider shouldn't cause any issue, because it is in range
> > 1-4 at most, so there is no or only minimal rounding error.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> I'd really prefer to stick to the formula documented and that we've
> used so far. NKMP clocks are most notably used for the CPU PLLs and
> I've debugged way too many cpufreq bugs already :)
> 
> What about using long long types for the parent * n * k result?

Yes, using long long is the best possible solution and covers all cases 
whereas this patch does not.

I thought that do_div() would cause a lot of overhead, but I noticed that it's 
not big if both numbers fit in 32 bit, which in our case is true most of the 
time.

I will make a helper function for calculating rate, since using long long 
needs more than one line of code.

Best regards,
Jernej
