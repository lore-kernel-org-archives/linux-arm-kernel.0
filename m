From: mpeg.blue@free.fr (Mason)
Date: Thu, 20 Nov 2014 00:24:30 +0100
Subject: How many frequencies would cpufreq optimally like to manage?
Message-ID: <546D26AE.50601@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I'm running kernel 3.14 on an ARM Cortex-A9 based SoC.
The baseline frequency for the ARM CPU is 999 MHz.

The SoC provides a way to dynamically change the CPU frequency,
dividing it by N/16 (N=32..4095) [Actually, I think there are
also ways to divide by 1.x, but I need to read the docs again.]

I'm writing the platform-specific cpufreq driver.
I could expose hundreds of frequencies to cpufreq, but I don't
think that would be very productive. Correct?
(Note: I can't offer ANY frequency.)

My question is: how many frequencies should I expose for "optimal"
behavior of cpufreq?

I'm thinking I would only expose div={2,3,5} meaning the available
scaled frequencies would be {500,333,200} MHz. Are these enough?
Should there be more? Should I go lower than 200 MHz?

I'm also wondering about the cpuinfo_transition_latency variable.
It seems to be a constant. On my SoC, the latency depends on the
"width" of the frequency jump. Specifically, the CPU will change
frequency at 15 MHz/us. So if we're jumping from 1000 to 500 MHz,
it will take 33 us. From 500 to 333 will take 11 us.

Should I document the max latency? (i.e. for the "widest" jump)
Can the governor request to jump from cpuinfo_min_freq to
cpuinfo_max_freq directly, skipping intermediate frequencies?
If so, should I just program

cpuinfo_transition_latency =
  (((cpuinfo_max_freq - cpuinfo_min_freq) / 1000) / 15) * 1000

= (cpuinfo_max_freq - cpuinfo_min_freq) / 15 (in ns)
= 53280 ns in my example

Since governors.txt suggests a sampling rate of 10 ms, I suppose
a transition_latency of 50 us is acceptable?

Regards.
