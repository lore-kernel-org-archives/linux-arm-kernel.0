From: cl@linux.com (Christoph Lameter)
Date: Thu, 23 Sep 2010 14:17:36 -0500 (CDT)
Subject: [PATCH 6/8] ptp: Added a clock that uses the eTSEC found on the
	MPC85xx.
In-Reply-To: <57b64051c816dc9cb856bbb9f38fc901c9d3d651.1285261535.git.richard.cochran@omicron.at>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<57b64051c816dc9cb856bbb9f38fc901c9d3d651.1285261535.git.richard.cochran@omicron.at>
Message-ID: <alpine.DEB.2.00.1009231348150.2962@router.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Sep 2010, Richard Cochran wrote:

> +* Gianfar PTP clock nodes
> +
> +General Properties:
> +
> +  - compatible   Should be "fsl,etsec-ptp"
> +  - reg          Offset and length of the register set for the device
> +  - interrupts   There should be at least two interrupts. Some devices
> +                 have as many as four PTP related interrupts.
> +
> +Clock Properties:
> +
> +  - tclk-period  Timer reference clock period in nanoseconds.
> +  - tmr-prsc     Prescaler, divides the output clock.
> +  - tmr-add      Frequency compensation value.
> +  - cksel        0= external clock, 1= eTSEC system clock, 3= RTC clock input.
> +                 Currently the driver only supports choice "1".
> +  - tmr-fiper1   Fixed interval period pulse generator.
> +  - tmr-fiper2   Fixed interval period pulse generator.
> +  - max-adj      Maximum frequency adjustment in parts per billion.
> +
> +  These properties set the operational parameters for the PTP
> +  clock. You must choose these carefully for the clock to work right.
> +  Here is how to figure good values:
> +
> +  TimerOsc     = system clock               MHz
> +  tclk_period  = desired clock period       nanoseconds
> +  NominalFreq  = 1000 / tclk_period         MHz
> +  FreqDivRatio = TimerOsc / NominalFreq     (must be greater that 1.0)
> +  tmr_add      = ceil(2^32 / FreqDivRatio)
> +  OutputClock  = NominalFreq / tmr_prsc     MHz
> +  PulseWidth   = 1 / OutputClock            microseconds
> +  FiperFreq1   = desired frequency in Hz
> +  FiperDiv1    = 1000000 * OutputClock / FiperFreq1
> +  tmr_fiper1   = tmr_prsc * tclk_period * FiperDiv1 - tclk_period
> +  max_adj      = 1000000000 * (FreqDivRatio - 1.0) - 1

Great stuff for clock synchronization...

> +  The calculation for tmr_fiper2 is the same as for tmr_fiper1. The
> +  driver expects that tmr_fiper1 will be correctly set to produce a 1
> +  Pulse Per Second (PPS) signal, since this will be offered to the PPS
> +  subsystem to synchronize the Linux clock.

Argh. And conceptually completely screwed up. Why go through the PPS
subsystem if you can directly tune the system clock based on a number of
the cool periodic clock features that you have above? See how the other
clocks do that easily? Look into drivers/clocksource. Add it there.

Please do not introduce useless additional layers for clock sync. Load
these ptp clocks like the other regular clock modules and make them sync
system time like any other clock.

Really guys: I want a PTP solution! Now! And not some idiotic additional
kernel layers that just pass bits around because its so much fun and
screws up clock accurary in due to the latency noise introduced while
having so much fun with the bits.
