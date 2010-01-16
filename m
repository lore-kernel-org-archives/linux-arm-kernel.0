From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Sat, 16 Jan 2010 13:41:43 +0100
Subject: [RFC] PCMCIA locking updates for 2.6.34
Message-ID: <20100116124143.GA30530@comet.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

on top of what had already been discussed for 2.6.34, here are 12 patches
trying to fix the locking mess the PCMCIA subsystem used to be. As a
side-effect, the PCMCIA ioctl will be disabled for all except the ARM
architecture, and even there you need !SMP and !PREEMPT. Hopefully, we'll be
able to remove the ioctl from ARM too.

Everything is available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git#locking

Dominik Brodowski (12):
      pcmcia: add locking to set_mem_map()
      pcmcia: also lock fake and cache CIS by ops_mutex
      pcmcia: lock ops->set_io_map()
      pcmcia: lock ops->set_socket
      pcmcia: properly lock skt->irq, skt->irq_mask
      pcmcia: protect s->device_count
      pcmcia: add locking to struct pcmcia_socket->pcmcia_state()
      pcmcia: simplify locking
      pcmcia: add locking documentation
      pcmcia: assert locking to struct pcmcia_device
      pcmcia: use mutex for dynid lock
      pcmcia: disable pcmcia ioctl for !ARM

 Documentation/pcmcia/locking.txt |  117 ++++++++++++++++++++++++++++++++
 drivers/pcmcia/Kconfig           |    2 +-
 drivers/pcmcia/cistpl.c          |   24 ++++++-
 drivers/pcmcia/cs.c              |   24 +++++--
 drivers/pcmcia/ds.c              |  138 +++++++++++++++++++++++++-------------
 drivers/pcmcia/pcmcia_ioctl.c    |   11 ++--
 drivers/pcmcia/pcmcia_resource.c |  124 +++++++++++++++++++++++++---------
 drivers/pcmcia/rsrc_mgr.c        |    6 +-
 drivers/pcmcia/rsrc_nonstatic.c  |    8 ++
 drivers/pcmcia/socket_sysfs.c    |    7 +-
 include/pcmcia/ds.h              |    2 +-
 include/pcmcia/ss.h              |    7 ++-
 12 files changed, 369 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/pcmcia/locking.txt

Best,
	Dominik
