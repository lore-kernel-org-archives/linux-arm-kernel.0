From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jan 2011 10:51:20 +0000
Subject: [PATCH] ARM: sched_clock: improve mult/shift accuracy with
	high frequency clocks
In-Reply-To: <alpine.LFD.2.00.1101092224320.3455@xanadu.home>
References: <alpine.LFD.2.00.1012202014500.10437@xanadu.home>
	<20101221105149.GO28157@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1012291703300.10437@xanadu.home>
	<20110103003718.GF17727@n2100.arm.linux.org.uk>
	<1294084049.2571.30.camel@work-vm>
	<20110109105200.GC31708@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101092224320.3455@xanadu.home>
Message-ID: <20110110105120.GA12552@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 09, 2011 at 10:55:04PM -0500, Nicolas Pitre wrote:
> However this begs the question about the actual meaning of the value for 
> the minsec argument to clocks_calc_mult_shift() (which IMHO should be 
> renamed to maxsec instead).  In the ARM sched_clock code the value of 60 
> is totally arbitrary and may happen to be good enough, but a value of 0 
> would also be totally arbitrary and also work fine.  But at least a 0 
> value wouldn't imply any false meaning.  And in the case of the 
> sched_clock support code, we know the value we need: 90% 
> of the actual hardware clock period, so using that would at least make 
> the code self consistent even if in practice this doesn't change the 
> final results.

Actually, minsec is utterly wrong.

minsec is there to clamp the conversion from the N-bit cyclecounter to
a 64-bit nanosecond value to ensure that there isn't a 64-bit overflow
within the 'minsec' period.

With a 32-bit or smaller cyclecounter, as 32-bit x 32-bit can never
overflow a 64-bit destination, so if anything zero should be passed in
this case.

If larger than 32-bit, then a value may be needed to clamp it.  However,
	wrap = (1 << bits) / freq
	ns = (mult * cnt) >> shift
	mult = (NSEC_PER_SEC (a 30-bit number) << 32) / freq (32-bit max)

A 33-bit counter would need a 32-bit multiplier to wrap-around within
the 64-bit maths.  The frequency which produces a 32-bit multiplier is
2GHz, which gives a wrap period of 4.29s.  Above this frequency, the
64-bit math can't overflow as the multiplier becomes smaller.  Below
this frequency, counter wrap periods get longer and the multiplier
becomes larger up to 32 bits - and this is where the 64-bit math problem
starts.

A 33-bit counter with a 1.8GHz clock gives a multiplier of 2386092942
(0x8E38E38E).  Such a multiplier wraps 64-bit maths@7730941133 and
it takes the counter 4.29s to get there.

1 << bits / freq gives a counter wrap period of 4.77s, which is
over-estimating the 64-bit math wrap.

I question whether using 1 << bits / freq is valid for minsec - does
there exist a frequency where an integer minsec is larger than required.
Luckily the maths is safe as it'll produce a smaller mult.

However, I question whether using 1 << bits / freq is any arbitary than
a 60 or 0 value - it's certainly mathematically the wrong wrap period.

So, in summary I'd suggest using a value of 0 for sched_clock() if we're
going to change it - we don't accept more than 32-bits from the counter
at present, so the whole minsec thing really isn't needed to prevent
wrap.  If we ever allow more than 32-bits then yes it will.
