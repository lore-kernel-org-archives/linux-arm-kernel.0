From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Oct 2013 15:36:08 +0100
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
Message-ID: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small patch series adds just enough kernel infrastructure and
fixes to allow a BE guest to use virtio-mmio on a LE host, provided
that the host actually supports such madness.

This has been tested on arm64, with some fixes to KVM and a set of
changes to kvmtool, both which I am posting separately.

A branch containing all the relevant changes is at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/be-on-le-3.12-rc4

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Pawel Moll <pawel.moll@arm.com>

Marc Zyngier (3):
  virtio: let the guest report its endianess if advertized by the host
  virtio: mmio: fix signature checking for BE guests
  virtio: mmio: access configuration space as little-endian

 drivers/block/virtio_blk.c             |  6 +--
 drivers/char/virtio_console.c          |  4 +-
 drivers/lguest/lguest_device.c         |  8 +++-
 drivers/net/caif/caif_virtio.c         |  2 +-
 drivers/net/virtio_net.c               |  2 +-
 drivers/remoteproc/remoteproc_virtio.c |  8 +++-
 drivers/s390/kvm/kvm_virtio.c          |  8 +++-
 drivers/s390/kvm/virtio_ccw.c          |  9 +++-
 drivers/scsi/virtio_scsi.c             |  4 +-
 drivers/virtio/virtio_balloon.c        |  8 ++--
 drivers/virtio/virtio_mmio.c           | 88 ++++++++++++++++++++++++++++++----
 drivers/virtio/virtio_pci.c            |  8 +++-
 drivers/virtio/virtio_ring.c           |  8 ++++
 include/linux/virtio_config.h          | 19 ++++----
 include/uapi/linux/virtio_ring.h       |  8 ++++
 net/9p/trans_virtio.c                  |  4 +-
 16 files changed, 150 insertions(+), 44 deletions(-)

-- 
1.8.2.3
