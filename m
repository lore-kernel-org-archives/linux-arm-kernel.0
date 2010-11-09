From: mkl0301@gmail.com (Lin Mac)
Date: Tue, 9 Nov 2010 15:12:25 +0800
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
In-Reply-To: <20101105074418.GA5864@oksana.dev.rtsoft.ru>
References: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
	<20101105074418.GA5864@oksana.dev.rtsoft.ru>
Message-ID: <AANLkTimH0JVcB31usN5srPNYCR8sR75J23FtTPQK1Chf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/5 Anton Vorontsov <cbouatmailru@gmail.com>
> On Fri, Nov 05, 2010 at 11:08:25AM +0800, Lin Mac wrote:
> > Here's the my summary:
> > 1. Booting CNS3420 EVB v 1.3 failed with linux 2.6.36 and .35
> I see you use zImage (bootpImage) for booting. The stock U-Boot
> image from Cavium has incorrect (non-mainline) machid. You have
> to specify a correct one and thus use uImage.
> So, you need to build the kernel with the following command:
> make LOADADDR=0x200000 uImage
> And boot with these commands:
> setenv machid ad8

Thanks for the useful suggestions. Now it booted.

> setenv bootargs console=ttyS0,38400 ip=on
Changing this doesn't take effect. I was trying console=ttyS0,115200
and root=/dev/ram0, but it just boot with the configured parameter
instead of the given one.

Is it also the issue of u-boot?

> tftp 100000 uImage
> bootm 100000

BTW, the default boot command includes root=/dev/mmcblk0p1, but
CONFIG_MMC_SDHCI_CNS3XXX is not enabled.
Even if it is enabled, I got a crash once mounted. It works fine
without L1 cache enabled (CONFIG_CPU_ICACHE_DISABLE,
CONFIG_CPU_DCACHE_DISABLE). So it seems there are some cache coherency
issue on the SDHC device.

Crash log:
---
mice: PS/2 mouse device common for all mice
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
mmc0: SDHCI controller on platform [platform] using PIO
Waiting for root device /dev/mmcblk0p2...
mmc0: Minimum clock frequency too high for identification mode
mmc0: new high speed SDHC card at address d629
mmcblk0: mmc0:d629 SD08G 7.40 GiB
mmcblk0: p1 p2
VFS: Mounted root (ext2 filesystem) readonly on device 179:2.
Freeing init memory: 96K
Kernel panic - not syncing: Attempted to kill init!
Backtrace:
[<c0024860>] (dump_backtrace+0x0/0x114) from [<c016cc70>] (dump_stack+0x18/0x1c)
r7:c7815bc0 r6:c7815bc0 r5:c7819ee0 r4:c01f6510
[<c016cc58>] (dump_stack+0x0/0x1c) from [<c016ccd4>] (panic+0x60/0x17c)
[<c016cc74>] (panic+0x0/0x17c) from [<c0032ba4>] (do_exit+0x7c/0x5b4)
r3:c01ec260 r2:c7819e40 r1:c7815cbc r0:c01bd3af
[<c0032b28>] (do_exit+0x0/0x5b4) from [<c0033160>] (do_group_exit+0x84/0xb8)
[<c00330dc>] (do_group_exit+0x0/0xb8) from [<c003dcdc>]
(get_signal_to_deliver+0x2b8/0x2e8)
r5:c7819ee0 r4:0000000b
[<c003da24>] (get_signal_to_deliver+0x0/0x2e8) from [<c0023804>]
(do_notify_resume+0x64/0x628)
[<c00237a0>] (do_notify_resume+0x0/0x628) from [<c0020e98>]
(work_pending+0x24/0x28)
----

I tried to hack it with the following patch but still failed.

---
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 401527d..3ccd686 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -332,6 +332,9 @@ static void sdhci_write_block_pio(struct sdhci_host *host)
 		}
 	}

+#ifdef CONFIG_MMC_SDHCI_CNS3XXX
+	flush_dcache_page(host->sg_miter.page);
+#endif
 	sg_miter_stop(&host->sg_miter);

 	local_irq_restore(flags);
---
Do you have any clue?


Best Regards,
Mac Lin.
