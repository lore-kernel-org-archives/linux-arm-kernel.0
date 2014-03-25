From: amurray@embedded-bits.co.uk (Andrew Murray)
Date: Tue, 25 Mar 2014 11:46:41 +0000
Subject: [RESEND: RFC PATCH 3/3] pcie: keystone: add pcie driver based on
 designware core driver
In-Reply-To: <20140325103525.GA14789@ulmo>
References: <1395707726-20437-1-git-send-email-m-karicheri2@ti.com>
 <1395707726-20437-4-git-send-email-m-karicheri2@ti.com>
 <235376049.yyfljDtinu@wuerfel> <20140325103525.GA14789@ulmo>
Message-ID: <CAPcvp5Gy8uNW3UULi8jYk7GNbmgTd2B_qOEAXnP4H4Wq3v9BCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 March 2014 10:35, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Tue, Mar 25, 2014 at 08:44:36AM +0100, Arnd Bergmann wrote:
>> On Monday 24 March 2014 20:35:26 Murali Karicheri wrote:
> [...]
>> > +/* Keystone PCIe driver does not allow module unload */
>> > +static int __init ks_pcie_init(void)
>> > +{
>> > +   return platform_driver_probe(&ks_pcie_driver, ks_pcie_probe);
>> > +}
>> > +subsys_initcall(ks_pcie_init);
>>
>> Why subsys_initcall?
>>
>> We should probably try to fix unloading soon.
>
> I did some work on this a few months ago but never got around to
> cleaning up the patches. Let me see if I can resurrect that work.

I think there may be merit in these drivers using subsys_init. I've
not had time to investigate, but as far as I can remember this causes
issues with piceport.

For ARM32 host drivers, pci_fixup_irqs (arch/arm/kernel/bios32.c) must
be called before init_service_irqs (portdrv_core.c) otherwise pcieport
acts on invalid information in dev->irq and breaks. It seems that its
possible for the portbus driver to pick up new devices before bios32
has been able to fixup the irqs. Making the host bridge drivers subsys
will overcome this. I guess this hasn't been an issue in the past as
host bridge drivers were always in the arch/ directories.

In any case it may be worth testing this driver with PCIEPORTBUS enabled.

Andrew Murray
