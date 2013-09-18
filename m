From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 18 Sep 2013 10:54:19 +0200
Subject: BUG: sleeping function called from invalid context at
 arch/arm/mm/fault.c:301
Message-ID: <m3mwnaa4sk.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

ipx435, v3.11, the card hw has gone wild (another issue) and generates
data abort on register access in ISR. The issue here is the warning in
do_page_fault(), is it normal?

just got this:

# rmmod solo6x10
BUG: sleeping function called from invalid context at arch/arm/mm/fault.c:301
in_atomic(): 0, irqs_disabled(): 128, pid: 303, name: rmmod
3 locks held by rmmod/303:
 #0:  (&__lockdep_no_validate__){......}, at: [<c0134ce4>] driver_detach+0x44/0xb8
 #1:  (&__lockdep_no_validate__){......}, at: [<c0134cf0>] driver_detach+0x50/0xb8
 #2:  (&mm->mmap_sem){++++++}, at: [<c000f210>] do_page_fault+0x68/0x294
irq event stamp: 5962
hardirqs last  enabled at (5961): [<c0273b4c>] _raw_spin_unlock_irqrestore+0x30/0x5c
hardirqs last disabled at (5962): [<c005afb8>] __free_irq+0x150/0x1d0
softirqs last  enabled at (0): [<c00149d4>] copy_process.part.64+0x27c/0xd4c
softirqs last disabled at (0): [<  (null)>]   (null)
CPU: 0 PID: 303 Comm: rmmod Tainted: G         C   3.11.0+ #51
[<c000db48>] (unwind_backtrace+0x0/0xf0) from [<c000b59c>] (show_stack+0x10/0x14)
[<c000b59c>] (show_stack+0x10/0x14) from [<c000f37c>] (do_page_fault+0x1d4/0x294)
[<c000f37c>] (do_page_fault+0x1d4/0x294) from [<c0008364>] (do_DataAbort+0x34/0x9c)
[<c0008364>] (do_DataAbort+0x34/0x9c) from [<c000bf9c>] (__dabt_svc+0x3c/0x60)
Exception stack(0xc6ad3e50 to 0xc6ad3e98)
3e40:                                     0000001c c78fa000 0000174a c8ca0000
3e60: c6b2a3c0 c78fa000 c78fa000 20000013 0000001c c6ad2000 a0000013 00000000
3e80: 0000000e c6ad3e98 c005afc8 bf04be98 20000093 ffffffff
[<c000bf9c>] (__dabt_svc+0x3c/0x60) from [<bf04be98>] (solo_isr+0x10/0x200 [solo6x10])
[<bf04be98>] (solo_isr+0x10/0x200 [solo6x10]) from [<c005afc8>] (__free_irq+0x160/0x1d0)
[<c005afc8>] (__free_irq+0x160/0x1d0) from [<c005b078>] (free_irq+0x40/0x84)
[<c005b078>] (free_irq+0x40/0x84) from [<bf04b0e0>] (free_solo_dev+0xdc/0xe4 [solo6x10])
[<bf04b0e0>] (free_solo_dev+0xdc/0xe4 [solo6x10]) from [<c0110d70>] (pci_device_remove+0x38/0xac)
[<c0110d70>] (pci_device_remove+0x38/0xac) from [<c0134544>] (__device_release_driver+0x70/0xd0)
[<c0134544>] (__device_release_driver+0x70/0xd0) from [<c0134d54>] (driver_detach+0xb4/0xb8)
[<c0134d54>] (driver_detach+0xb4/0xb8) from [<c0134370>] (bus_remove_driver+0x7c/0xc4)
[<c0134370>] (bus_remove_driver+0x7c/0xc4) from [<c0110ebc>] (pci_unregister_driver+0x14/0x74)
[<c0110ebc>] (pci_unregister_driver+0x14/0x74) from [<c005705c>] (SyS_delete_module+0x170/0x248)
[<c005705c>] (SyS_delete_module+0x170/0x248) from [<c0009040>] (ret_fast_syscall+0x0/0x44)

--
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
