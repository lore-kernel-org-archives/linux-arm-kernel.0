From: robherring2@gmail.com (Rob Herring)
Date: Mon, 09 Jul 2012 13:29:53 -0500
Subject: [PATCH 07/15] ARM: dove: use fixed PCI i/o mapping
In-Reply-To: <201207091550.55912.arnd@arndb.de>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <1341600040-30993-8-git-send-email-robherring2@gmail.com>
 <201207091550.55912.arnd@arndb.de>
Message-ID: <4FFB2321.30100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2012 10:50 AM, Arnd Bergmann wrote:
> On Friday 06 July 2012, Rob Herring wrote:
>> --- a/arch/arm/mach-dove/pcie.c
>> +++ b/arch/arm/mach-dove/pcie.c
>> @@ -60,13 +60,8 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
>>                  "PCIe %d I/O", pp->index);
>>         pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
>>         pp->res[0].name = pp->io_space_name;
>> -       if (pp->index == 0) {
>> -               pp->res[0].start = DOVE_PCIE0_IO_PHYS_BASE;
>> -               pp->res[0].end = pp->res[0].start + DOVE_PCIE0_IO_SIZE - 1;
>> -       } else {
>> -               pp->res[0].start = DOVE_PCIE1_IO_PHYS_BASE;
>> -               pp->res[0].end = pp->res[0].start + DOVE_PCIE1_IO_SIZE - 1;
>> -       }
>> +       pp->res[0].start = nr * SZ_1M;
>> +       pp->res[0].end = pp->res[0].start + SZ_64K - 1;
>>         pp->res[0].flags = IORESOURCE_IO;
>>         if (request_resource(&ioport_resource, &pp->res[0]))
>>                 panic("Request PCIe IO resource failed\n");
> 
> Why use SZ_64K here when the mapping is actually 1M?

Why use 1M when 64K is enough based on our prior conversations? The more
we standardize the configuration, the more we can make common. I think
the majority of the pci setup functions can be consolidated. It's really
just data differences for the resource setup. I only used 1M alignment
in case there were some alignment requirements in the h/w and it can't
handle a starting pci bus address of 0x10000. I think it's just the
Marvell parts that do this, so if anyone knowledgeable on those parts
can comment it would help.

Rob
