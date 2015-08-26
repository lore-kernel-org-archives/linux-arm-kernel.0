From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 26 Aug 2015 08:36:29 -0700
Subject: Build error in -next with gcc 4.9.1+ due to 'ARM: software-based
 priviledged-no-access support'
Message-ID: <55DDDCFD.7040208@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

your patch 'ARM: software-based priviledged-no-access support' results in an internal
gcc error when trying to build arm:rpc_defconfig with gcc version 4.9.1 and 4.9.2.

fs/fat/dir.c: In function 'fat_ioctl_filldir':
fs/fat/dir.c:752:43: internal compiler error: Max. number of generated reload insns per insn is achieved (90)

  FAT_IOCTL_FILLDIR_FUNC(fat_ioctl_filldir, __fat_dirent)
                                            ^
fs/fat/dir.c:707:9: note: in definition of macro 'FAT_IOCTL_FILLDIR_FUNC'
   struct dirent_type __user *d2 = d1 + 1;       \
          ^

This is with yocto/poky toolchains (version 1.7 for gcc 4.9.1 and 1.8 for gcc 4.9.2).
The error is not seen with gcc 4.7.2 (from yocto/poky 1.4.2).

Guenter

---
bisect log:

# bad: [4aae1afc9fcd8fce05c9c429bf46991166aa14b6] Add linux-next specific files for 20150826
# good: [c13dcf9f2d6f5f06ef1bf79ec456df614c5e058b] Linux 4.2-rc8
git bisect start 'HEAD' 'v4.2-rc8'
# bad: [72fc9ce3821064893ae82c94da877437f2ccf2ea] Merge remote-tracking branch 'crypto/master'
git bisect bad 72fc9ce3821064893ae82c94da877437f2ccf2ea
# bad: [364353176f56b287fe8a8a12cc33d6e6ae62cb84] Merge remote-tracking branch 'hid/for-next'
git bisect bad 364353176f56b287fe8a8a12cc33d6e6ae62cb84
# bad: [bf7be12bfc48f8429596f2c2df8e9ad1c88b0923] Merge remote-tracking branch 'tegra/for-next'
git bisect bad bf7be12bfc48f8429596f2c2df8e9ad1c88b0923
# good: [5908b2fba50b28d1435f15a2c5edb346677172ed] Merge branch 'next/dt' into for-next
git bisect good 5908b2fba50b28d1435f15a2c5edb346677172ed
# good: [9a1d1799d5acbc961fbabdeaaac1bee31a84484e] Merge branch 'next/soc' into for-next
git bisect good 9a1d1799d5acbc961fbabdeaaac1bee31a84484e
# bad: [803f911c33ce5ba474335757ac6ddac5fafc4118] Merge remote-tracking branch 'arm-soc/for-next'
git bisect bad 803f911c33ce5ba474335757ac6ddac5fafc4118
# bad: [2a3639fea519310619e803414e565a3d3c875258] Merge branch 'drm-dwhdmi-devel' into for-next
git bisect bad 2a3639fea519310619e803414e565a3d3c875258
# bad: [42050b2a875fbe66f2cbef9a0b8fdb24f70b6b9a] Merge branches 'cleanup', 'fixes', 'fiq' (early part), 'misc', 'omap-barrier', 'pcmcia' and 'uaccess' into for-next
git bisect bad 42050b2a875fbe66f2cbef9a0b8fdb24f70b6b9a
# good: [9205b797dbe519a629267ec8c5766cd973d35063] ARM: 8421/1: smp: Collapse arch_cpu_idle_dead() into cpu_die()
git bisect good 9205b797dbe519a629267ec8c5766cd973d35063
# bad: [a2421d7da31d098570059007f6f7e290420034ee] ARM: software-based priviledged-no-access support
git bisect bad a2421d7da31d098570059007f6f7e290420034ee
# good: [a02d8dfd54cdf3b1b0464ccc2c1c4afe2c003a35] ARM: domains: keep vectors in separate domain
git bisect good a02d8dfd54cdf3b1b0464ccc2c1c4afe2c003a35
# good: [08446b129bbde34665c423d882f857a45b8c3aed] ARM: mm: improve do_ldrd_abort macro
git bisect good 08446b129bbde34665c423d882f857a45b8c3aed
# good: [c043dd6568a98f105e62b03481dff047ebcb3585] ARM: entry: provide uaccess assembly macro hooks
git bisect good c043dd6568a98f105e62b03481dff047ebcb3585
# first bad commit: [a2421d7da31d098570059007f6f7e290420034ee] ARM: software-based priviledged-no-access support
