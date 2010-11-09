From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 9 Nov 2010 13:14:33 +0300
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
In-Reply-To: <AANLkTimH0JVcB31usN5srPNYCR8sR75J23FtTPQK1Chf@mail.gmail.com>
References: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
	<20101105074418.GA5864@oksana.dev.rtsoft.ru>
	<AANLkTimH0JVcB31usN5srPNYCR8sR75J23FtTPQK1Chf@mail.gmail.com>
Message-ID: <20101109101433.GA17423@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 03:12:25PM +0800, Lin Mac wrote:
> > So, you need to build the kernel with the following command:
> > make LOADADDR=0x200000 uImage
> > And boot with these commands:
> > setenv machid ad8
> 
> Thanks for the useful suggestions. Now it booted.

Great!

> > setenv bootargs console=ttyS0,38400 ip=on
> Changing this doesn't take effect. I was trying console=ttyS0,115200
> and root=/dev/ram0, but it just boot with the configured parameter
> instead of the given one.
> 
> Is it also the issue of u-boot?

Nope. Just remove CONFIG_CMDLINE from your kernel .config file. ;-)

> > tftp 100000 uImage
> > bootm 100000
> 
> BTW, the default boot command includes root=/dev/mmcblk0p1, but
> CONFIG_MMC_SDHCI_CNS3XXX is not enabled.
> Even if it is enabled, I got a crash once mounted. It works fine
> without L1 cache enabled (CONFIG_CPU_ICACHE_DISABLE,
> CONFIG_CPU_DCACHE_DISABLE). So it seems there are some cache coherency
> issue on the SDHC device.

I recalling I observed something like this, and it was somehow
related to the memory setup. The old (Jan 20 2010) U-Boot that
I used was configuring RAM incorrectly, and caches were just
unveiling the problem.

But, I see that you use quite new build of the U-Boot (Sep 2010),
so I'm not sure if that's the same problem as I had. Can you try
booting with something simple, e.g. init=/bin/sh?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
