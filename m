From: rppt@linux.vnet.ibm.com (Mike Rapoport)
Date: Mon, 17 Sep 2018 17:59:36 +0300
Subject: KSM not working in 4.9 Kernel
In-Reply-To: <CAOuPNLj+4pMnEy5EyZmzDWszqMb_PQb3q7t_hvG_50BTz1He2Q@mail.gmail.com>
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
 <20180916153237.GC15699@rapoport-lnx>
 <CAOuPNLj0HyC+yzwTpN-EWpzHTJ58u7pBfOja1MyweF4pbct1eQ@mail.gmail.com>
 <20180917043724.GA12866@rapoport-lnx>
 <CAOuPNLidXFHgkBmwOPj_xFkU_OpLaXbpJg04Le7MPxu8cYg_RQ@mail.gmail.com>
 <CAOuPNLj+4pMnEy5EyZmzDWszqMb_PQb3q7t_hvG_50BTz1He2Q@mail.gmail.com>
Message-ID: <20180917145936.GA20945@rapoport-lnx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 05:25:27PM +0530, Pintu Kumar wrote:
> On Mon, Sep 17, 2018 at 11:46 AM Pintu Kumar <pintu.ping@gmail.com> wrote:
> > > > But still no effect.
> > > > And I checked LTP test cases. It almost doing the same thing.
> > > >
> > > > I observed that [ksmd] thread is not waking up at all.
> > > > I gave some print inside it, but I could never saw that prints coming.
> > > > I could not find it running either in top command during the operation.
> > > > Is there anything needs to be done, to wakw up ksmd?
> > > > I already set: echo 1 > /sys/kernel/mm/ksm.
> > >
> > > It should be echo 1 > /sys/kernel/mm/ksm/run
> > >
> >
> > Oh yes, sorry for the typo.
> > I tried the same, but still ksm is not getting invoked.
> > Could someone confirm if KSM was working in 4.9 kernel?
> >
> 
> Ok, it's working now. I have to explicitly stop the ksm thread to see
> the statistics.
> Also there was some internal patch that was setting vm_flags to
> VM_MERGABLE thus causing ksm_advise call to return.
> 
> # echo 1 > /sys/kernel/mm/ksm/run
> # ./malloc-test.out &
> # echo 0 > /sys/kernel/mm/ksm/run
> 
> ~ # grep -H '' /sys/kernel/mm/ksm/*
> /sys/kernel/mm/ksm/full_scans:105
> /sys/kernel/mm/ksm/pages_shared:1
> /sys/kernel/mm/ksm/pages_sharing:999
> /sys/kernel/mm/ksm/pages_to_scan:100
> /sys/kernel/mm/ksm/pages_unshared:0
> /sys/kernel/mm/ksm/pages_volatile:0
> /sys/kernel/mm/ksm/run:0
> /sys/kernel/mm/ksm/sleep_millisecs:20
> 
> 
> However, I have one doubt.
> Is the above data correct, for the below program?

You have 1 shared page and 999 additional references to that page
 
> int main(int argc, char *argv[])
> {
>         int i, n, size, ret;
>         char *buffer;
>         void *addr;
> 
>         n = 10;
>         size = 100 * getpagesize();
>         for (i = 0; i < n; i++) {
>                 buffer = (char *)malloc(size);
>                 memset(buffer, 0xff, size);
>                 madvise(buffer, size, MADV_MERGEABLE);o

This madvise() call should fail because buffer won't be page aligned

>                 addr =  mmap(NULL, size,
>                            PROT_READ | PROT_EXEC | PROT_WRITE,
> MAP_PRIVATE | MAP_ANONYMOUS,
>                            -1, 0);
>                 memset(addr, 0xff, size);
>                 ret = madvise(addr, size, MADV_MERGEABLE);
>                 if (ret < 0) {
>                         fprintf(stderr, "madvise failed: ret: %d,
> reason: %s\n", ret, strerror(errno));
>                 }
>                 usleep(500);
>         }
>         printf("Done....press ^C\n");
> 
>         pause();
> 
>         return 0;
> }
> 
> 
> Thanks,
> Pintu
> 

-- 
Sincerely yours,
Mike.
