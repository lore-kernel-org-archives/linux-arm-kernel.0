From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 16:18:45 +0100
Subject: [PATCH v3 0/7] ARM: KVM: Revamping the HYP init code for fun and
 profit
Message-ID: <1365779932-20322-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Over the past few weeks, I've gradually realized how broken our HYP
idmap code is. Badly broken.

The main problem is about supporting CPU hotplug. Imagine a CPU being
initialized normally, running VMs, and then being powered down. So
far, so good. Now mentally bring it back online. The CPU will come
back via the secondary CPU boot path, and then what? We cannot use it
anymore, because we need an idmap which is long gone, and because our
page tables are now live, containing the world-switch code, VM
structures, and other bits and pieces.

Another fun issue is that we don't have any TLB invalidation in the
HYP init code. And guess what? we cannot do it! HYP TLB invalidation
has to occur in HYP, and once we've installed the runtime page tables,
it is already too late. It is actually fairly easy to construct a
scenario where idmap and runtime pages have colliding translations.

The nail on the coffin was provided by Catalin Marinas who told me how
much he disliked the arm64 HYP idmap code, and made me realize that we
already have all the necessary code in arch/arm/kvm/mmu.c. It just
needs a tiny bit of care and affection. With a chainsaw.

The solution to the first two issues is a bit tricky, but doesn't
involve a lot of code. The hotplug problem mandates that we keep two
sets of page tables (boot and runtime). The TLB problem mandates that
we're able to transition from one PGD to another while in HYP,
invalidating the TLBs in the process.

To be able to do this, we need to share a page between the two page
tables. A page that will have the same VA in both configurations. All
we need is a VA that has the following properties:
- This VA can't be used to represent a kernel mapping.
- This VA will not conflict with the physical address of the kernel
  text

The vectors page VA seems to satisfy this requirement:
- The kernel never maps anything else there
- The kernel text being copied at the beginning of the physical
  memory, it is unlikely to use the last 64kB (I doubt we'll ever
  support KVM on a system with something like 4MB of RAM, but patches
  are very welcome).

Let's call this VA the trampoline VA.

Now, we map our init page at 3 locations:
- idmap in the boot pgd
- trampoline VA in the boot pgd
- trampoline VA in the runtime pgd

The init scenario is now the following:
- We jump in HYP with four parameters: boot HYP pgd, runtime HYP pgd,
  runtime stack, runtime vectors
- Enable the MMU with the boot pgd
- Jump to a target into the trampoline page (remember, this is the
  same physical page!)
- Now switch to the runtime pgd (same VA, and still the same physical
  page!)
- Invalidate TLBs
- Set stack and vectors
- Profit! (or eret, if you only care about the code).

Once we have this infrastructure in place, supporting CPU hot-plug is
a piece of cake. Just wire a cpu-notifier in the existing code.

This has been tested on both arm (VE TC2) and arm64 (Foundation Model).

>From v2:
- Fix the HYP page table freeing code by getting rid of it. Our
  stage-2 code does it a lot better, and I'd rather fix bugs only
  once.
- Flush HYP page tables to the Point of Coherency. This ensures that
  the incoming CPU will see the page tables, even with cache disabled
  (spotted by Will).
- Use kmalloc instead of kzalloc for the bounce page (spotted by
  Christoffer).

>From v1:
- Reduce the mandatory alignement of the init code page, and use a
  bounce page if the code is crossing a page boundary.
- Add some more comments to the code (as requested by Christoffer)
- Fixed compilation issue with older toolchains (spotted by Geoff)

Marc Zyngier (7):
  ARM: KVM: simplify HYP mapping population
  ARM: KVM: fix HYP mapping limitations around zero
  ARM: KVM: move to a KVM provided HYP idmap
  ARM: KVM: enforce maximum size for identity mapped code
  ARM: KVM: rework HYP page table freeing
  ARM: KVM: switch to a dual-step HYP init code
  ARM: KVM: perform HYP initilization for hotplugged CPUs

 arch/arm/include/asm/idmap.h    |   1 -
 arch/arm/include/asm/kvm_host.h |  31 +--
 arch/arm/include/asm/kvm_mmu.h  |  28 ++-
 arch/arm/kernel/vmlinux.lds.S   |   7 +-
 arch/arm/kvm/arm.c              |  62 ++++--
 arch/arm/kvm/init.S             |  78 +++++--
 arch/arm/kvm/mmu.c              | 458 +++++++++++++++++++++++-----------------
 arch/arm/mm/idmap.c             |  32 +--
 8 files changed, 407 insertions(+), 290 deletions(-)

-- 
1.8.1.4
