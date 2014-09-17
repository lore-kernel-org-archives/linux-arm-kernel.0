From: alex@lindusembedded.com (Alex Gonzalez)
Date: Wed, 17 Sep 2014 15:31:20 +0200
Subject: Timer expiring past its expiration time
Message-ID: <CANsDNf1ssAd-zSyRuokqBAGGmsatFyykfPYgSPN6L_riCpZbUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am looking for hints into a problem I am seeing on a Freescale i.MX6
SoC based board running a 3.10.54 linux kernel. We realized that
sometimes the reboot process would take too long, sometimes minutes,
and we traced it down to a 2 secs sleep call from one of the rc.d
scripts.

I have captured the problem in the serial console output below. The
number in brackets is the {CPU id}.

[   21.788864] {0}[SYSC_nanosleep]2 secs 0 nsecs
[   21.793933] {0}[do_nanosleep]About to schedule timer a86eff00
[  127.217630] {0}[__run_hrtimer]timer a86eff00 EXPIRED
[  127.227133] {0}[do_nanosleep]AFTER schedule
[  127.232079] {0}[do_nanosleep]
[  127.239428] Restarting system.
[  127.242511] {0}[machine_restart]

This shows the do_nanosleep() function calling schedule(), but the
timer not expiring until 106 seconds later, when it was programmed to
2 secs.

The system is using high resolution timers, but I have also build
without HR timers support and still hit the problem.  I have also
cherry-picked patches from mainline v3.17-rc5 into hrtimers.c, but
they did not help.

The problem occurs randomly, around 1% of the reboots, and only
happens on SMP systems. That is, if I boot with maxcpus=1 we won't hit
it. Also, it seems to be only reproducible on reboot. We have done
some runtime testing trying to catch the error and are not able to see
it happening. This is expected, as the platform is working normally
otherwise.

I was hoping for some clues or maybe reports of anyone with similar issues.

BTW, even though the serial output does not seem to mask the problem,
having a persistent storage for a custom ftrace would be nice. Is that
possible?

Thanks,
Alex
