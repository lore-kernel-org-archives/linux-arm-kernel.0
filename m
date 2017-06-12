From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 12 Jun 2017 11:52:36 -0700
Subject: [RFT PATCH v2 02/42] drivers: pci: host: iproc: Convert link
 check to raw PCI config accessors
In-Reply-To: <CAMSpPPc0uwV0JZYkegrCaemuoJ-wfWwkSXd7TMtFwENoLRXdBQ@mail.gmail.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <20170608141342.2018-3-lorenzo.pieralisi@arm.com>
 <0eb77019-9945-592c-375d-e2de742b3237@broadcom.com>
 <20170608163614.GB2216@red-moon>
 <CAMSpPPe6bXfu=ntMedrt0w4UfqJLy1a9ZBu_kXy1j4B63x1Nww@mail.gmail.com>
 <20170612161358.GA32043@red-moon>
 <CAMSpPPc0uwV0JZYkegrCaemuoJ-wfWwkSXd7TMtFwENoLRXdBQ@mail.gmail.com>
Message-ID: <403daa9b-c0f6-971d-9312-ef103460d738@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/12/17 10:40 AM, Oza Oza wrote:
> On Mon, Jun 12, 2017 at 9:43 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> On Sun, Jun 11, 2017 at 09:42:34AM +0530, Oza Oza wrote:
>>> On Thu, Jun 8, 2017 at 10:06 PM, Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:
>>>> [dropped rock-chips maintainers, email bounces]
>>>>
>>>> On Thu, Jun 08, 2017 at 08:56:05AM -0700, Ray Jui wrote:
>>>>> Hi Lorenzo,
>>>>>
>>>>> Thanks, I'll try my best to find time to test this along 15/42 and
>>>>> 33/42 patches. Hopefully I can get to that some time next week.
>>>>>
>>>>> I have not yet reviewed these patches in details. Do they have
>>>>> dependency on other patches to the generic framework code you
>>>>> changed?
>>>>>
>>>>> If so, is there a repo I can pull them?
>>>>
>>>> I added it in the cover letter but anyway here it is:
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/pci-fixup-irqs-removal-v2
>>>
>>> Hi Lorenzo,
>>>
>>> I picked up your changes, and tested on iproc based SOC,
>>> and ran basic fio data transfer.. and it looks okay.
>>
>> Thank you. If you could also check it is all OK from a legacy
>> IRQ allocation (ie same as before applying series) I'd be grateful.
>>
> 
> I disabled msi and it should default to legacy IRQ, looks like there
> is a problem, if I missed any change !
> 
> before applying series:  cat /proc/interrupts
> 377:        168          0          0          0          0          0
>          0          0     dummy   1 Edge      nvme0q0, nvme0q1
> 
> after applying series:
> root at bcm958742k:~# dmesg | grep nvme
> [    3.855466] nvme 0000:01:00.0: assign irq: got 0
> [    3.855469] nvme 0000:01:00.0: assigning IRQ 00
> [    3.855515] nvme nvme0: pci function 0000:01:00.0
> [    4.270850] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [    4.276787] nvme 0000:01:00.0: enabling bus mastering
> [    4.276817] nvme nvme0: Removing after probe failure status: -22
> 
> here is my git status of your series, let me know if I am missing any
> change with respect to legacy IRQ ?
> 
>  modified:   arch/arm/include/asm/mach/pci.h
>         modified:   arch/arm/kernel/bios32.c
>         modified:   arch/arm/mach-dove/pcie.c
>         modified:   arch/arm/mach-iop13xx/pci.c
>         modified:   arch/arm/mach-iop13xx/pci.h
>         modified:   arch/arm/mach-mv78xx0/pcie.c
>         modified:   arch/arm/mach-orion5x/common.h
>         modified:   arch/arm/mach-orion5x/pci.c
>         modified:   arch/arm64/kernel/pci.c
>         modified:   drivers/of/of_pci_irq.c
>         modified:   drivers/pci/Makefile
>         modified:   drivers/pci/host/pci-aardvark.c
>         modified:   drivers/pci/host/pci-ftpci100.c
>         modified:   drivers/pci/host/pci-host-common.c
>         modified:   drivers/pci/host/pci-tegra.c
>         modified:   drivers/pci/host/pci-versatile.c
>         modified:   drivers/pci/host/pci-xgene.c
>         modified:   drivers/pci/host/pcie-altera.c
>         modified:   drivers/pci/host/pcie-iproc-bcma.c
>         modified:   drivers/pci/host/pcie-iproc-platform.c
>         modified:   drivers/pci/host/pcie-iproc.c
>         modified:   drivers/pci/host/pcie-iproc.h
>         modified:   drivers/pci/host/pcie-rcar.c
>         modified:   drivers/pci/host/pcie-rockchip.c
>         modified:   drivers/pci/host/pcie-xilinx-nwl.c
>         modified:   drivers/pci/host/pcie-xilinx.c
>         modified:   drivers/pci/pci-driver.c
>         modified:   drivers/pci/probe.c
>         modified:   drivers/pci/setup-irq.c
>         modified:   include/linux/pci.h
> 

Did you test with or without my change in bcm/master to emulate legacy
interrupt through dummy IRQ domain?

Thanks,

Ray
