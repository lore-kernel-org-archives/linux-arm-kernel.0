From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Dec 2013 13:28:57 +0100
Subject: Openblocks AX3-4 i2c bus lockup
In-Reply-To: <52C2A5C8.7040201@free-electrons.com>
References: <20131221164151.GF20115@lunn.ch>
 <CADx9zJDbzUmgHCRn9K=8m_d_uiSAYoW3y_NVfLFiDq4WzS3C0A@mail.gmail.com>
 <52C2A5C8.7040201@free-electrons.com>
Message-ID: <52C2B889.4030903@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

[added Jason, Sebastian and Ezequiel in case they have better ideas]
[I also changed the order of the chunk of this email to make it easier
for the new comer to understand the subject]

On 31/12/2013 12:08, Gregory CLEMENT wrote:> Hi Andrew,
>
>>>
>>> Le 21 d?c. 2013 17:43, "Andrew Lunn" <andrew at lunn.ch <mailto:andrew@lunn.ch>> a ?crit :
>>>
>>>     Hi Nobuhiro
>>>
>>>     You added I2C into the Openblocks AX3-4 device tree and the subnode
>>>     for the RTC. Did you have any problems with I2C? I'm having lots of
>>>     problems with my AX3-4 and i2c. I get i2c errors and the bus being
>>>     locked and then the whole machine locks solid.
>>>
>>>     Gregory, did you test your I2C patches for 370/XP on an Openblocks
>>>     AX3-4?
>>>
>>>     Thanks
>>>             Andrew

> On 22/12/2013 00:06, Gregory CLEMENT wrote:
>> Hi Andrew,
>>
>> I am away this weekend (Christmas with the first part of the family).
>>
>> But I remember having few issue on i2c with the first AX3-4 I received. With the second one (using a B0 steping CPU), I didn't remember having any issues. As I thought the first AX3-4 I
>> received was an early release I didn't paid more attention. The last i2c patches I sent were tested on the AX3-4 CPU rev B.
>>
>> Could you tell me what kind of command did you do to get your issues ? Then I will try to reproduce it on Monday on both revision
>>
>> Thanks,
>>
>> Gregory
>
>
> Sorry to not have answered earlier but when I investigated it I found
> an unexpected issue.
>
> First I wanted to be sure that there the issue was not introduce by a
> commit so reverted one by one the commits on the file
> drivers/i2c/busses/i2c-mv64xxx.c. I tested it on both version of the
> OpenBlock AX-4 (with CPU A0 and B0). After each commit the kernel
> continue to work on the B0 version as expected, but it was when I
> reverted the commit "i2c: mv64xxx: Add I2C Transaction Generator
> support" that it worked also on the A0 version.
>
> Then I had a look on the errata datasheet and I found issues that I
> missed when I worked on it. This issues were fixed in B0 version.
>
> The fix should be pretty simple: disabling the offload_enabled flag when
> an A0 version of the CPU is used. For this there are 2 solutions:
> introducing a new compatible string or trying to detect the CPU
> stepping at runtime. I would prefer the second solution and I am looking
> for a way to get this information.


We can have this information in the same way that it is currently done
by the other mvebu SoC: accessing the PCIE_DEV_REV_OFF register. In
arch/arm/plat-orion/pcie.c there were functions named
orion_pcie_dev_id() and orion_pcie_dev_id() to retrieve information
about the CPU variant and its version.

We could the same in drivers/pci/host/pci-mvebu.c, however it would
add a dependency between PCIe and I2C for the mvebu SoCs. I can think
of several options:

1. Using only a new compatible strings: mv78230-A0-i2c. The benefits
of it are that it is very easy to implement and it don't touch anything
else than the driver itself. The drawback is that we need to add an
new dts file for the A0 variant of the AX3-4.

2. Using the CPU revision information from the pcie driver. The
benefits of it are that we don't need modify any device tree and a fix
in the kernel will be enough. The drawback is that we introduce a
dependency between PCIe and I2C.

3. Using the CPU revision information as primary solution and the
compatible string as fallback. The benefits of it are there won't be a
mandatory dependency between PCI and I2c and the change of the dts
won't be mandatory too. The drawback is that we could have a non
working kernel if on a Rev A0 CPU, PCIe is not enable _and_
mv78230-A0-i2c compatible string is not selected.

I am open to other ideas as I am not found of none of them.


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
