From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 30 Mar 2017 08:29:34 +0100
Subject: [kvmtool PATCH v9 06/15] PCI: Only allocate IRQ routing entry
 when available
In-Reply-To: <6371fdda-bdd5-2aa0-de8c-4f97953ee326@arm.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?Andr=C3=A9?=
 Przywara"'s message of "Wed, 29 Mar 2017 21:44:47 +0100")
References: <20170202163223.15372-1-andre.przywara@arm.com>
 <20170202163223.15372-7-andre.przywara@arm.com>
 <d26dea9f-386b-316c-a2b3-d42ea1883997@arm.com>
 <6371fdda-bdd5-2aa0-de8c-4f97953ee326@arm.com>
Message-ID: <87k277ql29.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29 2017 at  9:44:47 pm BST, Andr? Przywara <andre.przywara@arm.com> wrote:
> Hi Marc,
>
> thanks for having a look!
>
> On 29/03/17 09:30, Marc Zyngier wrote:
>> On 02/02/17 16:32, Andre Przywara wrote:
>>> If we need to inject an MSI into the guest, we rely at the moment on a
>>> working GSI MSI routing functionality. However we can get away without
>>> IRQ routing, if the host supports MSI injection via the KVM_SIGNAL_MSI
>>> ioctl.
>>> So we try the GSI routing first, but if that fails due to a missing
>>> IRQ routing functionality, we fall back to KVM_SIGNAL_MSI (if that is
>>> supported).
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>  virtio/pci.c | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/virtio/pci.c b/virtio/pci.c
>>> index 7cc0ba4..98bf6b7 100644
>>> --- a/virtio/pci.c
>>> +++ b/virtio/pci.c
>>> @@ -193,8 +193,14 @@ static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *v
>>>  
>>>  			gsi = irq__add_msix_route(kvm,
>>>  						  &vpci->msix_table[vec].msg);
>>> -			if (gsi >= 0)
>>> +			if (gsi >= 0) {
>>>  				vpci->config_gsi = gsi;
>>> +				break;
>>> +			}
>>> +			if (gsi == -ENXIO &&
>>> +			    vpci->features & VIRTIO_PCI_F_SIGNAL_MSI)
>>> +					break;
>>> +			die("failed to configure MSIs");
>>>  			break;
>>>  		case VIRTIO_MSI_QUEUE_VECTOR:
>>>  			vec = ioport__read16(data);
>>> @@ -205,8 +211,14 @@ static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *v
>>>  
>>>  			gsi = irq__add_msix_route(kvm,
>>>  						  &vpci->msix_table[vec].msg);
>>> -			if (gsi < 0)
>>> +			if (gsi < 0) {
>>> +				if (gsi == -ENXIO &&
>>> +				    vpci->features & VIRTIO_PCI_F_SIGNAL_MSI)
>>> +					break;
>>> +
>>> +				die("failed to configure MSIs");
>>>  				break;
>>> +			}
>>>  			vpci->gsis[vpci->queue_selector] = gsi;
>> 
>> Is it really expected to find -ENXIO in this array instead of a GSI?
>
> Not sure I get this "in this array" comment here. Any negative return
> value ends up in a break, without writing it anywhere.
> Later on we check for VIRTIO_PCI_F_SIGNAL_MSI first before referencing
> the array. This is admittedly a bit convoluted.
> So shall I add comments here? Or rewrite the if statement to make this
> more obvious?

Ah! Of course you're right, I completely misread the code. Maybe indeed
rewriting a bit to make it more obvious:

	if (gsi == -ENXIO && vpci->features & VIRTIO_PCI_F_SIGNAL_MSI)
		break;
        if (gsi < 0) {
        	die("failed to configure MSIs");
                break
        }

which is closer to the first.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
