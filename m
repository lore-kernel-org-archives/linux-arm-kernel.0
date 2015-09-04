From: ddaney@caviumnetworks.com (David Daney)
Date: Fri, 4 Sep 2015 15:33:35 -0700
Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
In-Reply-To: <55B5E8C1.4030707@arm.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-3-git-send-email-mark.rutland@arm.com>
 <55B5E8C1.4030707@arm.com>
Message-ID: <55EA1C3F.1030300@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

First of all:  Thanks for working on this.

I now have a prototype implementation for irq-gic-v3-its.c that is using 
this binding on Cavium's ThunderX platform.

Q: Have you guys had any more thoughts on this that might require 
changing the binding?

If not, I will be sending out my patches for your consideration.

Thanks,
David Daney

On 07/27/2015 01:16 AM, Marc Zyngier wrote:
> On 23/07/15 17:52, Mark Rutland wrote:
>> Currently msi-parent is used by a few bindings to describe the
>> relationship between a PCI root complex and a single MSI controller, but
>> this property does not have a generic binding document.
>>
>> Additionally, msi-parent is insufficient to describe more complex
>> relationships between MSI controllers and devices under a root complex,
>> where devices may be able to target multiple MSI controllers, or where
>> MSI controllers use (non-probeable) sideband information to distinguish
>> devices.
>>
>> This patch adds a generic binding for mapping PCI devices to MSI
>> controllers. This document covers msi-parent, and a new msi-map property
>> (specific to PCI*) which may be used to map devices (identified by their
>> Requester ID) to sideband data for each MSI controller that they may
>> target.
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: David Daney <david.daney@cavium.com>


>> ---
>>   Documentation/devicetree/bindings/pci/pci-msi.txt | 220 ++++++++++++++++++++++
>>   1 file changed, 220 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
>> new file mode 100644
>> index 0000000..9b3cc81
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
>> @@ -0,0 +1,220 @@
>> +This document describes the generic device tree binding for describing the
>> +relationship between PCI devices and MSI controllers.
>> +
>> +Each PCI device under a root complex is uniquely identified by its Requester ID
>> +(AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
>> +Function number.
>> +
>> +For the purpose of this document, when treated as a numeric value, a RID is
>> +formatted such that:
>> +
>> +* Bits [15:8] are the Bus number.
>> +* Bits [7:3] are the Device number.
>> +* Bits [2:0] are the Function number.
>> +* Any other bits required for padding must be zero.
>> +
>> +MSIs may be distinguished in part through the use of sideband data accompanying
>> +writes. In the case of PCI devices, this sideband data may be derived from the
>> +Requester ID. A mechanism is required to associate a device with both the MSI
>> +controllers it can address, and the sideband data that will be associated with
>> +its writes to those controllers.
>> +
>> +For generic MSI bindings, see
>> +Documentation/devicetree/bindings/interrupt-controller/msi.txt.
>> +
>> +
>> +PCI root complex
>> +================
>> +
>> +Optional properties
>> +-------------------
>> +
>> +- msi-map: Maps a Requester ID to an MSI controller and associated
>> +  msi-specifier data. The property is an arbitrary number of tuples of
>> +  (rid-base,msi-controller,msi-base,length), where:
>> +
>> +  * rid-base is a single cell describing the first RID matched by the entry.
>> +
>> +  * msi-controller is a single phandle to an MSI controller
>> +
>> +  * msi-base is an msi-specifier describing the msi-specifier produced for the
>> +    first RID matched by the entry.
>> +
>> +  * length is a single cell describing how many consecutive RIDs are matched
>> +    following the rid-base.
>> +
>> +  Any RID r in the interval [rid-base, rid-base + length) is associated with
>> +  the listed msi-controller, with the msi-specifier (r - rid-base + msi-base).
>> +
>> +- msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
>> +  to an msi-specifier per the msi-map property.
>> +
>> +- msi-parent: Describes the MSI parent of the root complex itself. Where
>> +  the root complex and MSI controller do not pass sideband data with MSI
>> +  writes, this property may be used to describe the MSI controller(s)
>> +  used by PCI devices under the root complex, if defined as such in the
>> +  binding for the root complex.
>
> Right, this is where I'd expect some details about #msi-cells. Is it
> meant to be ignored? The lack of symmetry between the PCI and non-PCI
> use cases feels a bit inelegant (not to mention that it precludes having
> an unified parser for both cases).
>
> This otherwise looks good to me.
>
> Thanks,
>
> 	M.
>
