From: mkl0301@gmail.com (Lin Mac)
Date: Wed, 1 Dec 2010 13:53:58 +0800
Subject: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using
	SATA multiplier
In-Reply-To: <4CF55549.4080000@gmail.com>
References: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com>
	<4CF50574.6000706@gmail.com>
	<AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>
	<4CF55549.4080000@gmail.com>
Message-ID: <AANLkTinyJdTYXgpfvmw8vRBEFOc+SdCKe9hBZbGk1oLd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/1 Tejun Heo <htejun@gmail.com>:
> Hello,
>
> On 11/30/2010 06:46 PM, Lin Mac wrote:
>> Could be, ?but disabling it is the last option. And it's anoying to
>> have 2 different modules for different uses.
>>
>> I'd prefer some clues/checkpoint if possible.
>
> One thing which could be possible is that the controller stashes the
> result code for the PMP aware SRST according to the PMP number instead
> of the usual place, so the driver can't see it. ?In that case, the
> driver can be modified to check both places I suppose but if the
> hardware can be fixed, that would be great.
>
>> I supposed the behavior of detecting and resetting disks (without
>> using port multiplier) should be the same for both with and without
>> CONFIG_SATA_PMP. All I know about port multiplier is when it is used
>> (not much too), but is there any register configuration or behavior is
>> required for multiplier to work properly and take effect even when no
>> multiplier is used?
>
> Yeah, the only difference is the PMP port number when issuing SRST.
> Non-PMP devices ignore it and respond the same way while PMP
> recognizes it and responds with PMP signature instead of the signature
> of the first device. ?As written above, I think it's quite likely that
> the controller is handling the response D2H Reg FIS incorrectly when a
> non-PMP device responds to PMP SRST.
Thanks for the help. It provides a good start and really save my day.

Sorry for sending patch via gmail, but I want to know if you agree
with the fix or not first.
----
With linux-2.6.37-rc3, arm/cns3xxx, ahci-platform driver.

If CONFIG_SATA_PMP is enabled, while not using multiplier and connect the disks
directly to the board, the disk cannot be found due to software reset always
failed.

[   12.790000] ahci ahci.0: forcing PORTS_IMPL to 0x3
[   12.800000] ahci ahci.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3
impl platform mode
[   12.810000] ahci ahci.0: flags: ncq sntf pm led clo only pmp pio
slum part ccc
[   12.850000] scsi0 : ahci_platform
[   12.860000] scsi1 : ahci_platform
[   12.870000] ata1: SATA max UDMA/133 irq_stat 0x00400040, connection
status changed irq 65
[   12.880000] ata2: SATA max UDMA/133 mmio [mem
0x83000000-0x83ffffff] port 0x180 irq 65
[   13.240000] ata2: SATA link down (SStatus 0 SControl 300)
[   18.900000] ata1: link is slow to respond, please be patient (ready=0)
[   22.930000] ata1: softreset failed (device not ready)
[   28.940000] ata1: link is slow to respond, please be patient (ready=0)
[   32.970000] ata1: softreset failed (device not ready)
[   38.980000] ata1: link is slow to respond, please be patient (ready=0)
[   68.030000] ata1: softreset failed (device not ready)
[   68.040000] ata1: limiting SATA link speed to 1.5 Gbps
[   70.280000] ata1: SATA link down (SStatus 1 SControl 310)

While using multiplier with CONFIG_SATA_PMP enabled, or using disks directly
without CONFIG_SATA_PMP have no issue.

It is because sata_srst_pmp always return SATA_PMP_CTRL_PORT(15), which casued
ahci_do_softreset with pmp 15, which is not needed for disks connected directly.

With SPMH3726-P rev:2.1.2, ata_dev_classify would report ATA_DEV_UNKNOWN on
ahci_hardreset. While with a Segate Barracuda 1TB SATA HD, it is ATA_DEV_ATA.
Therefore, the pmp returned by sata_srst_pmp should depends on the class
reported by ahci_hardreset.

This patch does 2 things:
1. ata_eh_reset calls ata_do_reset upon SRST without clearing classes, to be
   used by sata_srst_pmp to decide pmp.
2. sata_srst_pmp returns SATA_PMP_CTRL_PORT only when class is ATA_DEV_PMP or
   ATA_DEV_UNKNOWN

Signed-off-by: Mac Lin <mkl0301@gmail.com>
---
 drivers/ata/libahci.c   |    4 ++--
 drivers/ata/libata-eh.c |    3 ++-
 include/linux/libata.h  |    5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ebc08d6..21f343b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1301,9 +1301,9 @@ EXPORT_SYMBOL_GPL(ahci_check_ready);
 static int ahci_softreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
-	int pmp = sata_srst_pmp(link);
+	int pmp = sata_srst_pmp(link, class);

-	DPRINTK("ENTER\n");
+	DPRINTK("ENTER pmp=%d\n", pmp);

 	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
 }
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5e59050..ca43f33 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2703,7 +2703,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			}

 			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
-			rc = ata_do_reset(link, reset, classes, deadline, true);
+			rc = ata_do_reset(link, reset, classes, deadline,
+				false);
 			if (rc) {
 				failed_link = link;
 				goto fail;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d947b12..792745d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1239,9 +1239,10 @@ static inline int ata_is_host_link(const struct
ata_link *link)
 }
 #endif /* CONFIG_SATA_PMP */

-static inline int sata_srst_pmp(struct ata_link *link)
+static inline int sata_srst_pmp(struct ata_link *link, unsigned int *class)
 {
-	if (sata_pmp_supported(link->ap) && ata_is_host_link(link))
+	if (sata_pmp_supported(link->ap) && ata_is_host_link(link) &&
+		(*class == ATA_DEV_PMP || *class == ATA_DEV_UNKNOWN))
 		return SATA_PMP_CTRL_PORT;
 	return link->pmp;
 }
-- 
1.7.3
