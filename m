From: zach.pfeffer@linaro.org (Zach Pfeffer)
Date: Tue, 14 Jun 2011 14:10:04 -0500
Subject: [Linaro-mm-sig] [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <20110614112108.0186c562@jbarnes-desktop>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<BANLkTi=HtrFETnjk1Zu0v9wqa==r0OALvA@mail.gmail.com>
	<201106131707.49217.arnd@arndb.de>
	<BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
	<20110613154033.GA29185@1n450.cable.virginmedia.net>
	<BANLkTikkCV=rWM_Pq6t6EyVRHcWeoMPUqw@mail.gmail.com>
	<BANLkTi=C6NKT94Fk6Rq6wmhndVixOqC6mg@mail.gmail.com>
	<20110613115437.62824f2f@jbarnes-desktop>
	<BANLkTimV5ZXVTDDFqHxMpOkrgokdCp1YXA@mail.gmail.com>
	<20110614112108.0186c562@jbarnes-desktop>
Message-ID: <BANLkTimXdVqAXP7nQLE=y79xOOJ1a5ayOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 June 2011 13:21, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Tue, 14 Jun 2011 11:15:38 -0700
> "Michael K. Edwards" <m.k.edwards@gmail.com> wrote:
>> What doesn't seem to be straightforward to do from userland is to
>> allocate pages that are locked to physical memory and mapped for
>> write-combining. ?The device driver shouldn't have to mediate their
>> allocation, just map to a physical address (or set up an IOMMU entry,
>> I suppose) and pass that to the hardware that needs it. ?Typical
>> userland code that could use such a mechanism would be the Qt/OpenGL
>> back end (which needs to store decompressed images and other
>> pre-rendered assets in GPU-ready buffers) and media pipelines.
>
> We try to avoid allowing userspace to pin arbitrary buffers though. ?So
> on the gfx side, userspace can allocate buffers, but they're only
> actually pinned when some operation is performed on them (e.g. they're
> referenced in a command buffer or used for a mode set operation).
>
> Something like ION or GEM can provide the basic alloc & map API, but
> the platform code still has to deal with grabbing hunks of memory,
> making them uncached or write combine, and mapping them to app space
> without conflicts.
>
>> Also a nice source of sample code; though, again, I don't want this to
>> be driver-specific. ?I might want a stage in my media pipeline that
>> uses the GPU to perform, say, lens distortion correction. ?I shouldn't
>> have to go through contortions to use the same buffers from the GPU
>> and the video capture device. ?The two devices are likely to have
>> their own variants on scatter-gather DMA, with a circularly linked
>> list of block descriptors with ownership bits and all that jazz; but
>> the actual data buffers should be generic, and the userland pipeline
>> setup code should just allocate them (presumably as contiguous regions
>> in a write-combining hugepage) and feed them to the plumbing.
>
> Totally agree. ?That's one reason I don't think enhancing the DMA
> mapping API in the kernel is a complete solution. ?Sure, the platform
> code needs to be able to map buffers to devices and use any available
> IOMMUs, but we still need a userspace API for all of that, with its
> associated changes to the CPU MMU handling.

I haven't seen all the discussions but it sounds like creating the
correct userspace abstraction and then looking at how the kernel needs
to change (instead of the other way around) may add some clarity to
things.

> --
> Jesse Barnes, Intel Open Source Technology Center
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig
>
