From: stefan@agner.ch (Stefan Agner)
Date: Thu, 26 Mar 2015 14:28:37 +0100
Subject: =?UTF-8?Q?soc=5Fid=20content=20according=20to=20specification?=
Message-ID: <9d1696d88282248ea76104d232119d05@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

While looking into current sysfs soc bus implementations (in preparation
for adding such an implementation for the Freescale Vybrid SoC), I
discovered different interpretations of the "soc_id" field between
SoC's.

The sysfs Documentation says
(Documentation/ABI/testing/sysfs-devices-soc):
<quote>
What:		/sys/devices/socX/soc_id
Date:		January 2012
contact:	Lee Jones <lee.jones@linaro.org>
Description:
		Read-only attribute supported by most SoCs. In the case of
		ST-Ericsson's chips this contains the SoC serial number.
</quote>

The name of the file "soc_id" is open for different interpretation: Is
the soc_id the identification of the SoC "type" or the identification of
the SoC "instance"? The description suggests that the second is the idea
behind soc_id (SoC serial number). IMHO, in that case, soc_uid would
have been more descriptive.

However, lets have a look at the implementations (the ones I caught at
first sight):

2012 Feb:
eda413c228e2 ("ARM: ux500: export System-on-Chip information ux500 via
sysfs")
=> 160-bit hexadecimal unique ID

2013 March:
d591fdf8e23e ("ARM: tegra: expose chip ID and revision")
=> 8-bit unsigned chip ID (e.g. 32 for Tegra 2, 48 Tegra 3...)

2013 Jul:
00f7dc636366 ("ARM: zynq: Add support for SOC_BUS")
=> 5-bit hexadecimal "device code id" (the register also says "PS Family
IDCODE")

2013 Aug:
a28875462bd4 ("ARM: imx6: report soc info via soc device")
=> string representing SoC type

2013 Nov:
b19e11fbb2d4 ("ARM: ep93xx: use soc bus")
=> 128-bit hexadecimal unique ID

2014 March:
56a705a48eae ("ARM: mvebu: Add a SOC bus device entry")
=> 16-bit hexadecimal PCI-E device ID?

2014 Aug:
e4e3a37d3316 ("ARM: clps711x: Add SOC BUS support")
=> 32-bit hexadecimal unique ID

So we have currently 7 implementations, of which 4 implement an ID per
SoC type and 3 an ID per SoC instance.

I think for the long run it would be nice if we can agree on what the
API exactly asks for and fix the wrong implementations accordingly. Any
thoughts on this? 

--
Stefan
