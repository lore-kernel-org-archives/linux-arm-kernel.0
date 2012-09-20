From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Sep 2012 11:25:14 +0100
Subject: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
In-Reply-To: <20120919134658.GA2111@linaro.org>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20120919134658.GA2111@linaro.org>
Message-ID: <20120920102514.GD4588@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 02:46:58PM +0100, Dave Martin wrote:
> On Tue, Sep 18, 2012 at 05:35:33PM +0100, Lorenzo Pieralisi wrote:
> > In processors like A15/A7 L2 cache is unified and integrated within the
> > processor cache hierarchy, so that it is not considered an outer cache
> > anymore. For processors like A15/A7 flush_cache_all() ends up cleaning
> > all cache levels up to Level of Coherency (LoC) that includes
> > the L2 unified cache.
> > 
> > When a single CPU is suspended (CPU idle) a complete L2 clean is not
> > required, so generic cpu_suspend code must clean the data cache using the
> > newly introduced cache LoUIS function.
> 
> For patches 3-5 in this series, we know that the assumption that
> flushing LoUIS is sufficient for safely powering the CPU down is not
> valid in the general case, though we've agreed it's a sensible
> compromise for the CPU variants we know about today.

I agree, but we should also keep in mind that there are suspend and
hotplug finishers where platform specific code can (and should sometimes)
carry out the required operations, if flushing to LoUIS is not sufficient.

Patch 3-5 are there to avoid carrying out heavy cache operations that
are not needed, not to define LoUIS as a sufficient cache level for
powering down a CPU.

Your concern is shared, though.

> 
> I think we do need to document this assumption, though.
> 
> At this point I don't mind whether it appears in code comments or in the
> commit messages.

It is a fair point. I will improve comments in the code and commit logs
for next version.

Lorenzo
