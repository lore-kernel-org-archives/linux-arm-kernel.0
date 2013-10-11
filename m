From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:28 +0100
Subject: [PATCH 0/7] kvmtool: handle guests of a different endianness
Message-ID: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds some infrastructure to kvmtool to allow a BE
guest to use virtio-mmio on a LE host, provided that the architecture
actually supports such madness.

Not all the backend have been converted, only those I actually cared
about. Converting them is pretty easy though, and will be done if the
method is deemed acceptable.

This has been tested on arm64, with some fixes to KVM and a set of
changes to virtio, both which I am posting separately.

A branch containing all the relevant changes is at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/be-on-le-3.12-rc4

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>

Marc Zyngier (7):
  kvmtool: virt_queue configuration based on endianness
  kvmtool: virt_queue: handle guest endianness
  kvmtool: convert console backend to support bi-endianness
  kvmtool: convert 9p backend to support bi-endianness
  kvmtool: convert blk backend to support bi-endianness
  kvmtool: convert net backend to support bi-endianness
  kvmtool: virtio: enable arm/arm64 support for bi-endianness

 tools/kvm/arm/include/arm-common/kvm-arch.h |   2 +
 tools/kvm/include/kvm/virtio.h              | 198 +++++++++++++++++++++++++++-
 tools/kvm/virtio/9p.c                       |   5 +-
 tools/kvm/virtio/blk.c                      |  34 ++++-
 tools/kvm/virtio/console.c                  |  12 +-
 tools/kvm/virtio/core.c                     |  59 +++++----
 tools/kvm/virtio/net.c                      |  17 ++-
 7 files changed, 286 insertions(+), 41 deletions(-)

-- 
1.8.2.3
