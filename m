From: patrick@puiterwijk.org (Patrick Uiterwijk)
Date: Tue, 29 Mar 2016 16:49:43 +0000
Subject: [PATCH 1/2] ARM: mvebu: correct the usb node name from usb@ to
 ehci@
In-Reply-To: <87zithutnn.fsf@free-electrons.com>
References: <1459259813-5278-1-git-send-email-patrick@puiterwijk.org>
 <1459259813-5278-2-git-send-email-patrick@puiterwijk.org>
 <4079235.sABSXKnJCE@wuerfel> <87zithutnn.fsf@free-electrons.com>
Message-ID: <CAJweMdbywGZF1qJF2Nv3RTJb_dULOS_JAQpsPJjYgG+5Y7HU3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 4:37 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Arnd,
>
>  On mar., mars 29 2016, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Tuesday 29 March 2016 13:56:52 Patrick Uiterwijk wrote:
>>> According to Documentation/devicetree/bindings/usb/ehci-orion.txt,
>>> the Orion Marvell variant of EHCI controllers should have names
>>> ehci at 50000 for example.
>>>
>>> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
>>>
>>
>> I think it's better to follow the generic USB binding that suggests
>> the name of 'usb', unless we understand what the specific bug is
>> you run into. Do you think it is the boot loader that messes
>> up the hardware, or something in the kernel that goes wrong? Did
>> it work on earlier kernels?
>>
>
> I am pretty sure that this issue is caused by the Marvell U-Boot which
> tries to modify the dts on the fly. But the device tree reference of
> this U-boot is not the one we use in mainline, so at end it mess up the
> dtb!
>
> There is an option to ask Marvell bootloader to not modify the dts, I
> think it is something like ftd_skip.

Thank you for this pointer, setting fdt_skip_update no did fix this
issue indeed.
That only leaves my second patch as needed, so I'll submit just that separately.

Patrick

>
> Gregory
>
>> We had a regression based on the USB device probing, but that
>> should be fixed now with the patch below. Do you have that?
>>
>>       Arnd
>>
>>
>> commit 7222c832254a75dcd67d683df75753d4a4e125bb
>> Author: Nicolai Stange <nicstange@gmail.com>
>> Date:   Thu Mar 17 23:53:02 2016 +0100
>>
>>     usb/core: usb_alloc_dev(): fix setting of ->portnum
>>
>>     With commit 69bec7259853 ("USB: core: let USB device know device node"),
>>     the port1 argument of usb_alloc_dev() gets overwritten as follows:
>>
>>       ... usb_alloc_dev(..., unsigned port1)
>>       {
>>         ...
>>         if (!parent->parent) {
>>           port1 = usb_hcd_find_raw_port_number(..., port1);
>>         }
>>         ...
>>       }
>>
>>     Later on, this now overwritten port1 gets assigned to ->portnum:
>>
>>       dev->portnum = port1;
>>
>>     However, since xhci_find_raw_port_number() isn't idempotent, the
>>     aforementioned commit causes a number of KASAN splats like the following:
>>
>>       BUG: KASAN: slab-out-of-bounds in xhci_find_raw_port_number+0x98/0x170
>>                                            at addr ffff8801d9311670
>>       Read of size 8 by task kworker/2:1/87
>>       [...]
>>       Workqueue: usb_hub_wq hub_event
>>        0000000000000188 000000005814b877 ffff8800cba17588 ffffffff8191447e
>>        0000000041b58ab3 ffffffff82a03209 ffffffff819143a2 ffffffff82a252f4
>>        ffff8801d93115e0 0000000000000188 ffff8801d9311628 ffff8800cba17588
>>       Call Trace:
>>        [<ffffffff8191447e>] dump_stack+0xdc/0x15e
>>        [<ffffffff819143a2>] ? _atomic_dec_and_lock+0xa2/0xa2
>>        [<ffffffff814e2cd1>] ? print_section+0x61/0xb0
>>        [<ffffffff814e4939>] print_trailer+0x179/0x2c0
>>        [<ffffffff814f0d84>] object_err+0x34/0x40
>>        [<ffffffff814f4388>] kasan_report_error+0x2f8/0x8b0
>>        [<ffffffff814eb91e>] ? __slab_alloc+0x5e/0x90
>>        [<ffffffff812178c0>] ? __lock_is_held+0x90/0x130
>>        [<ffffffff814f5091>] kasan_report+0x71/0xa0
>>        [<ffffffff814ec082>] ? kmem_cache_alloc_trace+0x212/0x560
>>        [<ffffffff81d99468>] ? xhci_find_raw_port_number+0x98/0x170
>>        [<ffffffff814f33d4>] __asan_load8+0x64/0x70
>>        [<ffffffff81d99468>] xhci_find_raw_port_number+0x98/0x170
>>        [<ffffffff81db0105>] xhci_setup_addressable_virt_dev+0x235/0xa10
>>        [<ffffffff81d9ea51>] xhci_setup_device+0x3c1/0x1430
>>        [<ffffffff8121cddd>] ? trace_hardirqs_on+0xd/0x10
>>        [<ffffffff81d9fac0>] ? xhci_setup_device+0x1430/0x1430
>>        [<ffffffff81d9fad3>] xhci_address_device+0x13/0x20
>>        [<ffffffff81d2081a>] hub_port_init+0x55a/0x1550
>>        [<ffffffff81d28705>] hub_event+0xef5/0x24d0
>>        [<ffffffff81d27810>] ? hub_port_debounce+0x2f0/0x2f0
>>        [<ffffffff8195e1ee>] ? debug_object_deactivate+0x1be/0x270
>>        [<ffffffff81210203>] ? print_rt_rq+0x53/0x2d0
>>        [<ffffffff8121657d>] ? trace_hardirqs_off+0xd/0x10
>>        [<ffffffff8226acfb>] ? _raw_spin_unlock_irqrestore+0x5b/0x60
>>        [<ffffffff81250000>] ? irq_domain_set_hwirq_and_chip+0x30/0xb0
>>        [<ffffffff81256339>] ? debug_lockdep_rcu_enabled+0x39/0x40
>>        [<ffffffff812178c0>] ? __lock_is_held+0x90/0x130
>>        [<ffffffff81196877>] process_one_work+0x567/0xec0
>>       [...]
>>
>>     Afterwards, xhci reports some functional errors:
>>
>>       xhci_hcd 0000:00:14.0: ERROR: unexpected setup address command completion
>>                                     code 0x11.
>>       xhci_hcd 0000:00:14.0: ERROR: unexpected setup address command completion
>>                                     code 0x11.
>>       usb 4-3: device not accepting address 2, error -22
>>
>>     Fix this by not overwriting the port1 argument in usb_alloc_dev(), but
>>     storing the raw port number as required by OF in an additional variable,
>>     raw_port.
>>
>>     Fixes: 69bec7259853 ("USB: core: let USB device know device node")
>>     Signed-off-by: Nicolai Stange <nicstange@gmail.com>
>>     Acked-by: Alan Stern <stern@rowland.harvard.edu>
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
>> index ffa5cf13ffe1..dcb85e3cd5a7 100644
>> --- a/drivers/usb/core/usb.c
>> +++ b/drivers/usb/core/usb.c
>> @@ -424,6 +424,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
>>       struct usb_device *dev;
>>       struct usb_hcd *usb_hcd = bus_to_hcd(bus);
>>       unsigned root_hub = 0;
>> +     unsigned raw_port = port1;
>>
>>       dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>       if (!dev)
>> @@ -498,11 +499,11 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
>>
>>               if (!parent->parent) {
>>                       /* device under root hub's port */
>> -                     port1 = usb_hcd_find_raw_port_number(usb_hcd,
>> +                     raw_port = usb_hcd_find_raw_port_number(usb_hcd,
>>                               port1);
>>               }
>>               dev->dev.of_node = usb_of_get_child_node(parent->dev.of_node,
>> -                             port1);
>> +                             raw_port);
>>
>>               /* hub driver sets up TT records */
>>       }
>>
>
> --
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
