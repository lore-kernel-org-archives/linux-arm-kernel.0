From: rppt@linux.vnet.ibm.com (Mike Rapoport)
Date: Sun, 16 Sep 2018 18:32:38 +0300
Subject: KSM not working in 4.9 Kernel
In-Reply-To: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
Message-ID: <20180916153237.GC15699@rapoport-lnx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 07:58:01PM +0530, Pintu Kumar wrote:
> Hi All,
> 
> Board: Hikey620 ARM64
> Kernel: 4.9.20
> 
> I am trying to verify KSM (Kernel Same Page Merging) functionality on
> 4.9 Kernel using "mmap" and madvise user space test utility.
> But to my observation, it seems KSM is not working for me.
> CONFIG_KSM=y is enabled in kernel.
> ksm_init is also called during boot up.
>   443 ?        SN     0:00 [ksmd]
> 
> ksmd thread is also running.
> 
> However, when I see the sysfs, no values are written.
> ~ # grep -H '' /sys/kernel/mm/ksm/*
> /sys/kernel/mm/ksm/pages_hashed:0
> /sys/kernel/mm/ksm/pages_scanned:0
> /sys/kernel/mm/ksm/pages_shared:0
> /sys/kernel/mm/ksm/pages_sharing:0
> /sys/kernel/mm/ksm/pages_to_scan:200
> /sys/kernel/mm/ksm/pages_unshared:0
> /sys/kernel/mm/ksm/pages_volatile:0
> /sys/kernel/mm/ksm/run:1
> /sys/kernel/mm/ksm/sleep_millisecs:1000
> 
> So, please let me know if I am doing any thing wrong.
> 
> This is the test utility:
> int main(int argc, char *argv[])
> {
>         int i, n, size;
>         char *buffer;
>         void *addr;
> 
>         n = 100;
>         size = 100 * getpagesize();
>         for (i = 0; i < n; i++) {
>                 buffer = (char *)malloc(size);
>                 memset(buffer, 0xff, size);
>                 addr =  mmap(NULL, size,
>                            PROT_READ | PROT_EXEC | PROT_WRITE,
> MAP_PRIVATE | MAP_ANONYMOUS,
>                            -1, 0);
>                 madvise(addr, size, MADV_MERGEABLE);

Just mmap'ing an area does not allocate any physical pages, so KSM has
nothing to merge.

You need to memset(addr,...) after mmap().

>                 sleep(1);
>         }
>         printf("Done....press ^C\n");
> 
>         pause();
> 
>         return 0;
> }
> 
> 
> 
> Thanks,
> Pintu
> 

-- 
Sincerely yours,
Mike.
