From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Sun, 2 Apr 2017 14:58:17 +0000
Subject: [PATCH V8 5/6] ACPI: Support the probing on the devices which
 apply indirect-IO
In-Reply-To: <CAJZ5v0iYD=2HVP9D-2fBBDUzkOJLrzzH7Rwg1ALQ-kBx-iSeTg@mail.gmail.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
 <1908501.jAQQKvjW4f@aspire.rjw.lan> <58DDFCBE.1030705@hisilicon.com>
 <CAJZ5v0gZdghH7jjd-zMmqXNkuvVVVSPDHfBrJXx5OXR2NE0KgA@mail.gmail.com>
 <bfdf2de0-c309-0139-4075-dfcd678b6d51@gmail.com>
 <CAJZ5v0iYD=2HVP9D-2fBBDUzkOJLrzzH7Rwg1ALQ-kBx-iSeTg@mail.gmail.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E204E0BF7@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael 
Many thanks for your reply

> -----Original Message-----
> From: rjwysocki at gmail.com [mailto:rjwysocki at gmail.com] On Behalf Of
> Rafael J. Wysocki
> Sent: 01 April 2017 10:52
> To: zhichang.yuan
> Cc: Rafael J. Wysocki; Yuanzhichang; Rafael J. Wysocki; Catalin
> Marinas; Will Deacon; Rob Herring; Frank Rowand; Bjorn Helgaas; Arnd
> Bergmann; linux-arm-kernel at lists.infradead.org; Mark Rutland; Brian
> Starkey; Olof Johansson; Lorenzo Pieralisi; Benjamin Herrenschmidt;
> Linux Kernel Mailing List; ACPI Devel Maling List; Linuxarm;
> devicetree at vger.kernel.org; Linux PCI; Corey Minyard; Zou Rongrong;
> John Garry; Gabriele Paoloni; kantyzc at 163.com; xuwei (O)
> Subject: Re: [PATCH V8 5/6] ACPI: Support the probing on the devices
> which apply indirect-IO
> 
> On Sat, Apr 1, 2017 at 4:16 AM, zhichang.yuan
> <zhichang.yuan02@gmail.com> wrote:
> >
> >
> > On 04/01/2017 07:02 AM, Rafael J. Wysocki wrote:
> >> On Fri, Mar 31, 2017 at 8:52 AM, zhichang.yuan
> >> <yuanzhichang@hisilicon.com> wrote:
> >>> Hi, Rafael,
> >>>
> >>> Thanks for reviewing this!
> >>>
> >>> On 2017/3/31 4:31, Rafael J. Wysocki wrote:
> >>>> On Thursday, March 30, 2017 11:26:58 PM zhichang.yuan wrote:
> >>>>> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC
> devices access I/O
> >>>>> with some special host-local I/O ports known on x86. To access
> the I/O
> >>>>> peripherals, an indirect-IO mechanism is introduced to mapped the
> host-local
> >>>>> I/O to system logical/fake PIO similar the PCI MMIO on
> architectures where no
> >>>>> separate I/O space exists. Just as PCI MMIO, the host I/O range
> should be
> >>>>> registered before probing the downstream devices and set up the
> I/O mapping.
> >>>>> But current ACPI bus probing doesn't support these indirect-IO
> hosts/devices.
> >>>>>
> >>>>> This patch introdueces a new ACPI handler for this device
> category. Through the
> >>>>> handler attach callback, the indirect-IO hosts I/O registration
> is done and
> >>>>> all peripherals' I/O resources are translated into logic/fake PIO
> before
> >>>>> starting the enumeration.
> >>>>
> >>>> Can you explain to me briefly what exactly this code is expected
> to be doing?
> >>>
> >>> As you know currently for ARM architecture IO space is memory
> mapped and
> >>> is only used by pci devices. The port number is dynamically
> allocated
> >>> converting the device IO address into a PIO token: i.e.
> >>> http://lxr.free-electrons.com/source/drivers/acpi/pci_root.c#L745
> >>> This patch is meant to support a new class of IO host controller
> >>> that are not PCI based and that still require to have the IO
> addresses
> >>> be translated in the same PIO token space as the PCI controller
> >>
> >> IOW, this is ARM-specific, right?
> >
> > Yes. The current host added in this patch with _HID "HISI0191" is on
> ARM64.
> 
> But the underlying mechanism is ARM-specific as well AFAICS.
> 
> > But, I think the handler driver is architecture dependent.
> 
> I guess you mean "independent"?  That doesn't matter.
> 
> If ARM64 is the only architecture to use it in foreseeable future
> (which is the case for all I can say), it should go into acpi/arm64/
> and please ask the maintainers thereof to review it.

I guess this is the case for the foreseeable future.

So if my understanding is correct we should leave acpi_indirectio_scan_init()
call in acpi_scan_init() and move its definition under acpi/arm64/ right?

If in future other architectures needs non-pci IO controllers we may consider
to move this to acpi/...

Lorenzo what do you think? Could you have a look at the patchset?

Many thanks

Gab

> 
> Thanks,
> Rafael
