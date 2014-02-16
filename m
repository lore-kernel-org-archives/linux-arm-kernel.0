From: rientjes@google.com (David Rientjes)
Date: Sun, 16 Feb 2014 15:42:46 -0800 (PST)
Subject: Recent 3.x kernels: Memory leak causing OOMs
In-Reply-To: <20140216225000.GO30257@n2100.arm.linux.org.uk>
References: <20140216200503.GN30257@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1402161406120.26926@chino.kir.corp.google.com>
 <20140216225000.GO30257@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1402161531380.10992@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 16 Feb 2014, Russell King - ARM Linux wrote:

> However, that doesn't negate the point which I brought up in my other
> mail - I have been chasing a memory leak elsewhere, and I so far have
> two dumps off a different machine - both of these logs are from the
> same machine, which took 41 days to OOM.
> 
> http://www.home.arm.linux.org.uk/~rmk/misc/log-20131228.txt
> http://www.home.arm.linux.org.uk/~rmk/misc/log-20140208.txt
> 

You actually have free memory in both of these, the problem is 
fragmentation: the first log shows oom kills where order=2 and the second 
long shows oom kills where order=3.

If I look at an example from the second log:

Normal free:35052kB min:1416kB low:1768kB high:2124kB active_anon:28kB 
inactive_anon:60kB active_file:140kB inactive_file:140kB unevictable:0kB 
isolated(anon):0kB isolated(file):0kB present:131072kB managed:125848kB 
mlocked:0kB dirty:0kB writeback:40kB mapped:0kB shmem:0kB 
slab_reclaimable:3024kB slab_unreclaimable:9036kB kernel_stack:1248kB 
pagetables:1696kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB 
pages_scanned:574 all_unreclaimable? yes

you definitely are missing memory somewhere, but I'm not sure it's going 
to be detected by kmemleak since the slab stats aren't very high.  The 
system has ~123MB of memory, ~34.5MB is user or free memory, ~12MB is 
slab, and ~3MB for stack and pagetables means you're missing over half of 
your memory somewhere.  There's types of memory that isn't shown here for 
things like vmalloc(), things that call alloc_pages() directly, hugepages, 
etc.

You also have a lot of swap available:

Free swap  = 1011476kB
Total swap = 1049256kB

These ooms are coming from the high-order sk_page_frag_refill() which has 
been changed recently to fallback without calling the oom killer, you'll 
need commit ed98df3361f0 ("net: use __GFP_NORETRY for high order 
allocations") that Linus merged about 1.5 weeks ago.

So I'd recommend forgetting about kmemleak here, try a kernel with that 
commit to avoid the oom killing, and then capture /proc/meminfo at regular 
intervals to see if something continuously grows that isn't captured in 
the oom log.
