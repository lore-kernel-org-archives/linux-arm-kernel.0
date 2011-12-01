From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Dec 2011 13:26:25 +0000
Subject: [PATCH v2 0/6] Consolidate identity mapping code in idmap.c
In-Reply-To: <20111130221800.GV9581@n2100.arm.linux.org.uk>
References: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
 <20111130221800.GV9581@n2100.arm.linux.org.uk>
Message-ID: <20111201132625.GA27656@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Nov 30, 2011 at 10:18:00PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 28, 2011 at 06:28:51PM +0000, Will Deacon wrote:
> > This is version 2 of the patch series originally posted here:
> > 
> >  http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073033.html
> > 
> > Changes from v1 include:
> > 	* Updated following Catalin's comments
> > 	* Rebased onto rmk/devel-stable
> > 	* Includes update to SMP booting so that the idmap_pgd can be
> > 	  used there too
> > 
> > This is a pre-requisite for my kexec patches, which I will post separately.
> > 
> > All feedback welcome.
> 
> This patch set looks fine.

Great, thanks for looking at it. Here's the pull request against
devel-stable. I can use another commit as a base if you prefer.

Once you've taken this, I'll post another series of my soft reboot patch
series to the list (not required for LPAE but I think it could be merged for
3.3 since it fixes soft reboot along with the reset changes you've made).

Cheers,

Will


The following changes since commit 2d13ccaa8797d7e599f3792aed4b1e44b47f94a5:

  Merge branch 'irqchip-consolidation' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into devel-stable (2011-11-21 21:56:56 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kexec/idmap

Will Deacon (6):
      ARM: idmap: populate identity map pgd at init time using .init.text
      ARM: suspend: use idmap_pgd instead of suspend_pgd
      ARM: proc-*.S: place cpu_reset functions into .idmap.text section
      ARM: idmap: use idmap_pgd when setting up mm for reboot
      ARM: head.S: only include __turn_mmu_on in the initial identity mapping
      ARM: SMP: use idmap_pgd for mapping MMU enable during secondary booting

 arch/arm/include/asm/idmap.h   |   14 +++++++++
 arch/arm/include/asm/pgtable.h |    3 --
 arch/arm/kernel/head.S         |   18 ++++++-----
 arch/arm/kernel/sleep.S        |    2 +
 arch/arm/kernel/smp.c          |   32 +-------------------
 arch/arm/kernel/suspend.c      |   18 ++---------
 arch/arm/kernel/vmlinux.lds.S  |    7 ++++
 arch/arm/mm/idmap.c            |   63 +++++++++++++++++++---------------------
 arch/arm/mm/proc-arm1020.S     |    3 ++
 arch/arm/mm/proc-arm1020e.S    |    3 ++
 arch/arm/mm/proc-arm1022.S     |    3 ++
 arch/arm/mm/proc-arm1026.S     |    3 ++
 arch/arm/mm/proc-arm6_7.S      |    4 ++
 arch/arm/mm/proc-arm720.S      |    3 ++
 arch/arm/mm/proc-arm740.S      |    3 ++
 arch/arm/mm/proc-arm7tdmi.S    |    3 ++
 arch/arm/mm/proc-arm920.S      |    3 ++
 arch/arm/mm/proc-arm922.S      |    3 ++
 arch/arm/mm/proc-arm925.S      |    3 ++
 arch/arm/mm/proc-arm926.S      |    3 ++
 arch/arm/mm/proc-arm940.S      |    3 ++
 arch/arm/mm/proc-arm946.S      |    3 ++
 arch/arm/mm/proc-arm9tdmi.S    |    3 ++
 arch/arm/mm/proc-fa526.S       |    3 ++
 arch/arm/mm/proc-feroceon.S    |    3 ++
 arch/arm/mm/proc-mohawk.S      |    3 ++
 arch/arm/mm/proc-sa110.S       |    3 ++
 arch/arm/mm/proc-sa1100.S      |    3 ++
 arch/arm/mm/proc-v6.S          |    3 ++
 arch/arm/mm/proc-v7.S          |    2 +
 arch/arm/mm/proc-xsc3.S        |    3 ++
 arch/arm/mm/proc-xscale.S      |    3 ++
 32 files changed, 140 insertions(+), 89 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h
