From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Sep 2015 15:24:06 +0200
Subject: [Xen-devel] [PATCH v4 00/20] xen/arm64: Add support for 64KB page
 in Linux
In-Reply-To: <55F819A1.8070609@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <2415578.qstFX0Ux2G@wuerfel> <55F819A1.8070609@citrix.com>
Message-ID: <1539842.T2XY1FNaDl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 September 2015 14:14:09 David Vrabel wrote:
> On 14/09/15 12:32, Arnd Bergmann wrote:
> > On Monday 14 September 2015 13:04:59 Roger Pau Monn? wrote:
> >>> TBH, I'm expecting a small impact to the performance. It would be hard
> >>> to get the exactly the same performance as today if we keep the helpers
> >>> to avoid the backend dealing himself with the splitting and page
> >>> granularity.
> >>>
> >>> Although, if the performance impact is not acceptable, it may be
> >>> possible to optimize gnttab_foreach_grant_in_range by moving the
> >>> function inline. The current way to the loop is the fastest I've found
> >>> (I've wrote a small program to test different way) and we will need it
> >>> when different of size will be supported.
> >>
> >> I don't expect the performance to drop massively with this patches
> >> applied, but it would be good to al least have an idea of the impact.
> > 
> > Note that using 64kb pages in Linux tends to destroy performance
> > in Linux in any case, as the memory consumption for most workloads
> > explodes. In a virtualized environment you already tend to be
> > memory constrained, so any measurement should take that into account
> > and put the extra overhead into perspective to the massive overhead
> > of running 64kb pages when RAM is tight.
> 
> If this is the case, why are some distros using 64 KiB pages then?

I believe that IBM started this on PowerPC64 when they found that it
performs better in microbenchmarks and for certain database workloads
when you do have enough memory and do not work with small files or
many processes.

I also believe that the AIX memory management code is designed differently
enough that it suffers less from large pages (or suffers more from
small pages), so the hardware designers pushed Linux to do the same as AIX.

Why you'd do it on ARM64 I have no idea at all, other than copying what
IBM did on PowerPC. If your TLB is too small, hardware designers may
of course try to push the OS to using pages as large as possible for the
low-level benchmarks to suck less, but in general, you'd be better off
with transparent hugepages and 4kb or 8kb pages for real workloads.

	Arnd
