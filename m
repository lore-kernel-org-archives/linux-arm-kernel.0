From: msalter@redhat.com (Mark Salter)
Date: Thu, 13 Oct 2011 08:17:47 -0400
Subject: [PATCH] arm: fix handling of nr_cpus
In-Reply-To: <20111012172628.GC21648@n2100.arm.linux.org.uk>
References: <1318339864-32396-1-git-send-email-msalter@redhat.com>
	<20111012172628.GC21648@n2100.arm.linux.org.uk>
Message-ID: <1318508268.2300.67.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-10-12 at 18:26 +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 11, 2011 at 09:31:04AM -0400, Mark Salter wrote:
> > The current code duplicates the setup of the cpu_possible bitmap in the
> > platform smp_init_cpus() function. Unfortunately, all of those places
> > have the same bug where the nr_cpus kernel parameter is ignored. This patch
> > consolidates the duplicated code in one place and fixes it to honor the
> > nr_cpus parameter. This is accomplished by having smp_init_cpus() return
> > the platform specific number of cores so that the caller (setup_arch) can
> > set up the cpu_possible bitmap correctly for all platforms.
> 
> Who says every platform we're going to see will always have CPUs 0..N ?
> It's entirely possible that someone might want to have CPUs 0, 2, 3 as
> possible CPUs but omit CPU1 for platform reasons.

Good point. We could do that by not setting the cpu_present bit for the
CPU we want to omit. Or we could leave the current platform cpu_possible
setup as-is and add something like:

   for (i = nr_cpu_ids; i < NR_CPUS; i++)
       set_cpu_possible(i, false);

to setup_arch after the call to smp_init_cpus.

--Mark
