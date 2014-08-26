From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Aug 2014 19:57:13 -0700
Subject: [RFC] PCI: pcie-designware: allow drivers as loadable modules
In-Reply-To: <CAOesGMgJtP-A9x_OSAkGd9HNPt9sTCtDQJJ1BZMmuQZm-nZoUg@mail.gmail.com>
References: <5303286.K45Li7B92z@wuerfel> <20140813172155.GB7298@google.com>
 <CAOesGMgJtP-A9x_OSAkGd9HNPt9sTCtDQJJ1BZMmuQZm-nZoUg@mail.gmail.com>
Message-ID: <CAOesGMgJADdKxCaCmiu-t1NOg9ZP7bPPkBb6vD9Q33nqvgmOrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 7:56 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Aug 13, 2014 at 10:21 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Thu, Jul 24, 2014 at 11:17:45AM +0200, Arnd Bergmann wrote:
>>> From 0ee79c7451851a34e5a7c33eb6020befcdcb2b24 Mon Sep 17 00:00:00 2001
>>> From: Arnd Bergmann <arnd@arndb.de>
>>> Date: Thu, 24 Jul 2014 11:12:48 +0200
>>> Subject: [PATCH] PCI: pcie-designware: allow drivers as loadable modules
>>>
>>> The new pcie-spear13xx driver uses the pcie-designware library
>>> and in the current form it can be built as a loadable module.
>>> However, the functions it uses from the base driver are not exported,
>>> so this results in a build failure and a module that can never
>>> be loaded:
>>>
>>> ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>>> ERROR: "dw_handle_msi_irq" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>>> ERROR: "dw_pcie_msi_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>>> ERROR: "dw_pcie_cfg_write" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>>> ERROR: "dw_pcie_cfg_read" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>>> ERROR: "dw_pcie_setup_rc" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>>> ERROR: "dw_pcie_link_up" [drivers/pci/host/pcie-spear13xx.ko] undefined!
>>>
>>> If we want to allow loadable pcie-designware drivers, we have to
>>> export all those symbols and ensure none of them are marked as __init.
>>> This also requires making pci_assign_unassigned_resources available
>>> after boot.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>> If we don't want this patch for some reason, we should instead mark
>>> this driver 'bool' in Kconfig, so it becomes impossible to encounter
>>> this build error.
>>
>> I'm not opposed to doing this, but I applied Sachin's patch that changes
>> the Kconfig option to bool, so I'll drop this one for now.
>
>
> Hi Bjorn,
>
> Are you going to send this as a 3.17 fix, or is it queued only for
> 3.18? The former would be preferrable here.

Nevermind, next time I'll go look at your tree directly instead. :-)


-Olof
