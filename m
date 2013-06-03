From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 3 Jun 2013 21:11:13 +0200
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130603180339.GN3803@titan.lakedaemon.net>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130529110508.GH17767@MacBook-Pro.local>
 <20130529191657.GA13047@schnuecks.de>
 <20130530164335.GK23631@arm.com>
 <20130531120519.GB3803@titan.lakedaemon.net>
 <20130531141508.GB15551@arm.com>
 <20130603173817.GA32211@schnuecks.de>
 <20130603180339.GN3803@titan.lakedaemon.net>
Message-ID: <20130603191113.GA1587@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason, Greg,

On Mon, Jun 03, 2013 at 02:03:39PM -0400, Jason Cooper wrote:
> All,
> 
> Adding gregkh for insight into -stable and applying fixes to previous
> kernels when the bug was not against them (but the offending commit
> exists in them).
> 
> Greg,
> 
> Some history:  This bug stems from attempting to write O_DIRECT to a
> dm-crypt device on ARM architectures.  In my case, it was trying (years
> ago!) to put an LVM into a dm-crypt container.  This data corruption can
> be more readily seen by using dd to write to a dm-crypt device with the
> direct flag.

Some more history: The bug Jason describes is a regression that
appeared in 2.6.37.  However, while fixing it, we think we found a
bug in conjunction with highmem that goes back to 2.6.31 or so.  This
may occur on ARM machines with VIVT D-cache, highmem pages and a
driver using flush_kernel_dcache_page(), but not kmap_atomic().

> ...
> > 
> > The only thing we need to be aware of is the change of
> > flush_kernel_dcache_page() in 2.6.37 (commit f8b63c1).  In earlier
> > versions, we would only need to fix the highmem case.  However, I
> > wonder whether it makes sense to apply a fix to 2.6.32 and 2.6.34
> > without this ever being reported as a problem.
> 
> imho, if you discover a problem while running kernel v3.9.x, and the
> commit causing the problem goes all the way back to 2.6.32, then the fix
> should go back that far as well (assuming those kernels are still
> actively maintained).  I don't think we would need a bug report for each
> kernel version.

For the bug you described that's true. But 2.6.32 and 2.6.34 are not
affected.  The question is whether the other bug requires such an
obscure set of conditions that there are simply no affected machines.


- Simon
