From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 14 Feb 2012 14:28:12 -0500 (EST)
Subject: Cache problems in user space - kernel space communication
In-Reply-To: <CAKPCGKv=ph_KmJ-Lrq20f-cDonJ0kXoC1NAuBr2AHo98ToSnSw@mail.gmail.com>
References: <CAKPCGKt6U6m8cnagCwgzaLB9R8f73KDWmV58W3ifHQ9n-Y7sTw@mail.gmail.com>
 <4541F39E5122A64CA8A7F74880F94E5201E89013BD@MBX14.EXCHPROD.USA.NET>
 <CAKPCGKv=ph_KmJ-Lrq20f-cDonJ0kXoC1NAuBr2AHo98ToSnSw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1202141421080.24536@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Feb 2012, Bart Jonkers wrote:

> On Tue, Feb 14, 2012 at 2:19 PM, Van Schaik, Carl <carl@ok-labs.com> wrote:
> > Looks like you are mapping the same page cached to both kernel and user space (at different virtual addresses). With the VIVT cache, the two mappings will hash differently into the cache and access different cache lines. To successfully work like this on a VIVT cache you need to perform a lot of cache maintenance whenever switching from kernel to user. You would likely rather map the page uncached in both kernel and user to save all the effort.
> >
> 
> This was also our conclusion but we didn't find a way to get the
> memory area uncached for both user and kernel space.
> Can somebody tell me how to do this?

You should allocate your memory using dma_alloc_coherent() or 
dma_alloc_writecombine(), and use dma_mmap_coherent() or 
dma_mmap_writecombine() to map it to user space.  Then your code should 
use dma_free_coherent() to clean up.


Nicolas
