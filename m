From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 24 Apr 2013 00:11:26 -0400 (EDT)
Subject: [PATCH v4 00/15] multi-cluster power management
In-Reply-To: <20130423224441.GZ14496@n2100.arm.linux.org.uk>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <20130423200429.GF5316@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304231657150.17375@syhkavp.arg>
 <20130423214610.GY14496@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304231755370.17375@syhkavp.arg>
 <20130423224441.GZ14496@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304232327120.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Apr 2013, Russell King - ARM Linux wrote:

> On Tue, Apr 23, 2013 at 05:56:03PM -0400, Nicolas Pitre wrote:
> > On Tue, 23 Apr 2013, Russell King - ARM Linux wrote:
> > 
> > > On Tue, Apr 23, 2013 at 05:03:06PM -0400, Nicolas Pitre wrote:
> > > > On Tue, 23 Apr 2013, Russell King - ARM Linux wrote:
> > > > 
> > > > > What I suggest for the time being is to provide new inline function(s)
> > > > > in arch/arm/include/cacheflush.h which are purposed for your application,
> > > > > document them in that file, and call the implementation you're currently
> > > > > using.  That means if we do have to change it in the future (for example,
> > > > > we don't need to do anything in the dcache flushing stuff) we don't have
> > > > > to hunt through all the code to find _your_ different use of that function
> > > > > and fix it - we can just fix it in one place and we have the reference
> > > > > there for what your code expects.
> > > > 
> > > > What about the patch below?  Once you tell me it is fine to you I'll 
> > > > adapt the MCPM series to it.
> > > 
> > > Yes, that looks like a saner solution.  Thanks.
> > 
> > May I add your ACK to the patch?
> 
> Yes, sure.
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.  I've adapted the series to this, and mcpm_set_entry_vector() 
now looks like this:

+extern unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
+
+void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
+{
+	unsigned long val = ptr ? virt_to_phys(ptr) : 0;
+	mcpm_entry_vectors[cluster][cpu] = val;
+	sync_cache_w(&mcpm_entry_vectors[cluster][cpu]);
+}

Similarly for the CCI driver:

+	/*
+	 * Multi-cluster systems may need this data when non-coherent, during
+	 * cluster power-up/power-down. Make sure it reaches main memory:
+	 */
+	sync_cache_w(info);
+	sync_cache_w(&info);

This is also much prettier.

Assorted small changes for comments that followed the v4 post have been 
integrated as well.  I don't think they justify a repost of the whole 
thing though.  They are:

- Replace custom cache sync helpers with the sync_cache_*() ones from 
  cacheflush.h.

- Remove volatile annotations since explicit cache ops act as memory 
  barriers now.

- Rename mcpm_entry.h to mcpm.h since this is not solely about entry but
  more general.

- Export the __CACHE_WRITEBACK_* constants via asm_offsets.h since 
  they're needed by assembly code.

- Add some more comments and clarify some existing ones.

I managed to retest this on RTSM after fighting with the license system.

The latest MCPM patches are available here:

  git://git.linaro.org/people/nico/linux mcpm

Diffstat:

 Documentation/arm/cluster-pm-race-avoidance.txt | 498 ++++++++++++++++++
 Documentation/arm/vlocks.txt                    | 211 ++++++++
 arch/arm/Kconfig                                |   8 +
 arch/arm/common/Makefile                        |   1 +
 arch/arm/common/mcpm_entry.c                    | 263 +++++++++
 arch/arm/common/mcpm_head.S                     | 219 ++++++++
 arch/arm/common/mcpm_platsmp.c                  |  92 ++++
 arch/arm/common/vlock.S                         | 108 ++++
 arch/arm/common/vlock.h                         |  29 +
 arch/arm/include/asm/cacheflush.h               |  75 +++
 arch/arm/include/asm/mcpm.h                     | 209 ++++++++
 arch/arm/kernel/asm-offsets.c                   |   4 +
 12 files changed, 1717 insertions(+)

The corresponding DCSCB support for RTSM is here:

  git://git.linaro.org/people/nico/linux mcpm+dcscb

although that part is probably more suitable for ARM-SOC.

Do you want those patches to be posted again, or should I send a new 
pull request?


Nicolas
