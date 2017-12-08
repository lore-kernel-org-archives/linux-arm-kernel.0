From: broonie@kernel.org (Mark Brown)
Date: Fri, 8 Dec 2017 12:27:03 +0000
Subject: next/master boot: 270 boots: 35 failed, 213 passed with 20
 offline, 2 untried/unknown (next-20171207)
In-Reply-To: <20171208122007.GB7606@sirena.org.uk>
References: <5a29d4c7.4fabdf0a.716d7.8485@mx.google.com>
 <20171208122007.GB7606@sirena.org.uk>
Message-ID: <20171208122703.GC7606@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 12:20:07PM +0000, Mark Brown wrote:
> On Thu, Dec 07, 2017 at 03:54:47PM -0800, kernelci.org bot wrote:
> 
> Today's -next failed to boot on peach-pi:
> 
> >     exynos_defconfig:
> >         exynos5800-peach-pi:
> >             lab-collabora: new failure (last pass: next-20171205)
> 
> with details at https://kernelci.org/boot/id/5a2a2e7859b5141bc2afa17c/
> (including logs and comparisons with other boots, the last good boot was
> Wednesday).  It looks like it hangs somewhere late on in boot, the last
> output on the console is:
> 
> [    4.827139] smsc95xx 3-1.1:1.0 eth0: register 'smsc95xx' at usb-xhci-hcd.3.auto-1.1, smsc95xx USB 2.0 Ethernet, 94:eb:2c:00:03:c0
> [    5.781037] dma-pl330 3880000.adma: Loaded driver for PL330 DMAC-241330
> [    5.786247] dma-pl330 3880000.adma: 	DBUFF-4x8bytes Num_Chans-6 Num_Peri-16 Num_Events-6
> [    5.819200] dma-pl330 3880000.adma: PM domain MAU will not be powered off
> [   64.529228] random: crng init done
> 
> and there's failures earlier to instantiate the display.

I just noticed that further up the log there's a lockdep splat with a
conflict between the genpd and clock API locking - an ABBA issue with
genpd->mlock and the clock API prepare_lock.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171208/8ebfabce/attachment.sig>
