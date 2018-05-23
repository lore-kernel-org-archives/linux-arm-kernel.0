From: valmikibow@gmail.com (valmiki)
Date: Wed, 23 May 2018 08:48:57 +0530
Subject: Difference between IOVA and bus address when SMMU is enabled
In-Reply-To: <20180514105303.GE16141@n2100.armlinux.org.uk>
References: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
 <20180514105303.GE16141@n2100.armlinux.org.uk>
Message-ID: <e8377eb2-3d68-1809-0abd-2a4f4b9acaa1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, May 12, 2018 at 06:25:13PM +0530, valmiki wrote:
>> Hi All,
>>
>> What is the difference between IOVA address and bus address
>> when SMMU is enabled ?
>>
>> Is IOVA address term used only when hypervisor is present ?
>
> IOVA = IO virtual address.  IOVA is the term normally used to describe
> the address used on the _device_ side of an IOMMU.
>
> For any general setup:
>
> RAM ----- MMU ----- DEVICE
>       ^         ^
>   physical   virtual
>   address    address
>
> where "device" can be an IO device or a CPU, the terms still apply.
>
> If you have something like this:
>
> RAM ----- PCI bridge ----- MMU ----- DEVICE
>       ^                ^         ^
>    physical           bus     virtual
>    address          address   address
>
> You could also have (eg, in the case of a system MMU):
>
> RAM ----- MMU ----- PCI bridge ----- DEVICE
>       ^         ^                ^
>    physical  virtual            bus
>    address   address          address
>            (this can also be
>             considered a bus
>             address!)
>
> In both of the above two cases, the PCI bridge may perform some address
> translation, meaning that the bus address is different from the address
> seen on the other side of the bridge.
>
> So, the terms used depend exactly on the overall bus topology.
>
> In the case of a system MMU, where the system MMU sits between peripheral
> devices and RAM, then the bus addresses are the same as the
> _IOVA of the system MMU_.
>
Thanks Russell.

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
