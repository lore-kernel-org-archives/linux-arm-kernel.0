From: rppt@linux.vnet.ibm.com (Mike Rapoport)
Date: Fri, 21 Sep 2018 11:16:27 +0300
Subject: KSM not working in 4.9 Kernel
In-Reply-To: <CAOuPNLiqntJspBgAyP4OSEiajbg1mWmeFBb6j4akPp-OULQpUw@mail.gmail.com>
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
 <20180916153237.GC15699@rapoport-lnx>
 <CAOuPNLj0HyC+yzwTpN-EWpzHTJ58u7pBfOja1MyweF4pbct1eQ@mail.gmail.com>
 <20180917043724.GA12866@rapoport-lnx>
 <CAOuPNLidXFHgkBmwOPj_xFkU_OpLaXbpJg04Le7MPxu8cYg_RQ@mail.gmail.com>
 <CAOuPNLj+4pMnEy5EyZmzDWszqMb_PQb3q7t_hvG_50BTz1He2Q@mail.gmail.com>
 <20180917145936.GA20945@rapoport-lnx>
 <CAOuPNLiqntJspBgAyP4OSEiajbg1mWmeFBb6j4akPp-OULQpUw@mail.gmail.com>
Message-ID: <20180921081626.GA12492@rapoport-lnx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 05:21:20PM +0530, Pintu Kumar wrote:
> Hi,
> 
> Thank you so much for all your reply so far.
> I have few more doubts to understand the output from ksm sysfs.
> Device: Hikey620 - ARM64 - Linux 4.9.20
> With HUGE page enabled:
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> 
> Currently, I get this output, when I run below program with ksm:
> 
> ~ # grep -H '' /sys/kernel/mm/ksm/*
> /sys/kernel/mm/ksm/full_scans:29
> /sys/kernel/mm/ksm/page_comparisons:39584
> /sys/kernel/mm/ksm/pages_hashed:11672
> /sys/kernel/mm/ksm/pages_scanned:21766
> /sys/kernel/mm/ksm/pages_shared:3
> /sys/kernel/mm/ksm/pages_sharing:10097
> /sys/kernel/mm/ksm/pages_to_scan:200
> /sys/kernel/mm/ksm/pages_unshared:53
> /sys/kernel/mm/ksm/pages_volatile:1
> /sys/kernel/mm/ksm/run:0
> /sys/kernel/mm/ksm/sleep_millisecs:1000
> ---------------------------
> 
> int main(int argc, char *argv[])
> {
>         int i, n, size, ret;
>         char *buffer;
>         void *addr;
> 
>         n = 100;
>         size = 100 * getpagesize();
>         for (i = 0; i < n; i++) {
>                 buffer = (char *)malloc(size);
>                 memset(buffer, 0xff, size);
>                 madvise(buffer, size, MADV_MERGEABLE);
>                 if (ret < 0) {
>                         fprintf(stderr, "malloc madvise failed: ret:
> %d, reason: %s\n", ret, strerror(errno));
>                 }
>                 usleep(500);
>         }
>         printf("Done....press ^C\n");
>         pause();
>         return 0;
> }
> Note: madvise() system call is not failing here, as mentioned earlier.
> I guess the page is aligned with getpagesize().
> Then I do this to invoke ksm:
> # echo 1 > /sys/kernel/mm/ksm/run
> # ./malloc-test.out &
> # sleep 5
> # echo 0 > /sys/kernel/mm/ksm/run
> #
> 
> Also, the anon pages in the system shows like this:
> BEFORE:
> -------------
> ~ # cat /proc/meminfo | grep -i anon
> Active(anon):      40740 kB
> Inactive(anon):        0 kB
> AnonPages:         40760 kB
> AnonHugePages:         0 kB
> 
> AFTER MERGING:
> --------------------------
> ~ # cat /proc/meminfo | grep -i anon
> Active(anon):        440 kB
> Inactive(anon):        0 kB
> AnonPages:           188 kB
> AnonHugePages:         0 kB
> 
> I want to understand the KSM output w.r.t to the above program, and
> cross-check if the output is correct.
> Can someone help me to understand it?
> 
> As of now, what I understood is that:
> - I am allocating around 400KB of memory 100 times. That is: 100 * 100
> * 4K = 10000 pages (which are all with similar content).
> - Output says: 10097 page_sharing happened.
> - Pages currently shared is: 3
> - So total pages are: 10097 + 3 = 10100
> 
> I could not understand from where the additional 100 pages came from?
> Also, why some pages are shown as: pages_unshared ?
> What can I interpret from this?
> And, what does it mean by: pages_volatile:1 ?
> 
> Basically, I wanted to understand, is there any problem with the above
> output, or it is fine.
> If it is fine, how to prove it?

The ksm sysfs attributes are described at
Documentation/admin-guide/mm/ksm.rst or online at [1].

The numbers look sane in general. The additional pages may come from malloc
metadata that is created by libc when you allocate memory.

I'd recommend to use mmap() or posix_memalign() with page size alignment to
get exact amount of page aligned memory.

[1] https://www.kernel.org/doc/html/latest/admin-guide/mm/ksm.html
 
 
 
> Thanks,
> Pintu
> 
> On Mon, Sep 17, 2018 at 8:29 PM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >
> > On Mon, Sep 17, 2018 at 05:25:27PM +0530, Pintu Kumar wrote:
> > > On Mon, Sep 17, 2018 at 11:46 AM Pintu Kumar <pintu.ping@gmail.com> wrote:
> > > > > > But still no effect.
> > > > > > And I checked LTP test cases. It almost doing the same thing.
> > > > > >
> > > > > > I observed that [ksmd] thread is not waking up at all.
> > > > > > I gave some print inside it, but I could never saw that prints coming.
> > > > > > I could not find it running either in top command during the operation.
> > > > > > Is there anything needs to be done, to wakw up ksmd?
> > > > > > I already set: echo 1 > /sys/kernel/mm/ksm.
> > > > >
> > > > > It should be echo 1 > /sys/kernel/mm/ksm/run
> > > > >
> > > >
> > > > Oh yes, sorry for the typo.
> > > > I tried the same, but still ksm is not getting invoked.
> > > > Could someone confirm if KSM was working in 4.9 kernel?
> > > >
> > >
> > > Ok, it's working now. I have to explicitly stop the ksm thread to see
> > > the statistics.
> > > Also there was some internal patch that was setting vm_flags to
> > > VM_MERGABLE thus causing ksm_advise call to return.
> > >
> > > # echo 1 > /sys/kernel/mm/ksm/run
> > > # ./malloc-test.out &
> > > # echo 0 > /sys/kernel/mm/ksm/run
> > >
> > > ~ # grep -H '' /sys/kernel/mm/ksm/*
> > > /sys/kernel/mm/ksm/full_scans:105
> > > /sys/kernel/mm/ksm/pages_shared:1
> > > /sys/kernel/mm/ksm/pages_sharing:999
> > > /sys/kernel/mm/ksm/pages_to_scan:100
> > > /sys/kernel/mm/ksm/pages_unshared:0
> > > /sys/kernel/mm/ksm/pages_volatile:0
> > > /sys/kernel/mm/ksm/run:0
> > > /sys/kernel/mm/ksm/sleep_millisecs:20
> > >
> > >
> > > However, I have one doubt.
> > > Is the above data correct, for the below program?
> >
> > You have 1 shared page and 999 additional references to that page
> >
> > > int main(int argc, char *argv[])
> > > {
> > >         int i, n, size, ret;
> > >         char *buffer;
> > >         void *addr;
> > >
> > >         n = 10;
> > >         size = 100 * getpagesize();
> > >         for (i = 0; i < n; i++) {
> > >                 buffer = (char *)malloc(size);
> > >                 memset(buffer, 0xff, size);
> > >                 madvise(buffer, size, MADV_MERGEABLE);o
> >
> > This madvise() call should fail because buffer won't be page aligned
> >
> > >                 addr =  mmap(NULL, size,
> > >                            PROT_READ | PROT_EXEC | PROT_WRITE,
> > > MAP_PRIVATE | MAP_ANONYMOUS,
> > >                            -1, 0);
> > >                 memset(addr, 0xff, size);
> > >                 ret = madvise(addr, size, MADV_MERGEABLE);
> > >                 if (ret < 0) {
> > >                         fprintf(stderr, "madvise failed: ret: %d,
> > > reason: %s\n", ret, strerror(errno));
> > >                 }
> > >                 usleep(500);
> > >         }
> > >         printf("Done....press ^C\n");
> > >
> > >         pause();
> > >
> > >         return 0;
> > > }
> > >
> > >
> > > Thanks,
> > > Pintu
> > >
> >
> > --
> > Sincerely yours,
> > Mike.
> >
> 

-- 
Sincerely yours,
Mike.
