From: john.stultz@linaro.org (John Stultz)
Date: Fri, 2 Nov 2018 12:01:36 -0700
Subject: [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
In-Reply-To: <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
 <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
Message-ID: <CALAqxLXzVna9BG8OJhTtTjcSiy4VbJ27nBOv4fKXoMnzc4xBgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 3:15 PM, Liam Mark <lmark@codeaurora.org> wrote:
> Based on the suggestions from Laura I created a first draft for a change
> which will attempt to ensure that uncached mappings are only applied to
> ION memory who's cache lines have been cleaned.
> It does this by providing cached mappings (for uncached ION allocations)
> until the ION buffer is dma mapped and successfully cleaned, then it drops
> the userspace mappings and when pages are accessed they are faulted back
> in and uncached mappings are created.
>
> This change has the following potential disadvantages:
> - It assumes that userpace clients won't attempt to access the buffer
> while it is being mapped as we are removing the userpspace mappings at
> this point (though it is okay for them to have it mapped)
> - It assumes that kernel clients won't hold a kernel mapping to the buffer
> (ie dma_buf_kmap) while it is being dma-mapped. What should we do if there
> is a kernel mapping at the time of dma mapping, fail the mapping, warn?
> - There may be a performance penalty as a result of having to fault in the
> pages after removing the userspace mappings.
>
> It passes basic testing involving reading writing and reading from
> uncached system heap allocations before and after dma mapping.
>
> Please let me know if this is heading in the right direction and if there
> are any concerns.
>
> Signed-off-by: Liam Mark <lmark@codeaurora.org>


Thanks for sending this out! I gave this a whirl on my HiKey960. Seems
to work ok, but I'm not sure if the board's usage benefits much from
your changes.

First, ignore how crazy overall these frame values are right off, we
have some cpuidle/cpufreq issues w/ 4.14 that we're still sorting out.

Without your patch:
default-jankview_list_view,jankbench,1,mean,0,iter_10,List View
Fling,48.1333678017,
default-jankview_list_view,jankbench,2,mean,0,iter_10,List View
Fling,55.8407417387,
default-jankview_list_view,jankbench,3,mean,0,iter_10,List View
Fling,43.88160374,
default-jankview_list_view,jankbench,4,mean,0,iter_10,List View
Fling,42.2606222784,
default-jankview_list_view,jankbench,5,mean,0,iter_10,List View
Fling,44.1791721797,
default-jankview_list_view,jankbench,6,mean,0,iter_10,List View
Fling,39.7692731775,
default-jankview_list_view,jankbench,7,mean,0,iter_10,List View
Fling,48.5462154074,
default-jankview_list_view,jankbench,8,mean,0,iter_10,List View
Fling,40.1321166548,
default-jankview_list_view,jankbench,9,mean,0,iter_10,List View
Fling,48.0163174397,
default-jankview_list_view,jankbench,10,mean,0,iter_10,List View
Fling,51.1971686844,


With your patch:
default-jankview_list_view,jankbench,1,mean,0,iter_10,List View
Fling,43.3983274772,
default-jankview_list_view,jankbench,2,mean,0,iter_10,List View
Fling,45.8456678409,
default-jankview_list_view,jankbench,3,mean,0,iter_10,List View
Fling,42.9609507211,
default-jankview_list_view,jankbench,4,mean,0,iter_10,List View
Fling,48.602186248,
default-jankview_list_view,jankbench,5,mean,0,iter_10,List View
Fling,47.9257658765,
default-jankview_list_view,jankbench,6,mean,0,iter_10,List View
Fling,47.7405384035,
default-jankview_list_view,jankbench,7,mean,0,iter_10,List View
Fling,52.0017667611,
default-jankview_list_view,jankbench,8,mean,0,iter_10,List View
Fling,43.7480812349,
default-jankview_list_view,jankbench,9,mean,0,iter_10,List View
Fling,44.8138758796,
default-jankview_list_view,jankbench,10,mean,0,iter_10,List View
Fling,46.4941804068,


Just for reference, compared to my earlier patch:
default-jankview_list_view,jankbench,1,mean,0,iter_10,List View
Fling,33.8638094852,
default-jankview_list_view,jankbench,2,mean,0,iter_10,List View
Fling,34.0859500474,
default-jankview_list_view,jankbench,3,mean,0,iter_10,List View
Fling,35.6278973379,
default-jankview_list_view,jankbench,4,mean,0,iter_10,List View
Fling,31.4999822195,
default-jankview_list_view,jankbench,5,mean,0,iter_10,List View
Fling,40.0634874771,
default-jankview_list_view,jankbench,6,mean,0,iter_10,List View
Fling,28.0633472181,
default-jankview_list_view,jankbench,7,mean,0,iter_10,List View
Fling,36.0400585616,
default-jankview_list_view,jankbench,8,mean,0,iter_10,List View
Fling,38.1871234374,
default-jankview_list_view,jankbench,9,mean,0,iter_10,List View
Fling,37.4103602014,
default-jankview_list_view,jankbench,10,mean,0,iter_10,List View
Fling,40.7147881231,


Though I'll spend some more time looking at it closer.

thanks
-john
