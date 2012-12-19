From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Dec 2012 11:59:39 +0000
Subject: [RFC] KVM on arm64
Message-ID: <50D1AC2B.4090808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As I'm about to go in turkey mode for a few days, I thought it would
be good to let people have a taste of KVM on arm64. At least for those
who are not following the same path...

So this is the first public drop of KVM/arm64. It supports:
- arm and arm64 guests
- SMP host and guest
- 4kB and 64kB pages (both as a host and as a guest)
- Virtual GIC
- Architected timers

It has been tested on ARMv8 VE model as well as the Foundation Model
(after reworking the DTS), using Will Deacon's excellent port of
kvmtool to arm64 for the platform emulation side (with virtio for
console, block device, networking...). We happily booted guests using
the Linaro OE filesystem (64bit) as well Debian and Ubuntu (32bit).

It reuses a fair amount of the KVM/arm port source code and general
architecture, though there still some work to be done in order to
share more code. It currently relies on so much out of tree code that
I'm not even trying to post the patches, hence merely signaling the
existence of the port.

The code sits in a number of (non-stable) branches at
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git

- kvm-arm64/pre-arm64-cleanup: Christoffer Dall's kvm-arm-master
  branch plus a number of patches reorganizing some parts of the
  KVM/arm code in order to reuse them on arm64.

- kvm-arm64/psci: the above, plus the implementation of the Power
  State Coordination Interface

- kvm-arm64/soc-armv8-kvm: a merge of Catalin Marinas' soc-armv8-model
  branch and the above.

- kvm-arm64/soc-armv8-kvm-prereq: the above, plus a bunch of patches
  adding the KVM prerequisites (including an architected timer rework
  courtesy of Mark Rutland).

- kvm-arm64/soc-armv8-kvm-arm64: The turkey itself.

- kvm-arm64/kvmtool: The above, with stuffing, vegs and gravy. Enjoy.

The soc-armv8-kvm-arm64 branch contains patches that are roughly split
by theme (world switch, MMU, exit handling...), but does not yet
reflect the way I intend to split them before review.

The code is currently based on v3.7 + kvm-next. Don't try it if you're
not prepared to tinker with what is essentially experimental, fast
changing and probably broken code (though my tests seem to show that
it is solid enough. YMMV).

What is missing:
- FP access from userspace
- COMPAT layer for 32bit userspace

As always, comments are welcome, though I may be a bit slow to reply...

	M.
-- 
Jazz is not dead. It just smells funny...
