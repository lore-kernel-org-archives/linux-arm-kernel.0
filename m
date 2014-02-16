From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Feb 2014 22:50:00 +0000
Subject: Recent 3.x kernels: Memory leak causing OOMs
In-Reply-To: <alpine.DEB.2.02.1402161406120.26926@chino.kir.corp.google.com>
References: <20140216200503.GN30257@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1402161406120.26926@chino.kir.corp.google.com>
Message-ID: <20140216225000.GO30257@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 02:17:44PM -0800, David Rientjes wrote:
> On Sun, 16 Feb 2014, Russell King - ARM Linux wrote:
> 
> > Mem-info:
> > Normal per-cpu:
> > CPU    0: hi:   42, btch:   7 usd:  36
> > active_anon:28041 inactive_anon:104 isolated_anon:0
> >  active_file:11 inactive_file:11 isolated_file:0
> >  unevictable:0 dirty:1 writeback:6 unstable:0
> >  free:342 slab_reclaimable:170 slab_unreclaimable:570
> >  mapped:13 shmem:139 pagetables:95 bounce:0
> >  free_cma:0
> > Normal free:1368kB min:1384kB low:1728kB high:2076kB active_anon:112164kB inactive_anon:416kB active_file:44kB inactive_file:44kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:131072kB managed:120152kB mlocked:0kB dirty:4kB
> > writeback:24kB mapped:52kB shmem:556kB slab_reclaimable:680kB slab_unreclaimable:2280kB kernel_stack:248kB pagetables:380kB unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:136 all_unreclaimable? yes
> 
> All memory is accounted for here, there appears to be no leakage.
> 
> > [ pid ]   uid  tgid total_vm      rss nr_ptes swapents oom_score_adj name
> ...
> > [  756]     0   756    28163    27776      57        0             0 ld-linux.so.2
> 
> This is taking ~108MB of your ~117MB memory.

Damn, you're right.  I was reading that as kB not pages, which means this
is an /old/ real OOM.  It should only be taking around 30MB.  Sorry for
wasting people's time with that one.

However, that doesn't negate the point which I brought up in my other
mail - I have been chasing a memory leak elsewhere, and I so far have
two dumps off a different machine - both of these logs are from the
same machine, which took 41 days to OOM.

http://www.home.arm.linux.org.uk/~rmk/misc/log-20131228.txt
http://www.home.arm.linux.org.uk/~rmk/misc/log-20140208.txt

Rik van Riel had a look at the second one, and we came to the conclusion
that running kmemleak would be a good idea - which I have been over the
last 7 days and it's found nothing yet.  Both of those OOMs in those logs
required a reboot to recover the machine to a usable state - in the second
one, you could log in but it wasn't pleasant.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
