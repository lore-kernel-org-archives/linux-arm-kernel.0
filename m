From: htejun@gmail.com (Tejun Heo)
Date: Wed, 01 Dec 2010 10:45:25 +0100
Subject: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using
	SATA multiplier
In-Reply-To: <AANLkTinyJdTYXgpfvmw8vRBEFOc+SdCKe9hBZbGk1oLd@mail.gmail.com>
References: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com>
	<4CF50574.6000706@gmail.com>
	<AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>
	<4CF55549.4080000@gmail.com>
	<AANLkTinyJdTYXgpfvmw8vRBEFOc+SdCKe9hBZbGk1oLd@mail.gmail.com>
Message-ID: <4CF61935.2080501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 12/01/2010 06:53 AM, Lin Mac wrote:
> While using multiplier with CONFIG_SATA_PMP enabled, or using disks directly
> without CONFIG_SATA_PMP have no issue.
> 
> It is because sata_srst_pmp always return SATA_PMP_CTRL_PORT(15),
> which casued ahci_do_softreset with pmp 15, which is not needed for
> disks connected directly.

SRST w/ PMP==15 is the standard defined way to probe devices for PMP
capable controllers.

> With SPMH3726-P rev:2.1.2, ata_dev_classify would report ATA_DEV_UNKNOWN on
> ahci_hardreset. While with a Segate Barracuda 1TB SATA HD, it is ATA_DEV_ATA.
> Therefore, the pmp returned by sata_srst_pmp should depends on the class
> reported by ahci_hardreset.

IIRC, PMP should return the signature of the first device after
hardreset.  At any rate, the standard sanctioned way to probe is SRST
w/ PMP==15.

> This patch does 2 things:
> 1. ata_eh_reset calls ata_do_reset upon SRST without clearing classes, to be
>    used by sata_srst_pmp to decide pmp.
> 2. sata_srst_pmp returns SATA_PMP_CTRL_PORT only when class is ATA_DEV_PMP or
>    ATA_DEV_UNKNOWN

So, no, this isn't acceptable.  You're making the behavior deviate
from the standard for all controllers and devices to work around a
faulty, rather obscure controller.  If you want to work around, please
implement a workaround which is specific to the controller in
question.

Thanks.

-- 
tejun
