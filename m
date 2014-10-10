From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 10 Oct 2014 11:53:44 -0400
Subject: [PATCH] ARM: keystone: add bus notifier to set dma_pfn_offset
 for pci devices
In-Reply-To: <20141010154258.GN5182@n2100.arm.linux.org.uk>
References: <1412954137-4567-1-git-send-email-m-karicheri2@ti.com>
 <5437FB3F.4010906@ti.com> <20141010154258.GN5182@n2100.arm.linux.org.uk>
Message-ID: <54380108.4000205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2014 11:42 AM, Russell King - ARM Linux wrote:
> On Fri, Oct 10, 2014 at 11:29:03AM -0400, Santosh Shilimkar wrote:
>>
>>
>> On 10/10/14 11:15 AM, Murali Karicheri wrote:
>>> When PCI device driver such as that for e1000e tries to set dma mask
>>> using dma_set_mask_and_coherent(), it fails because the dma_pfn_offset
>>> is incorrect on a Keystone SoC. This patch fix this by adding a bus
>>> notifier to set this correctly for PCI devices.
>>>
>>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>>> ---
>> Looks good. I will pick this up after the merge window.
>
> No it doesn't, this patch is crap.  Really.  Let's look again at what the
> patch is doing:
>
>          if (platform_nb.notifier_call)
>                  bus_register_notifier(&platform_bus_type,&platform_nb);
> +       if (platform_nb.notifier_call)
> +               bus_register_notifier(&pci_bus_type,&platform_nb);
>
> Notice that both calls are using the same platform_nb structure, which is:
>
> static struct notifier_block platform_nb;
>
> and in turn this is:
>
> struct notifier_block {
>          notifier_fn_t notifier_call;
>          struct notifier_block __rcu *next;
>          int priority;
> };
>
> Notice that "next" pointer - these blocks are used as a single-linked list.
> So, this block gets registered for the platform bus, and is inserted into
> that bus notifier chain.  That means "next" may be set to a non-NULL
> next notifier block.
>
> Then it gets registered against the PCI bus, which *will* overwrite the
> next pointer in platform_nb.
>
> There are several side effects from this:
>
> 1. Any subsequent notifiers on the platform bus which come after _this_
>     notifier are now orphaned, and will never be called.
>
> 2. Any subsequent notifiers on the PCI bus list which come after _this_
>     notifier will now also be called for the platform bus.
>
> 3. Subsequent notifiers registered against either list which are sorted
>     after _this_ notifier will be attached to _both_ lists.
>
> In other words, this patch totally screws up the notifier lists for both
> buses, and while it may not be immediately obvious, if any of the above
> three scenarios occur, it will probably be very confusing to debug.
>
> So, one hell of a big NAK on this patch.
>
> Moreover, I have to ask why there wasn't some research done first into
> how notifiers work *before* writing this code, specifically to find out
> whether it is safe to register the same notifier block simultaneously
> onto two lists.
>
Thanks Russel for the comments. I didn't see any issues when I tested my 
PCI driver with this patch, but as you have pointed out there are side 
effects. I will work to address your concerns.

Murali
out,

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
