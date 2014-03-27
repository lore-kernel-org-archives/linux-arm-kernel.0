From: monstr@monstr.eu (Michal Simek)
Date: Thu, 27 Mar 2014 12:41:59 +0100
Subject: [GIT PULL v3] Xilinx Zynq changes for v3.15
In-Reply-To: <201403270228.19976.arnd@arndb.de>
References: <53061EBA.1080002@monstr.eu>
 <20140317044453.GA18210@quad.lixom.net> <532712D2.4020004@monstr.eu>
 <201403270228.19976.arnd@arndb.de>
Message-ID: <53340E87.60004@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2014 02:28 AM, Arnd Bergmann wrote:
> On Monday 17 March 2014, Michal Simek wrote:
>> please pull these changes to your arm-soc tree. This branch is based
>> on zynq/dt branch.
>> Based on my discussion with Olof I have removed zynq-ocm driver
>> from this pull request and we will investigate different solution
>>
>> Changes in v3: Remove OCM driver from pull request
>> Changes in v2: Fix incorrect git repo url
> 
> I have pulled it into the next/cleanup2 branch now, sorry for the
> delay. Unfortunately I noticed one more thing I didn't like and
> did not pull the final patch of the branch, but only the other patches.

ok. thanks for pulling.

> The problem I noticed is the soc-bus support: I noticed that you
> are populating the entire device tree under the soc node, including
> any top-level devices, and that the "xlnx,zynq-devcfg-1.00.a"
> node is part of that.
>
> I think what you should try instead is to have only the
> amba bus and its children as part of the soc-bus, but other
> top-level devices (e.g. board clocks) outside of the soc
> node. Also, it would make sense to merge the devcfg stuff
> with the amba node, since it's really what makes up the
> soc. Does that make sense to you, or do you have reason to
> believe it won't work?

No problem to postpone to the next release and discuss it more.

Currently all devices listed in dts/dtsi are all hard IPs
inside PS silicon that's why I think they should be the part of SoC.
(zynq-devcfg is also hard IP present all the time in SoC
I will use different compatible string in the next version
xlnx,zynq-devcfg-1.0).

For devices in PL is situation different because only axi-axi bridge
is present in PS that's why I think that new bus type should
be used. Also this bridge provides some resets which can be
provided through this bus bridge driver.

Current code do this:

root at zynq:~# cat /sys/bus/soc/devices/soc0/revision
0x0
root at zynq:~# cat /sys/bus/soc/devices/soc0/soc_id
0x7
root at zynq:~# cat /sys/bus/soc/devices/soc0/family
Xilinx Zynq
root at zynq:~# ls /sys/bus/soc/devices/soc0/
amba.0        f8891000.pmu  power         soc_id        uevent
amba.1        family        revision      subsystem

amba.0 is the bus present in zynq-7000.dtsi
amba.1 is bus I have added myself just locally which is
axi2axi bridge mentioned above.

All devices which will be in PL will be connected to this amba.1
bus.

Regarding clk driver in slcr node is not listed there.

root at zynq:~# ls /sys/bus/soc/devices/soc0/amba.0/f8000000.slcr/
driver/    modalias   power/     subsystem/ uevent


Then we have also ACP (accelerator coherency port) which is the
same case as axi2axi bridge. It means it is fixed hardware in SoC
part and devices can be connect to it
(It looks like arm-cci bus type).

I know that others SoC are using soc {} node for adding
soc IPs but that's not our case at least for now.

If you think that SOC bus should just contain SoC specific
things then we can call of_platform_populate without SoC bus
parent to ensure that these devices are not listed there.

Please correct me if something doesn't fit.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140327/e2af2a40/attachment.sig>
