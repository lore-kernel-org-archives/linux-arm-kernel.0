From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Aug 2013 08:53:15 -0400
Subject: Fwd: Re: [arm-tegra:for-3.12/soc 18/33] drivers/pci/msi.c:45:2:
 error: implicit declaration of function 'irq_set_chip_data'
Message-ID: <20130816125315.GQ13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

Sorry, I missed that the original build failure didn't go to any ML.
I've added lakml to the Cc:, and you can see below that Bjorn looked
over the change and agreed with it.

Sorry I didn't catch that.

thx,

Jason.

----- Forwarded message from Bjorn Helgaas <bhelgaas@google.com> -----

Date: Tue, 13 Aug 2013 10:37:20 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	kbuild test robot <fengguang.wu@intel.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	kbuild-all at 01.org
Subject: Re: [arm-tegra:for-3.12/soc 18/33] drivers/pci/msi.c:45:2: error:
	implicit declaration of function 'irq_set_chip_data'
Message-ID: <CAErSpo594VOsJCSYyZyazQ3AE_310CdzLsYpNFOarLE16iRaYQ@mail.gmail.com>
In-Reply-To: <20130813131653.GX25111@titan.lakedaemon.net>
References: <520970ae.fMjIvUL1srJ9hQTG%fengguang.wu@intel.com>
	<20130813101142.45d89675@skate> <20130813131653.GX25111@titan.lakedaemon.net>
X-flagmail-match: MVEBU

On Tue, Aug 13, 2013 at 7:16 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Tue, Aug 13, 2013 at 10:11:42AM +0200, Thomas Petazzoni wrote:
>> Hello,
>>
>> On Tue, 13 Aug 2013 07:33:02 +0800, kbuild test robot wrote:
>> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git for-3.12/soc
>> > head:   164f67a6fa3ff135310b757dfd234bd872c477da
>> > commit: 0cbdcfcf427b63b9670e56760ef5e67cd7081b35 [18/33] PCI: Introduce new MSI chip infrastructure
>> > config: make ARCH=s390 allyesconfig
>> >
>> > All error/warnings:
>> >
>> >    drivers/pci/msi.c: In function 'arch_setup_msi_irq':
>> > >> drivers/pci/msi.c:45:2: error: implicit declaration of function 'irq_set_chip_data' [-Werror=implicit-function-declaration]
>> >    drivers/pci/msi.c: In function 'arch_teardown_msi_irq':
>> > >> drivers/pci/msi.c:52:9: error: implicit declaration of function 'irq_get_chip_data' [-Werror=implicit-function-declaration]
>> > >> drivers/pci/msi.c:52:26: warning: initialization makes pointer from integer without a cast [enabled by default]
>> >    drivers/pci/msi.c: In function 'free_msi_irqs':
>> >    drivers/pci/msi.c:362:7: warning: unused variable 'i' [-Wunused-variable]
>> >    cc1: some warnings being treated as errors
>>
>> This is due to S390 not using the generic hardirqs code. I'm not sure
>> what's the best way to fix this, but my proposal is:
>
> Bjorn,
>
> If this looks good to you, I can apply it on top of mvebu/msi_pci.

Looks OK to me.

Bjorn

>> From 0e677afe0552c3737dad29a2def8006fcb050d49 Mon Sep 17 00:00:00 2001
>> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Date: Tue, 13 Aug 2013 10:08:17 +0200
>> Subject: [PATCH] PCI: msi: add default MSI operations for
>>  !HAVE_GENERIC_HARDIRQS platforms
>>
>> Some platforms (e.g S390) don't use the generic hardirqs code and
>> therefore do not defined HAVE_GENERIC_HARDIRQS. This prevents using
>> the irq_set_chip_data() and irq_get_chip_data() functions that are
>> used for the default implementations of the MSI operations.
>>
>> So, when CONFIG_GENERIC_HARDIRQS is not enabled, provide another
>> default implementation of the MSI operations, that simply errors
>> out. The architecture is responsible for implementing those operations
>> (which is the case on S390), and cannot use the msi_chip infrastructure.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  drivers/pci/msi.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 2837285..b35f93c 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -30,6 +30,7 @@ static int pci_msi_enable = 1;
>>
>>  /* Arch hooks */
>>
>> +#if defined(CONFIG_GENERIC_HARDIRQS)
>>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  {
>>       struct msi_chip *chip = dev->bus->msi;
>> @@ -66,6 +67,21 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>>
>>       return chip->check_device(chip, dev, nvec, type);
>>  }
>> +#else
>> +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>> +{
>> +     return -ENOSYS;
>> +}
>> +
>> +void __weak arch_teardown_msi_irq(unsigned int irq)
>> +{
>> +}
>> +
>> +int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>> +{
>> +     return 0;
>> +}
>> +#endif /* CONFIG_GENERIC_HARDIRQS */
>>
>>  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>  {
>> --
>> 1.8.1.2
>>
>> --
>> Thomas Petazzoni, Free Electrons
>> Kernel, drivers, real-time and embedded Linux
>> development, consulting, training and support.
>> http://free-electrons.com

----- End forwarded message -----
