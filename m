From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 09 Jun 2010 06:32:58 -0700
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <201006090807.20810.post@hendrik-sattler.de>
References: <4C083BCF.2060500@bluewatersys.com>
	<alpine.LFD.2.00.1006081655350.30664@xanadu.home>
	<4C0ED074.7050700@bluewatersys.com>
	<201006090807.20810.post@hendrik-sattler.de>
Message-ID: <1276090378.2006.11.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-09 at 08:07 +0200, Hendrik Sattler wrote:
> Am Mittwoch 09 Juni 2010, 01:21:24 schrieb Ryan Mallon:
> > Yes. I thought the problem was that Kconfig doesn't work correctly for
> > this though. Does having 'select MTD_PARTITIONS' automatically cause
> > CONFIG_MTD to be set? If not, then you basically need to have the full
> > config option list, which is basically what defconfig is.
> 
> Anybody thought about improving Kconfig to make this possible?
> Specifying CONFIG_MTD and CONFIG_MTD_PARTITIONS again and again will just 
> repeat information (that CONFIG_MTD_PARTITIONS depends on CONFIG_MTD).
> The recursive 'select' could have a different name.

There is work going on to create a SAT solver because the depends lines
are often expression instead of just specifying a single other config
option. So updating the select to work correctly isn't entirely trivial.

The other thing the SAT solver _could_ do is trivialize the current
defconfig into files to only 10 lines or so depending on which arm ..
For instance a defconfig file for trout under mach-msm (the one I
maintain) would look like this,

CONFIG_MACH_TROUT=y
CONFIG_MSM_DEBUG_UART3=y
CONFIG_MMC_MSM7X00A=y

then the solver would just deduce every other option. So three lines vs.
the current 1800+ lines. The files would become manageable, and readable
since they're so much smaller. However, we would still have all the
current files we have now.

That's all speculation still, since this solver thing doesn't exist yet.
We would have to drive it in this direction.

Daniel
