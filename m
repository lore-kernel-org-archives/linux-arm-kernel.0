From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 14 Mar 2017 08:14:51 +0000
Subject: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose
 dependency has not met
In-Reply-To: <4600523.rWNiWKrYZC@aspire.rjw.lan>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
 <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
 <4600523.rWNiWKrYZC@aspire.rjw.lan>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E204822B1@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael

Many thanks for your review

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw at rjwysocki.net]
> Sent: 13 March 2017 21:25
> To: Yuanzhichang
> Cc: catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> frowand.list at gmail.com; bhelgaas at google.com; rafael at kernel.org;
> mark.rutland at arm.com; arnd at arndb.de; linux-arm-
> kernel at lists.infradead.org; linux-acpi at vger.kernel.org;
> lorenzo.pieralisi at arm.com; benh at kernel.crashing.org; linux-
> kernel at vger.kernel.org; Linuxarm; devicetree at vger.kernel.org; linux-
> pci at vger.kernel.org; linux-serial at vger.kernel.org; minyard at acm.org;
> liviu.dudau at arm.com; zourongrong at gmail.com; John Garry; Gabriele
> Paoloni; zhichang.yuan02 at gmail.com; kantyzc at 163.com; xuwei (O)
> Subject: Re: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices
> whose dependency has not met
> 
> On Monday, March 13, 2017 10:42:41 AM zhichang.yuan wrote:
> > In commit 40e7fcb1929(ACPI: Add _DEP support to fix battery issue on
> Asus
> > T100TA), the '_DEP' was supported to solve the dependency of Asus
> battery. But
> > this patch is specific to Asus battery device.
> > In the real world, there are other devices which need the dependency
> to play the
> > role on the enumeration order. For example, all the Hip06 LPC
> > periperals(IPMI-BT, uart, etc) must be scanned after the LPC host
> driver
> > finished the probing. So, it makes sense to add a checking whether
> the ACPI
> > device meet all the dependencies during its enumeration slot, if not,
> the
> > enumeration will be delayed till all dependency master finish their
> work.
> >
> > This patch adds the dependency checking in ACPI enumeration, also the
> > corresponding handling to retrigger the Hip06 LPC peripherals'
> scanning.
> 
> AFAICS, _DEP is generally abused in the wild and cannot be made
> generic.  Sorry.

Another option here would be to revert this patch and add a dependency
check in the probe functions of the LPC possible children nodes (e.g. 
in the IPMI driver:
http://elixir.free-electrons.com/source/drivers/char/ipmi/ipmi_si_intf.c?v=4.10#L2683
)  

we could add 

	if (device->dep_unmet)
		return -EPROBE_DEFER;

as we now have in acpi/battery.c...

I think this should not make any difference for current shipped FW that has
got no DEP method...

What do you think?

Many Thanks
Gab

> 
> Thanks,
> Rafael
