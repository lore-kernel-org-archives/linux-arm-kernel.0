From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 8 Feb 2016 12:47:18 -0800
Subject: [PATCH v5 3/3] pci,
 pci-thunder-ecam: Add driver for ThunderX-pass1 on-chip devices
In-Reply-To: <20160208195642.GA15103@rob-hp-laptop>
References: <1454715675-17512-1-git-send-email-ddaney.cavm@gmail.com>
 <1454715675-17512-4-git-send-email-ddaney.cavm@gmail.com>
 <20160208195642.GA15103@rob-hp-laptop>
Message-ID: <56B8FED6.1050804@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2016 11:56 AM, Rob Herring wrote:
> On Fri, Feb 05, 2016 at 03:41:15PM -0800, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The cavium,pci-thunder-ecam devices are exactly ECAM based PCI root
>> complexes.  These root complexes (loosely referred to as ECAM units in
>> the hardware manuals) are used to access the Thunder on-chips devices.
>> They are special in that all the BARs on devices behind these root
>> complexes are at fixed addresses.  To handle this in a manner
>> compatible with the core PCI code, we have the config access functions
>> synthesize Enhanced Allocation (EA) capability entries for each BAR.
>>
>> Since this EA synthesis is needed for exactly one chip model, we can
>> hard code some assumptions about the device topology and the
>> properties of specific DEVFNs in the driver.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   .../devicetree/bindings/pci/pci-thunder-ecam.txt   |  30 ++
>>   drivers/pci/host/Kconfig                           |   7 +
>>   drivers/pci/host/Makefile                          |   1 +
>>   drivers/pci/host/pci-thunder-ecam.c                | 358 +++++++++++++++++++++
>>   4 files changed, 396 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
>>   create mode 100644 drivers/pci/host/pci-thunder-ecam.c
>>
>> diff --git a/Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt b/Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
>> new file mode 100644
>> index 0000000..34658f2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
>> @@ -0,0 +1,30 @@
>> +* ThunderX PCI host controller for pass-1.x silicon
>> +
>> +Firmware-initialized PCI host controller to on-chip devices found on
>> +some Cavium ThunderX processors.  These devices have ECAM based config
>> +access, but the BARs are all at fixed addresses.  We handle the fixed
>> +addresses by synthesizing Enhanced Allocation (EA) capabilities for
>> +these devices.
>> +
>> +The properties and their meanings are identical to those described in
>> +host-generic-pci.txt except as listed below.
>> +
>> +Properties of the host controller node that differ from
>> +host-generic-pci.txt:
>> +
>> +- compatible     : Must be "cavium,pci-host-thunder-ecam"
>> +
>> +Example:
>> +
>> +	pci at 84b0,00000000 {
>
> Drop the comma,

OK...

> and the node name should be "pcie".
>

Why pcie?

There are no PCIe devices or buses reachable from this type of root 
complex.  There are however many PCI devices.

> Otherwise,
>
> Acked-by: Rob Herring <robh@kernel.org>
>
>> +		compatible = "cavium,pci-host-thunder-ecam";
>> +		device_type = "pci";
>> +		msi-parent = <&its>;
>> +		msi-map = <0 &its 0x30000 0x10000>;
>> +		bus-range = <0 31>;
>> +		#size-cells = <2>;
>> +		#address-cells = <3>;
>> +		#stream-id-cells = <1>;
>> +		reg = <0x84b0 0x00000000 0 0x02000000>;  /* Configuration space */
>> +		ranges = <0x03000000 0x8180 0x00000000 0x8180 0x00000000 0x80 0x00000000>; /* mem ranges */
>> +	};
