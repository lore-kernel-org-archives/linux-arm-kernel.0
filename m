From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 20 Jun 2013 17:01:22 -0700
Subject: clocksource with changing frequency?
Message-ID: <f5e5d3d7-699d-4f89-80c8-849e432e8b26@VA3EHSMHS017.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a question/problem with a clocksource whose input frequency can
change.
On Zynq we use the cadece_ttc timer as clocksource. Its input clock is
tightly coupled to the CPU clock. I.e. it changes when cpufreq scales
the CPU clocks.
To compensate this, I added a clock notifier doing this on a frequency
change:
	clocksource_unregister(&ttccs->cs);                              
	clocksource_register_hz(&ttccs->cs, ndata->new_rate / PRESCALE);

This just seems not to be the most elegant way, a heavy weight operation
and results in a couple of locking errors in combination with
suspend/hotplug.

Is there a sane solution for such a case? E.g. for clockevent devices
there is a 'clockevents_update_freq()' to adjust to changing
frequencies.

I assume the sanest solution is an external oscillator as clock input,
but I think our platforms don't provide that :(

	Thanks,
	S?ren
