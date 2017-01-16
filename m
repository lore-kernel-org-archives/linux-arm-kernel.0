From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 16 Jan 2017 15:24:13 +0000
Subject: [PATCH v7 15/15] irqchip: mbigen: Add ACPI support
In-Reply-To: <587CD754.1050808@huawei.com>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-16-git-send-email-hanjun.guo@linaro.org>
 <20170113102104.GB20837@red-moon> <58799376.6040302@huawei.com>
 <20170116113804.GB23703@red-moon> <587CD754.1050808@huawei.com>
Message-ID: <20170116152413.GA24135@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 10:23:16PM +0800, Hanjun Guo wrote:
> Hi Lorenzo,
> 
> On 2017/1/16 19:38, Lorenzo Pieralisi wrote:
> > On Sat, Jan 14, 2017 at 10:56:54AM +0800, Hanjun Guo wrote:
> >> Hi Lorenzo,
> >>
> >> On 2017/1/13 18:21, Lorenzo Pieralisi wrote:
> >>> On Wed, Jan 11, 2017 at 11:06:39PM +0800, Hanjun Guo wrote:
> >>>> With the preparation of platform msi support and interrupt producer
> >>>> in DSDT, we can add mbigen ACPI support now.
> >>>>
> >>>> We are using _PRS methd to indicate number of irq pins instead
> >>>> of num_pins in DT to avoid _DSD usage in this case.
> >>>>
> >>>> For mbi-gen,
> >>>>     Device(MBI0) {
> >>>>           Name(_HID, "HISI0152")
> >>>>           Name(_UID, Zero)
> >>>>           Name(_CRS, ResourceTemplate() {
> >>>>                   Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
> >>>>           })
> >>>>
> >>>>           Name (_PRS, ResourceTemplate() {
> >>>> 		  Interrupt(ResourceProducer,...) {12,14,....}
> >>> I still do not understand why you are using _PRS for this, I think
> >>> the MBIgen configuration is static and if it is so the Interrupt
> >>> resource should be part of the _CRS unless there is something I am
> >>> missing here.
> >> Sorry for not clear in the commit message. MBIgen is an interrupt producer
> >> which produces irq resource to devices connecting to it, and MBIgen itself
> >> don't consume wired interrupts.
> > That's why you mark it as ResourceProducer, but that's not a reason to
> > put it in the _PRS instead of _CRS.
> 
> If using _CRS for the interrupt resource, the irq number represented
> will be mapped (i.e acpi_register_gsi()), then will conflict with the
> irq number of devices consuming it (mbigen is producing the
> interrupts), but I agree with you that let's ask Rafael's point of
> view.

Aha ! So here is why you are using _PRS because the kernel turns _CRS
Interrupt resources (even producers) into GSIs which is probably a
kernel bug, is that the reason ?

We don't abuse firmware bindings to make the kernel work, that's _never_
a good idea.

If the interrupt resource is a Resource Producer core ACPI should not
register the IRQ because that's not a GSI, probably this should be part of
Agustin changes too ?

> > IIUC _PRS is there to provide a way to define the possible resource
> > settings of a _configurable_ device (ie programmable) so that the actual
> > resource value you would programme with a call to its _SRS is sane (ie
> > the OS has a way, through the _PRS, to detect what possible resource
> > settings are available for the device).
> >
> > I think Rafael has more insights into how the _PRS is used on x86
> > systems so I would ask his point of view here before merrily merging
> > this code.
> 
> OK, Rafael is traveling now, hope he will have time to take a look.
> 
> How about updating this patch set then sending a new version for review
> with this patch unchanged? if Rafael have comments on this one, I will
> send a single updated one for this patch (if no other changes).

I think this patch (and the FW that goes with it) is wrong, but the rest
of the series, in particular the IORT bits, are ok with me.

Lorenzo
