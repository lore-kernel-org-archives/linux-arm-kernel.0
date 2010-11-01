From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Mon, 1 Nov 2010 17:36:52 +0100
Subject: [RFC 0/2] Selective identity mapping for kexec
Message-ID: <1288629414-19406-1-git-send-email-per.xx.fransson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I would appreciate your input on some kexec related changes.

When restarting using the kernel kexec functionality the MMU needs to be turned off.
Any code which does this needs to use identity mapped addresses to get
reliable results. In the ARM kexec case this identity mapping is done:

- using the page table of the current task

- for all addresses normally used by user space, i.e. 0x00000000-PAGE_OFFSET

If kexec is used at a kernel crash to collect a core dump this means that we lose important information.

This is what these patches do:

* Actually turn off the MMU, which has been omitted by mistake, see this post:

    http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/019631.html

* Set up a more selective identity mapping

* Restore the old mapping once the MMU is off


The patch was generated from a linux-next 20101028 with these additional related patches which are in the pipeline:

http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=commit;h=ae360a78f41164e7f9c4cf846696b5b6d8dae5c8
http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=commit;h=2fd8658931193599c867fd6974fa184ec34af16c
http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=commit;h=ae6948048c417d429b8a0f85fad13e483f7cc1a3


Regards,
Per


Per Fransson (2):
  Turn off MMU in cpu_v7_reset
  Selective MMU identity mapping for kexec

 arch/arm/kernel/machine_kexec.c   |   27 +++++++++++++++++++++-
 arch/arm/kernel/relocate_kernel.S |   23 +++++++++++++++++++
 arch/arm/mm/mmu.c                 |   44 +++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S             |    4 +++
 4 files changed, 97 insertions(+), 1 deletions(-)

-- 
1.7.2.2
