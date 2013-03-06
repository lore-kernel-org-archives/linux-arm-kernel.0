From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 06 Mar 2013 11:18:33 -0000
Subject: [patch 0/7] tick: Optimize broadcast handling and prevent expiry ping
 pong
Message-ID: <20130306111351.883117670@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason decoded a problem related to the broadcast timer mode. The
reprogramming of the cpu local timer causes a huge number of
retries. Also there is a situation where the CPU which does not handle
the broadcast timer interrupt exits and reenters broadcast mode before
the broadcast interrupt got handled by another CPU. This can lead to
an interesting ping pong of the broadcast and the cpu local timer
code.

This series addresses these problems. The first two patches convert
the broadcast code to proper cpumask_var_t instead of adding more
bitmaps later.

The rest of the series is adopted from the quick patches which I
posted earlier while discussing the issue with Jason et. al.

Please give it a proper testing on your affected hardware.

Thanks,

	tglx
