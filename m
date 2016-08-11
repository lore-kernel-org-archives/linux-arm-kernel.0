From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Thu, 11 Aug 2016 20:03:56 -0300
Subject: [PATCH v2 0/2] extend kexec_file_load system call
Message-ID: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is from AKASHI Takahiro. I will use it in my next
version of the kexec_file_load implementation for powerpc, so I am
rebasing it on top of v4.8-rc1.

I dropped the patch which adds __NR_kexec_file_load to
<asm-generic/unistd.h> for simplicity, since the powerpc patches already
add it to powerpc's <asm/unistd.h>. I don't know which approach is
better.

The first patch in this series is unchanged from v1.

The second patch is the same one I posted on July 26th. It has the
following changes from v1:

- Added the arch_kexec_verify_buffer hook, where each architecture can
  verify if the DTB is safe to load.
- Renamed KEXEC_FILE_TYPE_DTB to KEXEC_FILE_TYPE_PARTIAL_DTB.
- Limited max number of fds to KEXEC_SEGMENT_MAX.
- Changed to use fixed size buffer for fdset instead of allocating it.
- Changed to return -EINVAL if an unknown file type is found in fdset.

I am also posting a new version of the kexec_file_load syscall
implementation for powerpc which uses the arch_kexec_verify_buffer hook
to enforce a whitelist of nodes and properties that userspace can pass to
the next kernel, as suggested by Michael Ellerman.

You can find it in a new patch in the powerpc series called
"powerpc: Allow userspace to set device tree properties in kexec_file_load"

Original cover letter:

Device tree blob must be passed to a second kernel on DTB-capable
archs, like powerpc and arm64, but the current kernel interface
lacks this support.

This patch extends kexec_file_load system call by adding an extra
argument to this syscall so that an arbitrary number of file descriptors
can be handed out from user space to the kernel.

See the background [1].

Please note that the new interface looks quite similar to the current
system call, but that it won't always mean that it provides the "binary
compatibility."

[1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html

AKASHI Takahiro (1):
  kexec: add dtb info to struct kimage

Thiago Jung Bauermann (1):
  kexec: extend kexec_file_load system call

 include/linux/fs.h         |  1 +
 include/linux/kexec.h      | 10 ++++--
 include/linux/syscalls.h   |  4 ++-
 include/uapi/linux/kexec.h | 22 ++++++++++++
 kernel/kexec_file.c        | 86 ++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 114 insertions(+), 9 deletions(-)

-- 
1.9.1
