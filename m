From: rob@ti.com (Rob Clark)
Date: Mon, 5 Dec 2011 16:35:03 -0600
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <1781399.9f45Chd7K4@wuerfel>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <201112051718.48324.arnd@arndb.de>
 <CAF6AEGvyWV0DM2fjBbh-TNHiMmiLF4EQDJ6Uu0=NkopM6SXS6g@mail.gmail.com>
 <1781399.9f45Chd7K4@wuerfel>
Message-ID: <CAF6AEGugC4hW-NUU4Zss=ACSCrqads+=nwULGRaMhhTX-1uP+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 5, 2011 at 4:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 05 December 2011 14:46:47 Rob Clark wrote:
>> I sort of preferred having the DMABUF shim because that lets you pass
>> a buffer around userspace without the receiving code knowing about a
>> device specific API. ?But the problem I eventually came around to: if
>> your GL stack (or some other userspace component) is batching up
>> commands before submission to kernel, the buffers you need to wait for
>> completion might not even be submitted yet. ?So from kernel
>> perspective they are "ready" for cpu access. ?Even though in fact they
>> are not in a consistent state from rendering perspective. ?I don't
>> really know a sane way to deal with that. ?Maybe the approach instead
>> should be a userspace level API (in libkms/libdrm?) to provide
>> abstraction for userspace access to buffers rather than dealing with
>> this at the kernel level.
>
> It would be nice if user space had no way to block out kernel drivers,
> otherwise we have to be very careful to ensure that each map() operation
> can be interrupted by a signal as the last resort to avoid deadlocks.

map_dma_buf should be documented to be allowed to return -EINTR..
otherwise, yeah, that would be problematic.

> ? ? ? ?Arnd
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
