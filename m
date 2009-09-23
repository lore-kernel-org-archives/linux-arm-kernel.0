From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 23 Sep 2009 14:12:23 +0200
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1253702319.23370.47.camel@pc1117.cambridge.arm.com>
References: <20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921213802.GH30821@n2100.arm.linux.org.uk>
	<1253614753.14049.47.camel@pc1117.cambridge.arm.com>
	<1253639843.14049.95.camel@pc1117.cambridge.arm.com>
	<4AB9BA3E.20602@googlemail.com>
	<1253697204.23370.22.camel@pc1117.cambridge.arm.com>
	<1253702319.23370.47.camel@pc1117.cambridge.arm.com>
Message-ID: <19130.4263.228472.651482@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas writes:
 > On Wed, 2009-09-23 at 10:13 +0100, Catalin Marinas wrote:
 > >      1. The patch I just posted which introduces flush_prot_range(). It
 > >         affects generic code but if people here agree with the idea, I'm
 > >         happy to try to push for it upstream. It allows mprotect(rx) to
 > >         flush the caches as some people might expect and doesn't affect
 > >         the fork or mmap performance
 > >      2. Russell's (unposted) patch (or the one above) for flushing the
 > >         D-cache during CoW (no I-cache invalidation necessary). There
 > >         would be a (probably slight) performance drop for applications
 > >         using intensive forking (apache?) but it shouldn't be that
 > >         different from read-allocate caches. The common fork+exec
 > >         combination shouldn't do much CoW so I don't expect this to be
 > >         affected
 > >      3. My initial patch for flush_cache_range but it would be better to
 > >         disable read-implies-exec
 > >      4. Handle the prefetch abort for exec permission and only to the
 > >         flushing there (this patch would be a bit more complicated)
 > 
 > I did some tests with OABI_COMPAT disabled so that read-implies-exec is
 > also disabled. Option 3 above has no noticeable performance drop
 > compared to a vanilla kernel, also with OABI_COMPAT disabled.
 > 
 > Which would make me recommend workaround 3 if OABI compatibility is not
 > required. I'm not sure what Debian or Ubuntu do (I think the latter has
 > OABI_COMPAT disabled). If OABI is required, we should go with 2.
 > 
 > I've spent too much time already on this issue. There are several
 > solutions available, all with drawbacks. If there are no other solutions
 > to be proposed (other than modifying user-space), maybe we should vote
 > on the favourite option.
 > 
 > My vote: 2 (until we no longer have OABI filesystems around)

OABI is obsolete legacy, so while it should (perhaps) be
kept working, it should not be allowed to negatively affect
the performance of pure EABI systems.

If option 3 is best for EABI then that's my vote.
