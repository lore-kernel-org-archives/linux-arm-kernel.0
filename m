From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Apr 2015 12:24:31 +0100
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <35FD53F367049845BC99AC72306C23D104A310D42397@CNBJMBX05.corpusers.net>
References: <54D40DAF.4080609@codeaurora.org>
 <CADtm3G7ROX4CrxSKRvTKcjqCiX=uJQZ=Q5izH8pS61z4jfumLg@mail.gmail.com>
 <54D534FB.1090101@codeaurora.org>
 <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
 <20150210113230.GJ8656@n2100.arm.linux.org.uk>
 <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
 <20150326114612.GD8656@n2100.arm.linux.org.uk>
 <20150326123028.GM4701@suse.de>
 <CADtm3G4Lb=u+BAHZF+O+RgB4VS9iW8epCPJ9ssBTj=+p3+h==Q@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D104A310D42397@CNBJMBX05.corpusers.net>
Message-ID: <20150410112430.GB12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 01:18:04PM +0800, Wang, Yalin wrote:
> > [   12.212102] active_anon:734 inactive_anon:1189 isolated_anon:0
> > [   12.212102]  active_file:0 inactive_file:0 isolated_file:0
> > [   12.212102]  unevictable:0 dirty:0 writeback:0 unstable:0
> > [   12.212102]  free:254104 slab_reclaimable:82 slab_unreclaimable:843

Here, we have 82 pages reclaimable, which is 328kB, and 843 unreclaimable
which is 3372kB, which is a total of 925 pages.

> > [   12.212102]  mapped:429 shmem:1815 pagetables:13 bounce:0
> > [   12.212102]  free_cma:4032
> > [   12.243172] DMA free:754080kB min:3472kB low:4340kB high:5208kB
> > active_anon:180kB inactive_anon:0kB active_file:0kB inactive_file:0kB
> > unevictable:0kB isolated(anon):0kB isolated(file):0kB present:778240kB
> > managed:759252kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB
> > shmem:0kB slab_reclaimable:328kB slab_unreclaimable:3372kB

Which agrees here.

> > [   12.401609] 834 slab pages

but not here... this is an interesting difference, because in the ARM
version of show_mem(), we count the actual number of pages where
PageSlab() returns true.  Can slab pages also be reserved pages or
swap cache pages?  I thought they were exclusive of those.  So, the
question comes... why the difference in accounting, and which one is
correct.

Maybe there's a bug in the accounting somewhere...

So I think we're not ready for this patch to be merged yet.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
