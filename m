From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Dec 2013 15:23:40 +0100
Subject: Openblocks AX3-4 i2c bus lockup
In-Reply-To: <20131231133333.GV19878@titan.lakedaemon.net>
References: <20131221164151.GF20115@lunn.ch>
 <CADx9zJDbzUmgHCRn9K=8m_d_uiSAYoW3y_NVfLFiDq4WzS3C0A@mail.gmail.com>
 <52C2A5C8.7040201@free-electrons.com> <52C2B889.4030903@free-electrons.com>
 <52C2BD9A.9080303@gmail.com> <20131231133333.GV19878@titan.lakedaemon.net>
Message-ID: <52C2D36C.8020905@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason, Sebastian,

On 31/12/2013 14:33, Jason Cooper wrote:
> On Tue, Dec 31, 2013 at 01:50:34PM +0100, Sebastian Hesselbarth wrote:
>> On 12/31/2013 01:28 PM, Gregory CLEMENT wrote:
>>>> First I wanted to be sure that there the issue was not introduce by a
>>>> commit so reverted one by one the commits on the file
>>>> drivers/i2c/busses/i2c-mv64xxx.c. I tested it on both version of the
>>>> OpenBlock AX-4 (with CPU A0 and B0). After each commit the kernel
>>>> continue to work on the B0 version as expected, but it was when I
>>>> reverted the commit "i2c: mv64xxx: Add I2C Transaction Generator
>>>> support" that it worked also on the A0 version.
>>>>
>>>> Then I had a look on the errata datasheet and I found issues that I
>>>> missed when I worked on it. This issues were fixed in B0 version.
>>>>
>>>> The fix should be pretty simple: disabling the offload_enabled flag when
>>>> an A0 version of the CPU is used. For this there are 2 solutions:
>>>> introducing a new compatible string or trying to detect the CPU
>>>> stepping at runtime. I would prefer the second solution and I am looking
>>>> for a way to get this information.
>>>
>>>
>>> We can have this information in the same way that it is currently done
>>> by the other mvebu SoC: accessing the PCIE_DEV_REV_OFF register. In
>>> arch/arm/plat-orion/pcie.c there were functions named
>>> orion_pcie_dev_id() and orion_pcie_dev_id() to retrieve information
>>> about the CPU variant and its version.
>>
>> Depending on running pcie when calling is tricky, as it can be clock
>> gated. Maybe we should have some mach code to get the SoC revision
>> early for all SoCs. That should look for a pcie controller node,
>> enable the clock, store the revision once, and disable the clock
>> again. The callback can then return the stored value.
> 
> Agreed.

I will try to submit something as knowing the variant and the revision
of the SoCs will be very useful.

> 
>>> We could the same in drivers/pci/host/pci-mvebu.c, however it would
>>> add a dependency between PCIe and I2C for the mvebu SoCs. I can think
>>> of several options:
>>>
>>> 1. Using only a new compatible strings: mv78230-A0-i2c. The benefits
>>> of it are that it is very easy to implement and it don't touch anything
>>> else than the driver itself. The drawback is that we need to add an
>>> new dts file for the A0 variant of the AX3-4.
> 
> If we decide to do this, it should be mv78230-i2c runs assuming it is
> on the A0 variant.  mv78230-B0-i2c would permit offloading.

That means changing the meaning of the actual compatible string
mv78230-i2c.

> 
>> I know that DT should describe HW, but at this point I tend to not
>> fork off another dts. If it is probable, we should probe it. SoC
>> revisions are really hard to see even from looking at the pcb, there
>> is no way for users to determine the correct dts.
> 
> In theory, this is something that could be tweaked at runtime by the
> bootloader.  But the bootloaders aren't there yet, and requiring a
> bootloader upgrade isn't an option.  However, this is something that
> should definitely be expressed in the DT.
> 
> I have no problem with doing both.  eg check for -B0-i2c, if that's
> missing, retrieve the CPU variant and then enable/disable offloading.
> 

I would do this in the opposite order: probed value would prevail over
the static one.

My plan is:

First introducing a new compatible string and handle it in the driver.
Theses patches will be simple and small enough to be applied on the
current rc kernel and the stable kernels. I will also add a new dts
file: armada-xp-a0-openblocks-ax3-4.dts (and maybe introduce adding
also a armada-xp-common-openblocks-ax3-4.dtsi file). A0 SoCs are no
more shipped, that's why I try to provide a solution which uses the B0
SoC by default and which makes the A0 the exception.

Then adding a way to get the variant and the revision of the SoCs.

Finally using this information in the i2c-mv64xxx driver to decide to
enable or not the offloading, and using the compatible string as a
fallback.

Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
