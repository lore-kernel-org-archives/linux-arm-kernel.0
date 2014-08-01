From: arnab.basu@freescale.com (arnab.basu at freescale.com)
Date: Fri, 1 Aug 2014 10:27:46 +0000
Subject: [RFC PATCH 00/11] Refactor MSI to support Non-PCI device
In-Reply-To: <1406344128-27055-1-git-send-email-wangyijing@huawei.com>
References: <1406344128-27055-1-git-send-email-wangyijing@huawei.com>
Message-ID: <c6d34fe1bbe9457ea8cff7dcd97902b8@DM2PR03MB317.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yijing

> -----Original Message-----
> From: Yijing Wang [mailto:wangyijing at huawei.com]
> Sent: Saturday, July 26, 2014 8:39 AM
> To: linux-kernel at vger.kernel.org
> Cc: Xinwei Hu; Wuyun; Bjorn Helgaas; linux-pci at vger.kernel.org;
> Paul.Mundt at huawei.com; James E.J. Bottomley; Marc Zyngier; linux-arm-
> kernel at lists.infradead.org; Russell King; linux-arch at vger.kernel.org;
> Basu Arnab-B45036; virtualization at lists.linux-foundation.org; Hanjun Guo;
> Yijing Wang
> Subject: [RFC PATCH 00/11] Refactor MSI to support Non-PCI device
> 
> Hi all,
> 	The series is a draft of generic MSI driver that supports PCI and
> Non-PCI device which have MSI capability. If you're not interested it,
> sorry for the noise.
> 

Thanks for sending out these patches, I have some (very basic) questions.

> The series is based on Linux-3.16-rc1.
> 
> MSI was introduced in PCI Spec 2.2. Currently, kernel MSI driver codes
> are bonding with PCI device. Because MSI has a lot advantages in design.
> More and more non-PCI devices want to use MSI as their default interrupt.
> The existing MSI device include HPET. HPET driver provide its own MSI
> code to initialize and process MSI interrupts. In the latest GIC v3 spec,
> legacy device can deliver MSI by the help of a relay device named
> consolidator.
> Consolidator can translate the legacy interrupts connected to it to
> MSI/MSI-X. And new non-PCI device will be designed to support MSI in
> future. So make the MSI driver code be generic will help the non-PCI
> device use MSI more simply.

As per my understanding the GICv3 provides a service that will convert writes to a specified address to IRQs delivered to the core and as you mention above MSIs are part of the PCI spec. So I can see a strong case for non-PCI devices to want MSI like functionality without being fully compliant with the requirements of the MSI spec.

My question is do we necessarily want to rework so much of the PCI-MSI layer to support non PCI devices? Or will it be sufficient to create a framework to allow non PCI devices to hook up with a device that can convert their writes to an IRQ to the core.

As I understand it, the msi_chip is (almost) such a framework. The only problem being that it makes some PCI specific assumptions (such as PCI specific writes from within msi_chip functions). Won't it be sufficient to make the msi_chip framework generic enough to be used by non-PCI devices and let each bus/device manage any additional requirements (such as configuration flow, bit definitions etc) that it places on message based interrupts?

Thanks
Arnab
