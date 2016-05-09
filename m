From: alex.williamson@redhat.com (Alex Williamson)
Date: Mon, 9 May 2016 09:20:15 -0600
Subject: VFIO MSIX Query
In-Reply-To: <CAB995MvxU+mN9uxr_20nLkoezyhedUAHdFWawk-GG_bj0YjSYw@mail.gmail.com>
References: <CAB995Mu0==PJ0iU4h_3oAMGo-VYDFrjOg_BO757M=PDWgMWtCw@mail.gmail.com>
 <20160503140249.4edaf3cc@t450s.home>
 <CAB995MsFjv=GvHSmo029fmuTWhGiYev3-2A358orFz_dq724Fw@mail.gmail.com>
 <20160507195058.5b00f176@ul30vt.home>
 <CAB995MvxU+mN9uxr_20nLkoezyhedUAHdFWawk-GG_bj0YjSYw@mail.gmail.com>
Message-ID: <20160509092015.39129d56@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 8 May 2016 20:45:10 +0530
Nitin Saxena <nitin.lnx@gmail.com> wrote:

> Hi Alex,
> 
> Thanks for your answer. I got the point that all access to device must be
> VFIO.
> I have few more questions.
> 
> >> When the device is initially opened via the VFIO_GET_DEVICE_FD ioctl, we  
> go through an initialization sequence on the device, including a device
> reset
> Does this mean only one process (primary in multiprocess app) can only
> perform VFIO_GROUP_GET_DEVICE_FD ioctl ? which I doubt as I saw in dpdk
> that each process (regardless primary or not) does VFIO_GROUP_GET_DEVICE_FD
> ioctl. Kindly confirm.

Users can call GET_DEVICE_FD multiple times, but note that the group
file descriptor can only be opened once, so you'd need to pass
device file descriptors off to other threads.

> >> Use VFIO for all access to the device or don't use VFIO at all.  
> I will map PCI BARS via VFIO but what about hugepages for each process.
> Since I am using VFIO_NOIOMMU do I need to call VFIO_IOMMU_MAP_DMA ioctl
> for each hugepage of each process? I think this is not needed in my case.
> Please confirm.

No-IOMMU mode does not have MAP_DMA or UNMAP_DMA ioctls.  If you want
to support a safe operating mode, with an IOMMU providing DMA
isolation, then yes, you would need to map DMA targets for the device
using those ioctls for the type1 IOMMU backend.

> Can you please also confirm about the patch I attached. Is there any thing
> missing in the patch that I needed to incorporate from kernel 4.5 to make
> VFO NOIOMMU work? Patch

I can't confirm or deny whether the backport is accurate.  Thanks,

Alex
