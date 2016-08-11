From: anup.patel@broadcom.com (Anup Patel)
Date: Thu, 11 Aug 2016 10:06:19 +0530
Subject: [PATCH RESEND v2 0/8] Cache-coherent DMA access using UIO
In-Reply-To: <20160810221601.0005c017@t450s.home>
References: <1470635557-13416-1-git-send-email-anup.patel@broadcom.com>
 <1983237.mRdWv2BGBr@wuerfel>
 <CAALAos9eT4N-RM6-gswKcSTJK7tirFeVAxrzGsNbYOyuL4M83Q@mail.gmail.com>
 <20160810221601.0005c017@t450s.home>
Message-ID: <CAALAos-jJqLFoUjNMGnRKiD4EuvwOoQ_4V2L6coe+s0+M8We5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Thu, Aug 11, 2016 at 9:46 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Thu, 11 Aug 2016 09:30:19 +0530
> Anup Patel <anup.patel@broadcom.com> wrote:
>
>> Hi Arnd,
>>
>> On Wed, Aug 10, 2016 at 9:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Monday, August 8, 2016 11:22:29 AM CEST Anup Patel wrote:
>> >> The goal of this patchset is to improve UIO framework and UIO dmem
>> >> driver to allow cache-coherent DMA accesses from user-space.
>> >>
>> >> This patchset is based on two previous patchsets:
>> >> 1) [PATCH v5 0/6] UIO driver for APM X-Gene QMTM
>> >> (Refer, http://www.spinics.net/lists/devicetree/msg58244.html)
>> >> 2) [PATCH 0/4] Fix and extend uio_dmem_genirq
>> >> (Refer, https://lkml.org/lkml/2016/5/17/141)
>> >>
>> >> We have adopted only patch0-3 of patchset1 which was abandoned
>> >> long time back. We have taken care of last few unaddressed comments
>> >> on these patches.
>> >>
>> >> The patchset2 is quite recent has been adopted entirely. We have
>> >> taken care review comments on these patches too.
>> >>
>> >> This patchset is based on v4.7-rc7 tag and it is available in uio-v2
>> >> branch of https://github.com/Broadcom/arm64-linux.git
>> >
>> >
>> > UIO devices are generally meant to be things that do not
>> > perform DMA and that don't screw up the rest of the system
>> > when misused. A device that is able to access any physical
>> > memory doesn't belong into this category. The way that
>> > uio_dmem_genirq.c gets around this is by requiring the device
>> > to be created by some code that sets up a separate IOMMU
>> > domain first, but the DT probing here doesn't do that.
>> > Note that IOMMU domains typically use 32-bit addressing,
>> > so the entire "dma_mask from property" dance isn't even
>> > required.
>>
>> IMHO, UIO devices are meant for things that are not behind
>> any IOMMU hardware.
>>
>> Yes, any mis-programming in user space using UIO can
>> potentially screw-up the rest of the system but this is
>> generally a known/assumed fact for people who are using UIO.
>>
>> >
>> > Also, this seems to duplicate a lot of the work that
>> > went into "vfio". Can you explain why we need another way
>> > of doing the same thing here?
>>
>> We can only use "vfio" for devices that are behind some
>> kind of IOMMU (Right??). For devices not having IOMMU
>> support will have to use UIO for user space access.
>>
>> Particularly, there are lot of FPGA-based solutions and legacy
>> hardware which do not have IOMMU support (devices on
>> FPGA or specific devices).
>>
>> In our use case, we have some FPGA-based device which
>> does not have IOMMU support and we are accessing this
>> FPGA-based device from user-space.
>>
>> This patchset only tries to extend "uio" and "uio_dmem_genirq".
>> There is no intention of duplicating what has been already
>> done for "vfio".
>>
>> I do agree that "vfio" should eventually become defacto method
>> of accessing devices in user space but that requires devices to
>> always have IOMMU support.
>
> A vfio no-iommu mode exists since v4.5:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=03a76b60f8ba27974e2d252bc555d2c103420e15

It's good that we have "No-IOMMU" mode in VFIO now but I see
that it's for vfio_pci only. Has this been extended for vfio_platform?

We would certainly like to move to VFIO if "No-IOMMU" mode
is available for vfio_platform devices because in-our use case
devices are memory-mapped FPGA devices.

Meanwhile, I would like to have this patchset for benefit of
people who already using UIO.

Regards,
Anup
