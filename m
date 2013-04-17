From: robherring2@gmail.com (Rob Herring)
Date: Tue, 16 Apr 2013 22:23:47 -0500
Subject: 3.8+, PL310_ERRATA_769419 and highbank: borked reboot
In-Reply-To: <20130416165516.GA3097@luxor.wired.org>
References: <20130416165516.GA3097@luxor.wired.org>
Message-ID: <516E15C3.6090504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2013 11:55 AM, Paolo Pisati wrote:
> Scenario:
> 
> 3.9-rc7 kernel, multiplatform support with highbank and imx6 selected, highbank
> node -> reboot doesn't work (actually it works 1 out of 10 times)
> 
> And playing around with the config i was able to track it down to
> PL310_ERRATA_769419.

Thanks for narrowing this down.

I see 3 cores in arch_spin_lock and core 1 is powered off. I suspect
this is the l2x0 spinlock, but don't have a backtrace. If I raise the
printk level to get all the console messages, then the problem goes
away. I'm guessing core 1 is releasing the spinlock and the lock is not
getting flushed out when the core is hotplugged. With some delay the of
the printks, then the other cores have time to shutdown before core 1
exits coherency. I'll try to figure out a fix tomorrow.

Rob

> -a config and kernel that reproduce the issue:
> 
> http://people.canonical.com/~ppisati/highbank_769419_reboot/config.brk
> 
> http://people.canonical.com/~ppisati/highbank_769419_reboot/zImage.brk
> 
> -a config and kernel that don't reproduce it: 
> 
> http://people.canonical.com/~ppisati/highbank_769419_reboot/0003-highbank-dbg-comment-out-PL310_ERRATA_769419.patch
> 
> http://people.canonical.com/~ppisati/highbank_769419_reboot/config.ok
> 
> http://people.canonical.com/~ppisati/highbank_769419_reboot/zImage.ok
> 
> If you are building pl330 support too, you need a patch like this one:
> 
> http://people.canonical.com/~ppisati/highbank_769419_reboot/0001-dma-of-dma-check-OF-pointer-property-before-derefere.patch
> 
> to avoid a NULL ptr oops during boot.
> 
> Same issue happens on 3.8, and due to my test environment (conserver
> on top of ipmi for 'serial over lan') i was unable to sysrq and give you a
> stacktrace, sorry.
> 
