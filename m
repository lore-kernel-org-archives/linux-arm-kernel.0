From: labbott@redhat.com (Laura Abbott)
Date: Tue,  3 Jul 2018 16:34:26 -0700
Subject: [PATCHv5 0/4] Salted build ids via ELF notes
Message-ID: <20180703233430.14416-1-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is v5 of the series to allow unique build ids in the kernel. As a
reminder of the context:

""
In Fedora, the debug information is packaged separately (foo-debuginfo) and
can be installed separately. There's been a long standing issue where only one
version of a debuginfo info package can be installed at a time. Mark Wielaard
made an effort for Fedora 27 to allow parallel installation of debuginfo (see
https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
more details)

Part of the requirement to allow this to work is that build ids are
unique between builds. The existing upstream rpm implementation ensures
this by re-calculating the build-id using the version and release as a
seed. This doesn't work 100% for the kernel because of the vDSO which is
its own binary and doesn't get updated. After poking holes in a few of my
ideas, there was a discussion with some people from the binutils team about
adding --build-id-salt to let ld do the calculation debugedit is doing. There
was a counter proposal made to add in the salt while building. The
easiest proposal was to add an item in the linker script vs. linking in
an object since we need the salt to go in every module as well as the
kernel and vmlinux.
""

v5 uses the approach suggested by Masahiro Yamada which uses the
existing ELF note macro to more easily add the salt (vs previous
approaches which tried to adjust via linker section).

If arch maintainers are okay, I'd like acks for this so this can go
through the kbuild tree.

Thanks,
Laura

Laura Abbott (4):
  kbuild: Add build salt to the kernel and modules
  x86: Add build salt to the vDSO
  powerpc: Add build salt to the vDSO
  arm64: Add build salt to the vDSO

 arch/arm64/kernel/vdso/note.S     |  3 +++
 arch/powerpc/kernel/vdso32/note.S |  3 +++
 arch/x86/entry/vdso/vdso-note.S   |  3 +++
 arch/x86/entry/vdso/vdso32/note.S |  3 +++
 include/linux/build-salt.h        | 20 ++++++++++++++++++++
 init/Kconfig                      |  9 +++++++++
 init/version.c                    |  3 +++
 scripts/mod/modpost.c             |  3 +++
 8 files changed, 47 insertions(+)
 create mode 100644 include/linux/build-salt.h

-- 
2.17.1
