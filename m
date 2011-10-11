From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 11 Oct 2011 15:05:47 +0200
Subject: [Linaro-mm-sig] [PATCHv16 0/9] Contiguous Memory Allocator
In-Reply-To: <4E9427B6.8050306@stericsson.com>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<4E92E003.4060901@stericsson.com>
	<00b001cc87e5$dc818cc0$9584a640$%szyprowski@samsung.com>
	<4E93F088.60006@stericsson.com>
	<00b301cc8803$93b5b3e0$bb211ba0$%szyprowski@samsung.com>
	<4E9427B6.8050306@stericsson.com>
Message-ID: <00cb01cc8816$7e474600$7ad5d200$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, October 11, 2011 1:26 PM Maxime Coquelin wrote:

> On 10/11/2011 12:50 PM, Marek Szyprowski wrote:
> > Hello,
> >
> > On Tuesday, October 11, 2011 9:30 AM Maxime Coquelin wrote:
> >
> >> On 10/11/2011 09:17 AM, Marek Szyprowski wrote:
> >>> On Monday, October 10, 2011 2:08 PM Maxime Coquelin wrote:
> >>>
> >>>        During our stress tests, we encountered some problems :
> >>>
> >>>        1) Contiguous allocation lockup:
> >>>            When system RAM is full of Anon pages, if we try to allocate a
> >>> contiguous buffer greater than the min_free value, we face a
> >>> dma_alloc_from_contiguous lockup.
> >>>            The expected result would be dma_alloc_from_contiguous() to fail.
> >>>            The problem is reproduced systematically on our side.
> >>> Thanks for the report. Do you use Android's lowmemorykiller? I haven't
> >>> tested CMA on Android kernel yet. I have no idea how it will interfere
> >>> with Android patches.
> >>>
> >> The software used for this test (v16) is a generic 3.0 Kernel and a
> >> minimal filesystem using Busybox.
> > I'm really surprised. Could you elaborate a bit how to trigger this issue?
> 
> At system startup, I drop caches (sync && echo 3 >
> /proc/sys/vm/drop_caches) and check how much memory is free.
> For example, in my case, only 15MB is used on the 270MB available on the
> system, so I got 255MB of free memory. Note that the min_free is 4MB in
> my case.
> In userspace, I allocate 230MB using malloc(), the free memory is now 25MB.
> Finaly, I ask for a contiguous allocation of 64MB using CMA, the result
> is a lockup in dma_alloc_from_contiguous().

Thanks for hint. I've managed to reproduce this issue. I will post fix asap.

> > I've did several tests and I never get a lockup. Allocation failed from time
> > to time though.
> When it succeed, what is the behaviour on your side? Is the OOM triggered?

OOM was never triggered.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
