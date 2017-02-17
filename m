From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Feb 2017 12:32:48 +0000
Subject: [BOOTWRAPPER PATCH 0/3] Clean up CPU node management
Message-ID: <1487334771-25789-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bootwrapper still has some hard-coded assumptions regarding the
model, assuming things match the old RTSM VE AEMv8-A model it was
originally written for. Notably, by default it assumes a fixed
configuration of CPU IDs.

We tried to bodge around this with the addition of the --with-cpu-ids
option to the configure script, but in practice this turns out to be
fragile, with a number of non-obvious failure modes.

These patches attempt to fix this properly, by dynamically detecting the
set of CPUs from the DTB provided to the boot wrapper. The newly
redundant --with-cpu-ids option is then removed.

Thanks,
Mark.

Mark Rutland (3):
  FDT.pm: add helper to get untranslated reg
  FDT.pm: add helper to get a node's full path
  Dynamically determine the set of CPUs

 FDT.pm           | 34 ++++++++++++++++++++++++++++++++--
 Makefile.am      | 14 ++++++--------
 addpsci.pl       | 29 +++++++++++++++++++++++++++++
 configure.ac     |  8 --------
 findcpuids.pl    | 32 ++++++++++++++++++++++++++++++++
 gen-cpu-nodes.sh | 24 ------------------------
 6 files changed, 99 insertions(+), 42 deletions(-)
 create mode 100755 addpsci.pl
 create mode 100755 findcpuids.pl
 delete mode 100755 gen-cpu-nodes.sh

-- 
1.9.1
