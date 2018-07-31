From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Jul 2018 17:06:23 +0100
Subject: next/master boot: 179 boots: 11 failed, 167 passed with 1
 offline (next-20180731)
In-Reply-To: <5b607cc4.1c69fb81.6c1d6.6534@mx.google.com>
References: <5b607cc4.1c69fb81.6c1d6.6534@mx.google.com>
Message-ID: <20180731160623.GH5719@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 08:14:12AM -0700, kernelci.org bot wrote:

Today's -next fails to boot on a variety of Qualcomm 32 bit platforms:

>     multi_v7_defconfig:
>         qcom-apq8064-cm-qs600:
>             lab-baylibre-seattle: new failure (last pass: next-20180730)
>         qcom-apq8064-ifc6410:
>             lab-baylibre-seattle: new failure (last pass: next-20180730)
> 
>     qcom_defconfig:
>         qcom-apq8064-cm-qs600:
>             lab-baylibre-seattle: new failure (last pass: next-20180730)

The logs are all somewhat similar, for example:

   https://storage.kernelci.org/next/master/next-20180731/arm/multi_v7_defconfig/lab-baylibre-seattle/boot-qcom-apq8064-cm-qs600.html

detects a DMA problem during MMCI initialization:

[    2.237566] mmci-pl18x 121c0000.sdcc: mmc2: PL180 manf 51 rev0 at 0x121c0000 irq 32,0 (pio)
[    2.244790] mmci-pl18x 121c0000.sdcc: DMA channels RX dma2chan1, TX dma2chan2
[    2.271722] mmci-pl18x 12400000.sdcc: error during DMA transfer!
[    2.271757] mmci-pl18x 12400000.sdcc: buggy DMA detected. Taking evasive action.
[    2.276798] ------------[ cut here ]------------
[    2.284185] WARNING: CPU: 0 PID: 0 at ../include/linux/dma-mapping.h:551 bam_free_chan+0x2d8/0x2e0
[    2.288772] Modules linked in:
[    2.297534] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc7-next-20180731 #1

then panics:

[    2.513796] ------------[ cut here ]------------
[    2.518367] kernel BUG at ../mm/vmalloc.c:1608!
[    2.522968] Internal error: Oops - BUG: 0 [#1] SMP ARM

trying to release the DMA channel.  I've not done any bisection or
anything but I do note 8bb2299d2d0b5cc (mmc: mmci: Add and implement a
->dma_setup() callback for qcom dml) and some related commits in the MMC
tree.

More details for each of the failed boots at:

  https://kernelci.org/boot/id/5b6054f559b5144b9396baa9/
  https://kernelci.org/boot/id/5b60551259b5144abb96bab6/
  https://kernelci.org/boot/id/5b6054e259b5144b1e96bab2/

including full logs, details of the build and so on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180731/f514af29/attachment.sig>
