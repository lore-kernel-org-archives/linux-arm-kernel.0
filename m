From: alex.williamson@redhat.com (Alex Williamson)
Date: Sat, 7 May 2016 19:50:58 -0600
Subject: VFIO MSIX Query
In-Reply-To: <CAB995MsFjv=GvHSmo029fmuTWhGiYev3-2A358orFz_dq724Fw@mail.gmail.com>
References: <CAB995Mu0==PJ0iU4h_3oAMGo-VYDFrjOg_BO757M=PDWgMWtCw@mail.gmail.com>
 <20160503140249.4edaf3cc@t450s.home>
 <CAB995MsFjv=GvHSmo029fmuTWhGiYev3-2A358orFz_dq724Fw@mail.gmail.com>
Message-ID: <20160507195058.5b00f176@ul30vt.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nitin,

On Sat, 7 May 2016 21:09:09 +0530
Nitin Saxena <nitin.lnx@gmail.com> wrote:

> Hi Alex,
> 
> I have specific questions related to the problem I am facing in using VFIO
> for MSIX interrupt.
> 
> My userspace program running on x86 talks to NIC connected via PCIe
> interface. Current program works fine in poll mode with no VF and SRIOV
> requirement. I am changing my app from poll mode to interrupt mode using
> VFIO NOIOMMU feature as I am interested in getting MSIX interrupts only
> (For this I have ported VFIO-NOIOMMU feature patch from kernel 4.5 to 3.10
> SL7).  After applying the patch I can see /dev/vfio/noiommu-X and I could
> assign my PCI device to /dev/vfio/noiommu-0. Seems like kernel patch
> applied from 4.5 to 3.10 working fine. Also MSIX interrupts works fine with
> another kernel application but I am facing issues in using MSIX interrupts
> with my userspace program integrated with VFIO. I am running single process
> only  with one MSIX interrupt requirement
> 
> Few Questions:
> 
> Q1) VFIO_GROUP_GET_DEVICE_FD ioctl call stops poll mode data traffic. Why?
> I used my poll mode data path loop (where I am not waiting for MSIX) with
> my vfio_init() API I found that if I call follow VFIO sequence in
> vfio_init():
> a) create container fd (b) get group_fd (c) VFIO_SET_IOMMU as NOIOMMU ==>
> then my poll mode data path works fine
> but if I call a) create container fd (b) get group_fd (c) VFIO_SET_IOMMU as
> NOIOMMU (d) VFIO_GROUP_GET_DEVICE_FD  ==> then my poll mode data path does
> not work. I don't know why

It sounds like you're trying to mix VFIO with some other access to the
device, perhaps through pci-sysfs.  This is not compatible with VFIO.
Use VFIO for all access to the device or none.  When the device is
initially opened via the GET_DEVICE_FD ioctl, we go through an
initialization sequence on the device, including a device reset.  VFIO
is not meant to only provide MSI-X on top of a some other access
mechanism.

> Q2)Does MSIX bar/table mapping required for my case. Why?
> Even if VFIO is not used in my userspace program, BAR0 and BAR1 was already
> mmapped to process but not MSIX table. Do I need to mmap MSIX table in my
> interrupt based data path as I saw this mmaping of MSIX table in QEMU and
> dpdk both but I think these software must be using VFIO_IOMMU_TYPE1 and not
> VFIO_NOIOMMU which is my case. So can you confirm is it needed for me to
> mmap MSIX table.

Again, no mixing interfaces.  Use VFIO for all access to the device or
don't use VFIO at all.  Regardless, there's no need to mmap the MSI-X
table.  VFIO does not currently allow mmap of the MSI-X table.  If at
some point it is allowed, attempting to manipulate MSI-X via the device
vector table directly is not supported.  Only the SET_IRQS ioctl is
used for configuring device interrupts.

> Q3) Does VFIO_DEVICE_RESET required, when and why ?
> My userspace program implicitly resets PCI hardware and then I call my
> vfio_init() API and then start data path. So at what point I should can
> VFIO_DEVICE_RESET?

This is wrong, VFIO is the access to the device, any combination of
other access mechanisms plus VFIO is not supported and not intended to
work.  VFIO will attempt to reset the device when opened, any other
reset is at the user driver's discretion.

> Q4) Is there any Do's and Dont's document for VFIO so that I can follow
> proper sequence.

Don't #1: Don't attempt to add VFIO only for MSI-X support, use it for
all access to the device or don't use it at all.  There's
Documentation/vfio.txt and QEMU as the de facto standard usage example,
that's it afaik.  Thanks,

Alex
