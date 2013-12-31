From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 31 Dec 2013 13:50:34 +0100
Subject: Openblocks AX3-4 i2c bus lockup
In-Reply-To: <52C2B889.4030903@free-electrons.com>
References: <20131221164151.GF20115@lunn.ch>
 <CADx9zJDbzUmgHCRn9K=8m_d_uiSAYoW3y_NVfLFiDq4WzS3C0A@mail.gmail.com>
 <52C2A5C8.7040201@free-electrons.com> <52C2B889.4030903@free-electrons.com>
Message-ID: <52C2BD9A.9080303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/2013 01:28 PM, Gregory CLEMENT wrote:
>> First I wanted to be sure that there the issue was not introduce by a
>> commit so reverted one by one the commits on the file
>> drivers/i2c/busses/i2c-mv64xxx.c. I tested it on both version of the
>> OpenBlock AX-4 (with CPU A0 and B0). After each commit the kernel
>> continue to work on the B0 version as expected, but it was when I
>> reverted the commit "i2c: mv64xxx: Add I2C Transaction Generator
>> support" that it worked also on the A0 version.
>>
>> Then I had a look on the errata datasheet and I found issues that I
>> missed when I worked on it. This issues were fixed in B0 version.
>>
>> The fix should be pretty simple: disabling the offload_enabled flag when
>> an A0 version of the CPU is used. For this there are 2 solutions:
>> introducing a new compatible string or trying to detect the CPU
>> stepping at runtime. I would prefer the second solution and I am looking
>> for a way to get this information.
>
>
> We can have this information in the same way that it is currently done
> by the other mvebu SoC: accessing the PCIE_DEV_REV_OFF register. In
> arch/arm/plat-orion/pcie.c there were functions named
> orion_pcie_dev_id() and orion_pcie_dev_id() to retrieve information
> about the CPU variant and its version.

Depending on running pcie when calling is tricky, as it can be clock
gated. Maybe we should have some mach code to get the SoC revision
early for all SoCs. That should look for a pcie controller node,
enable the clock, store the revision once, and disable the clock
again. The callback can then return the stored value.

> We could the same in drivers/pci/host/pci-mvebu.c, however it would
> add a dependency between PCIe and I2C for the mvebu SoCs. I can think
> of several options:
>
> 1. Using only a new compatible strings: mv78230-A0-i2c. The benefits
> of it are that it is very easy to implement and it don't touch anything
> else than the driver itself. The drawback is that we need to add an
> new dts file for the A0 variant of the AX3-4.

I know that DT should describe HW, but at this point I tend to not
fork off another dts. If it is probable, we should probe it. SoC
revisions are really hard to see even from looking at the pcb, there
is no way for users to determine the correct dts.

> 2. Using the CPU revision information from the pcie driver. The
> benefits of it are that we don't need modify any device tree and a fix
> in the kernel will be enough. The drawback is that we introduce a
> dependency between PCIe and I2C.
>
> 3. Using the CPU revision information as primary solution and the
> compatible string as fallback. The benefits of it are there won't be a
> mandatory dependency between PCI and I2c and the change of the dts
> won't be mandatory too. The drawback is that we could have a non
> working kernel if on a Rev A0 CPU, PCIe is not enable _and_
> mv78230-A0-i2c compatible string is not selected.
>
> I am open to other ideas as I am not found of none of them.
