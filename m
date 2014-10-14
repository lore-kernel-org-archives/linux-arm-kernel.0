From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 13 Oct 2014 23:00:08 -0700
Subject: [PATCH] arm64: compat: fix compat types affecting struct
 compat_elf_prpsinfo
Message-ID: <1413266408-32650-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[sorry, it is resend: fixed cover-latter email subject line]

Hi,

I've run into this issue while running gdb testsuite in aarch32 
rootfs on top of V8 kernel. It turns out that V8 kernel
when write core file creates NT_PRPSINFO of wrong size.
Core file psinfo note created by V7 kernel size is 124, but 
V8 when creates aarch32 process core for psinfo note is puts 
size as 128.

Root cause is that __compat_ui d_t and __compat_gid_t types defined
as u32 but corresponding fields types in V7 case are u16. As result
V8 sizeof(struct compat_elf_prpsinfo) is 128, whereas V7 
sizeof(struct elf_prpsinfo) is 124.

Below are test case that illustrate the issue in the way how 
it manifests itself in user visible form: gdb fails to display what
executable crashed (PRPSINFO.command) and 'file' over core cannot
display crashed executable name either. Test case is followed by 
similar commands executed in V7 rootfs/kernel. And it follows 
with rerunning test case on top of kernel that contains fix that.

Proposed fix changes __compat_uid_t and __compat_gid_t typedefs
to u16, so layout of V8 struct compat_elf_prpsinfo matches 
layout of V7 struct elf_prpsinfo. Note as result of the fix
some other compat structures like compat_ipc_perm, compat_msqid_ds,
compat_semid_ds, compat_shmid_ds change their size because
they use fields of __compat_uid_t and __compat_gid_t types.
And after the fix they match their V7 counterparts, as they were
not before. I strongly believe such change is the right thing,
although I don't know how to test those directly.

Thanks,
Victor

aarch32 process core file (before fix)
--------------------------------------

In below output note gdb failed to indicate 'Core was generated 
by `/home/root/cf/cf' and 'file core' command does not test what process
created core file.

root at genericarmv7a:~/cf# uname -a
Linux genericarmv7a 3.17.0 #1 SMP PREEMPT Sat Oct 11 22:44:23 PDT 2014 aarch64 GNU/Linux
root at genericarmv7a:~/cf# pwd
/home/root/cf
root at genericarmv7a:~/cf# ls
cf.c
root at genericarmv7a:~/cf# cat cf.c
#include <stdlib.h>

int main (void)
{
	abort();
	return 0;
}
root at genericarmv7a:~/cf# gcc -g -o cf cf.c
root at genericarmv7a:~/cf# ulimit -c unlimited
root at genericarmv7a:~/cf# ls
cf  cf.c
root at genericarmv7a:~/cf# /home/root/cf/cf
Aborted (core dumped)
root at genericarmv7a:~/cf# ls
cf  cf.c  core
root at genericarmv7a:~/cf# gdb -core=./core
GNU gdb (Linaro GDB) 7.6.1-2013.10
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-oe-linux-gnueabi".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>.
[New LWP 970]
Program terminated with signal 6, Aborted.
#0  0xf72a2ed4 in ?? ()
(gdb) info shared
No shared libraries loaded at this time.
(gdb) quit
root at genericarmv7a:~/cf# file core
core: ELF 32-bit LSB core file ARM, version 1 (SYSV), SVR4-style
root at genericarmv7a:~/cf# readelf --notes core | head -10

Displaying notes found at file offset 0x000001f4 with length 0x000003d8:
  Owner                 Data size	Description
  CORE                 0x00000094	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000080	NT_PRPSINFO (prpsinfo structure) <---- size of note is 0x80
  CORE                 0x00000080	NT_SIGINFO (siginfo_t data)
  CORE                 0x00000098	NT_AUXV (auxiliary vector)
  CORE                 0x00000146	NT_FILE (mapped files)
    Page size: 4096
         Start         End Page Offset


v7 process core file
--------------------

Here is how it is supposed to look. Note 'Core was generated 
by `/home/root/cf/cf' output and note difference in output of 'file
core' command.

root at genericarmv7a:~/cf# uname -a
Linux genericarmv7a 3.17.0-rc7 #1 SMP Tue Sep 30 22:11:51 PDT 2014 armv7l GNU/Linux
root at genericarmv7a:~/cf# pwd
/home/root/cf
root at genericarmv7a:~/cf# ls
cf.c
root@genericarmv7a:~/cf# cat cf.c
#include <stdlib.h>

int main (void)
{
	abort();
	return 0;
}
root at genericarmv7a:~/cf# gcc -g -o cf cf.c
root at genericarmv7a:~/cf# ulimit -c unlimited
root at genericarmv7a:~/cf# ls
cf  cf.c
root at genericarmv7a:~/cf# /home/root/cf/cf
Aborted (core dumped)
root at genericarmv7a:~/cf# ls              
cf  cf.c  core
root at genericarmv7a:~/cf# gdb -core=./core
GNU gdb (Linaro GDB) 7.8-2014.09
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-oe-linux-gnueabi".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://bugs.linaro.org>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word".
[New LWP 1527]
Core was generated by `/home/root/cf/cf'.
Program terminated with signal SIGABRT, Aborted.
#0  0xb6e21344 in ?? ()
(gdb) quit
root at genericarmv7a:~/cf# file core
core: ELF 32-bit LSB core file ARM, version 1 (SYSV), SVR4-style, from '/home/root/cf/cf'
root at genericarmv7a:~/cf# readelf --notes core | head -10

Displaying notes found at file offset 0x00000234 with length 0x00000574:
  Owner                 Data size	Description
  CORE                 0x00000094	NT_PRSTATUS (prstatus structure)
  CORE                 0x0000007c	NT_PRPSINFO (prpsinfo structure) <---- size of note is 0x7c
  CORE                 0x00000080	NT_SIGINFO (siginfo_t data)
  CORE                 0x00000098	NT_AUXV (auxiliary vector)
  CORE                 0x00000146	NT_FILE (mapped files)
    Page size: 4096
         Start         End Page Offset

After the fix
--------------

Here is test case rerun in V8 kernel with proposed fix.

root at genericarmv7a:~/cf# uname -a
Linux genericarmv7a 3.17.0+ #1 SMP PREEMPT Sat Oct 11 23:24:27 PDT 2014 aarch64 GNU/Linux
root at genericarmv7a:~/cf# pwd
/home/root/cf
root at genericarmv7a:~/cf# ls
cf  cf.c  core
root at genericarmv7a:~/cf# mv core core.broken
root at genericarmv7a:~/cf# ulimit -c unlimited
root at genericarmv7a:~/cf# /home/root/cf/cf
Aborted (core dumped)
root at genericarmv7a:~/cf# ls              
cf  cf.c  core	core.broken
root@genericarmv7a:~/cf# gdb -core=./core
GNU gdb (Linaro GDB) 7.6.1-2013.10
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-oe-linux-gnueabi".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>.
[New LWP 937]
Core was generated by `/home/root/cf/cf'.
Program terminated with signal 6, Aborted.
#0  0xf7358ed4 in ?? ()
(gdb) quit
root at genericarmv7a:~/cf# file core
core: ELF 32-bit LSB core file ARM, version 1 (SYSV), SVR4-style, from '/home/root/cf/cf'
root at genericarmv7a:~/cf# readelf --notes core | head -10

Displaying notes found at file offset 0x000001f4 with length 0x000003d4:
  Owner                 Data size	Description
  CORE                 0x00000094	NT_PRSTATUS (prstatus structure)
  CORE                 0x0000007c	NT_PRPSINFO (prpsinfo structure)
  CORE                 0x00000080	NT_SIGINFO (siginfo_t data)
  CORE                 0x00000098	NT_AUXV (auxiliary vector)
  CORE                 0x00000146	NT_FILE (mapped files)
    Page size: 4096
         Start         End Page Offset

Victor Kamensky (1):
  arm64: compat: fix compat types affecting struct compat_elf_prpsinfo

 arch/arm64/include/asm/compat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.1.4
