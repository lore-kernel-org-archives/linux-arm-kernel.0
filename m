From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Apr 2014 11:49:07 +0200
Subject: [GIT PULL v3] Xilinx Zynq changes for v3.15
In-Reply-To: <201404251100.51068.arnd@arndb.de>
References: <53061EBA.1080002@monstr.eu> <201403270228.19976.arnd@arndb.de>
 <53340E87.60004@monstr.eu> <201404251100.51068.arnd@arndb.de>
Message-ID: <535A2F93.3010304@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2014 11:00 AM, Arnd Bergmann wrote:
> On Thursday 27 March 2014, Michal Simek wrote:
>>> The problem I noticed is the soc-bus support: I noticed that you
>>> are populating the entire device tree under the soc node, including
>>> any top-level devices, and that the "xlnx,zynq-devcfg-1.00.a"
>>> node is part of that.
>>>
>>> I think what you should try instead is to have only the
>>> amba bus and its children as part of the soc-bus, but other
>>> top-level devices (e.g. board clocks) outside of the soc
>>> node. Also, it would make sense to merge the devcfg stuff
>>> with the amba node, since it's really what makes up the
>>> soc. Does that make sense to you, or do you have reason to
>>> believe it won't work?
>>
>> No problem to postpone to the next release and discuss it more.
>>
>> Currently all devices listed in dts/dtsi are all hard IPs
>> inside PS silicon that's why I think they should be the part of SoC.
>> (zynq-devcfg is also hard IP present all the time in SoC
>> I will use different compatible string in the next version
>> xlnx,zynq-devcfg-1.0).
>>
>> For devices in PL is situation different because only axi-axi bridge
>> is present in PS that's why I think that new bus type should
>> be used. Also this bridge provides some resets which can be
>> provided through this bus bridge driver.
>>
>> Current code do this:
>>
>> root at zynq:~# cat /sys/bus/soc/devices/soc0/revision
>> 0x0
>> root at zynq:~# cat /sys/bus/soc/devices/soc0/soc_id
>> 0x7
>> root at zynq:~# cat /sys/bus/soc/devices/soc0/family
>> Xilinx Zynq
>> root at zynq:~# ls /sys/bus/soc/devices/soc0/
>> amba.0        f8891000.pmu  power         soc_id        uevent
>> amba.1        family        revision      subsystem
>>
>> amba.0 is the bus present in zynq-7000.dtsi
>> amba.1 is bus I have added myself just locally which is
>> axi2axi bridge mentioned above.
>>
>> All devices which will be in PL will be connected to this amba.1
>> bus.
>>
>> Regarding clk driver in slcr node is not listed there.
>>
>> root at zynq:~# ls /sys/bus/soc/devices/soc0/amba.0/f8000000.slcr/
>> driver/    modalias   power/     subsystem/ uevent
>>
>>
>> Then we have also ACP (accelerator coherency port) which is the
>> same case as axi2axi bridge. It means it is fixed hardware in SoC
>> part and devices can be connect to it
>> (It looks like arm-cci bus type).
>>
>> I know that others SoC are using soc {} node for adding
>> soc IPs but that's not our case at least for now.
>>
>> If you think that SOC bus should just contain SoC specific
>> things then we can call of_platform_populate without SoC bus
>> parent to ensure that these devices are not listed there.
>>
>> Please correct me if something doesn't fit.
> 
> I don't have a strong opinion on things that are defined in FPGA
> logic, they could be below soc0, in a separate soc1 node or
> in some other top-level bus.

ok.


> What I was mostly thinking of is board-level devices that are
> not part of the soc address hierarchy, such as external clocks
> or leds that just use GPIO lines.

Then let's discuss this based on our zynq dtsi.
GIC, PL310, (OCM controller - we will discuss this later), UARTS, CADENCE GEM,
ARASAN MMC, A9 global timer, TTC timer, SCUTIMER
- all of these are just the part of the soc address hierarchy and shouldn't
be any problem with them to be under soc0 - all of them are in silicon.

DEVCFG - it is the part of first group - it is hard IP which can program
programmable logic. Address is FIXED just wanted to list it separately.

I2C - I have just sent pull request for adding it there.
i2c childs/devices are added to the i2c node based on binding that's why
this should be fine.

PMU - Currently I have it in root but maybe better location should be used.

SLCR - which is our system controller where everything is together.
There is just ps-clk-frequency which is user setup and come externally.
The part of this is clock driver which is probably that problematic one
but on the other hand it is targetting exact register addresses which
are used by this driver to describe internal clk description.

I have looked at ux500 platform which has also SOC_BUS and
based your thinking for example cpufreq-cooling, regulator-gpio shouldn't
be there and probably more than this. Regarding clock description there
is even not register range specified that's why it should be easily moved
out of soc bus.
Linus: It is not a complain just want it to get it right.

If you have any example how this should be done, please send it to me.
I would like to have this in good shape.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/3334d28d/attachment.sig>
