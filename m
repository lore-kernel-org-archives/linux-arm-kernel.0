From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 09 Jan 2011 22:55:04 -0500 (EST)
Subject: [PATCH] ARM: sched_clock: improve mult/shift accuracy with high
	frequency clocks
In-Reply-To: <20110109105200.GC31708@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1012202014500.10437@xanadu.home>
	<20101221105149.GO28157@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1012291703300.10437@xanadu.home>
	<20110103003718.GF17727@n2100.arm.linux.org.uk>
	<1294084049.2571.30.camel@work-vm>
	<20110109105200.GC31708@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101092224320.3455@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 9 Jan 2011, Russell King - ARM Linux wrote:

> Now, a Caesium fountain frequency standard may have an accuracy of
> approx. 1 part in 10^-14.  Rubidium frequency standards are around
> 1 part in 10^-12.
> 
> A standard crystal oscillator is around 1 part in 10^-6 to 10^-7.  If
> you really care about accuracy, you might use an ovened crystal
> oscillator (OXCO) which'll get you to around 1 part in 10^-7..10^-9,
> still well short of the calculation inaccuracy.  You wouldn't use an
> OXCO in a battery operated device though due to power consumption.
> 
> We're generally don't have a Caesium or Rubidium frequency standard, not
> even a OXCO providing the clock source for the counter, so the accuracy
> of the counters clock is much more significant than the conversion
> factors by a factor of about one million.
> 
> What I'm saying is that there becomes a time where it really doesn't
> matter if the conversion isn't accurate, provided it's accurate enough,
> and it would appear to be accurate enough.

It sure is, thanks for the demonstration.

However this begs the question about the actual meaning of the value for 
the minsec argument to clocks_calc_mult_shift() (which IMHO should be 
renamed to maxsec instead).  In the ARM sched_clock code the value of 60 
is totally arbitrary and may happen to be good enough, but a value of 0 
would also be totally arbitrary and also work fine.  But at least a 0 
value wouldn't imply any false meaning.  And in the case of the 
sched_clock support code, we know the value we need: 90% 
of the actual hardware clock period, so using that would at least make 
the code self consistent even if in practice this doesn't change the 
final results.


Nicolas
