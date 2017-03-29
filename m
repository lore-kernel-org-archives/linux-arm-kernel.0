From: shuahkhan@gmail.com (Shuah Khan)
Date: Wed, 29 Mar 2017 11:44:04 -0600
Subject: [PATCH] ARM: dma-mapping: Fix dma_get_sgtable() for regions
 without struct page
In-Reply-To: <20170329170325.GC7909@n2100.armlinux.org.uk>
References: <CGME20170221131655eucas1p2f2ca6e3c819aeae227c5e5c5f2bc7d3f@eucas1p2.samsung.com>
 <1487682998-2564-1-git-send-email-m.szyprowski@samsung.com>
 <20170322111020.GD21222@n2100.armlinux.org.uk>
 <CAKocOONSt=UjPPVEN0ESLBMAsbk_HeWGQdkzyuUW+X7ddaLwzQ@mail.gmail.com>
 <20170322163237.GF21222@n2100.armlinux.org.uk>
 <CAKocOOMqWByyAotnjKM3Zqq9xUBNcBFMens5Rj08aiM99wxEzg@mail.gmail.com>
 <20170322224200.GH21222@n2100.armlinux.org.uk>
 <20170329163335.GA7909@n2100.armlinux.org.uk>
 <CAKocOOPjqdyLbtbeRLr9NZaNoqefjobYhev+0hr3OGwNLwNjmw@mail.gmail.com>
 <20170329170325.GC7909@n2100.armlinux.org.uk>
Message-ID: <CAKocOONuPOkdLosC7oY3cRq73U8_3LM8urb8psFBYoxe1=800w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Mar 29, 2017 at 11:03 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Mar 29, 2017 at 10:51:05AM -0600, Shuah Khan wrote:
>> Hi Russell,
>>
>> On Wed, Mar 29, 2017 at 10:33 AM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>> > Okay, I'm about to merge the following patch for -rc, since refusing
>> > to create a scattertable for non-page backed memory is the only valid
>> > solution for that case.  I'm intending to queue this for -rc this
>> > evening.
>>
>> I was bit sidetracked and getting back to this today. I am just about
>> to test this change on my system. I will test your patch and send you
>> results.
>>
>> This might not help my use-case - I suspect it will trip this check.
>> That said I will send you results very soon.
>
> I do hope that it _does_ trip this check - the result should be that you
> get an error without the kernel oopsing.

Agreed. I would rather have it fail gracefully earlier than limp along
and die later. I would make a suggestion based on these results.

Please consider adding a dev_err() to if (!pfn_valid(pfn)) condition
to indicate why get_sgtable failed including __func__

I worry about adding dev_err() to a core function, but in this case,
it would be helpful to do to make it very clear that the requested
use-case can't be supported.

Results:

[  235.706048] platform 11000000.codec:left: failed to get scatterlist
from DMA API

The following is a WARN_ON from vb2_dc_get_dmabuf() - probably should
go away. I will send a patch removing the WARN_ON to linux-media


[  235.711985] ------------[ cut here ]------------
[  235.712001] WARNING: CPU: 6 PID: 1987 at
drivers/media/v4l2-core/videobuf2-dma-contig.c:402
vb2_dc_get_dmabuf+0x130/0x168 [videobuf2_dma_contig]
[  235.712005] Modules linked in: cpufreq_userspace cpufreq_powersave
cpufreq_conservative s5p_jpeg s5p_mfc exynos_gsc v4l2_mem2mem
videobuf2_dma_contig v4l2_common videobuf2_memops videobuf2_v4l2
videobuf2_core videodev media
[  235.712063] CPU: 6 PID: 1987 Comm: qtdemux0:sink Not tainted
4.11.0-rc2-00001-g49214d0-dirty #11
[  235.712068] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  235.712085] [<c010e244>] (unwind_backtrace) from [<c010aea0>]
(show_stack+0x10/0x14)
[  235.712096] [<c010aea0>] (show_stack) from [<c033ef50>]
(dump_stack+0x78/0x8c)
[  235.712106] [<c033ef50>] (dump_stack) from [<c011b3c8>] (__warn+0xe8/0x100)
[  235.712113] [<c011b3c8>] (__warn) from [<c011b490>]
(warn_slowpath_null+0x20/0x28)
[  235.712122] [<c011b490>] (warn_slowpath_null) from [<bf20d8b8>]
(vb2_dc_get_dmabuf+0x130/0x168 [videobuf2_dma_contig])
[  235.712141] [<bf20d8b8>] (vb2_dc_get_dmabuf [videobuf2_dma_contig])
from [<bf151ec4>] (vb2_core_expbuf+0x1d4/0x2d8 [videobuf2_core])
[  235.712159] [<bf151ec4>] (vb2_core_expbuf [videobuf2_core]) from
[<bf19c198>] (vb2_expbuf+0x2c/0x34 [videobuf2_v4l2])
[  235.712195] [<bf19c198>] (vb2_expbuf [videobuf2_v4l2]) from
[<bf04b834>] (__video_do_ioctl+0x204/0x2fc [videodev])
[  235.712241] [<bf04b834>] (__video_do_ioctl [videodev]) from
[<bf04b390>] (video_usercopy+0x24c/0x4e0 [videodev])
[  235.712285] [<bf04b390>] (video_usercopy [videodev]) from
[<bf0465a4>] (v4l2_ioctl+0xa0/0xd8 [videodev])
[  235.712316] [<bf0465a4>] (v4l2_ioctl [videodev]) from [<c01fe920>]
(do_vfs_ioctl+0x9c/0x8e0)
[  235.712325] [<c01fe920>] (do_vfs_ioctl) from [<c01ff198>]
(SyS_ioctl+0x34/0x5c)
[  235.712334] [<c01ff198>] (SyS_ioctl) from [<c0107740>]
(ret_fast_syscall+0x0/0x3c)
[  235.712339] ---[ end trace cdfda037de46497c ]---

>
>> I have been thinking about this some. I would like to see if we can
>> provide a way forward to address the cases where coherent memory is
>> not guaranteed to be backed by struct pages. We know the memory isn't
>> backed at alloc time in dma_alloc_coherent(). Can we key off of that
>> maybe add a new attr flag to avoid page lookups. I am willing to work
>> on the fixing it.
>
> What we need is to revise the dma-buf API and DMA APIs to allow passing
> coherent memory through it - there is no current provision in the DMA APIs
> to have coherent memory mapped for two peripherals.

I will explore adding the support. I do think there is value in being
able to use coherent memory
buffers for DMA.

thanks,
-- Shuah

>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
