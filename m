From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 13 Oct 2011 14:31:32 -0700
Subject: [PATCH v3.1-rc9] ARM: populate processor tag in proc-cpuinfo
	for Uni-processor.
In-Reply-To: <20111013210336.GO21648@n2100.arm.linux.org.uk>
References: <1318520590-24372-1-git-send-email-srinivas.kandagatla@st.com>
	<20111013164822.GJ21648@n2100.arm.linux.org.uk>
	<20111013135234.49f2d400.akpm@linux-foundation.org>
	<20111013210336.GO21648@n2100.arm.linux.org.uk>
Message-ID: <20111013143132.ef96905e.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011 22:03:36 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Oct 13, 2011 at 01:52:34PM -0700, Andrew Morton wrote:
> > On Thu, 13 Oct 2011 17:48:22 +0100
> > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > 
> > > On Thu, Oct 13, 2011 at 04:43:10PM +0100, Srinivas KANDAGATLA wrote:
> > > > We recently encountered issue while running cyclesoak on ARM-uniprocessor
> > > > system, What we have noticed it that /proc/cpuinfo does not have
> > > > "processor" tag when its uniprocessor, which looked incorrect.
> > > > All the processors code in kernel do populate this tag for both uni and
> > > > multi processor systems.
> > > > 
> > > > This patch just add processor tag for cpuinfo for ARM uni-processor systems.
> > > 
> > > I wonder why cyclesoak doesn't use the sysconf(_SC_NPROCESSORS_ONLN)
> > > rather than implementing this functionality itself.
> > > 
> > > akpm?
> > 
> > eep, cyclesoak will soon be celebrating its eleventh birthday. 
> > sysconf(_SC_NPROCESSORS_ONLN) might have existed back in those days,
> > but I sure didn't know about it!
> 
> Do you have any opinion on the related issue of whether uniprocessor
> kernels should include a 'processor: 0' line in their /proc/cpuinfo
> to satisfy programs such as cyclesoak ?

I think it would be best to do what x86 does, and x86 appears to do
"processor\t: %u" even for uniprocessor.  Plus that makes UP and SMP
more consistent.

But there isn't much consistency here. 
arch/openrisc/kernel/setup.c:show_cpuinfo() sprays out stuff which is
very different from x86.
