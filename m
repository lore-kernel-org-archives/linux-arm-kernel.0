From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Mon, 30 Jul 2018 11:54:43 +0530
Subject: [PATCH v2] arm64, kaslr: export offset in VMCOREINFO ELF notes
Message-ID: <1532931883-16132-1-git-send-email-bhsharma@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include KASLR offset in arm64 VMCOREINFO ELF notes to assist in
debugging. vmcore parsing in user-space already expects this value in
the notes and we are providing it for portability of those existing
tools with x86.

Ideally we would like core code to do this (so that way this
information won't be missed when an architecture adds KASLR support),
but mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
so I am not sure if this is needed for mips (and other such similar arch
cases in future). So, lets keep this architecture specific for now.

As an example of a user-space use-case, consider the
makedumpfile user-space utility which will need fixup to use this
KASLR offset to work with cases where we need to find a way to
translate symbol address from vmlinux to kernel run time address
in case of KASLR boot on arm64.

I have already submitted the makedumpfile user-space patch upstream
and the maintainer has suggested to wait for the kernel changes to be
included (see [0]).

I tested this on my qualcomm amberwing board both for KASLR and
non-KASLR boot cases:

Without this patch:
   # cat > scrub.conf << EOF
   [vmlinux]
   erase jiffies
   erase init_task.utime
   for tsk in init_task.tasks.next within task_struct:tasks
       erase tsk.utime
   endfor
   EOF

  # makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
  readpage_elf: Attempt to read non-existent page at 0xffffa8a5bf180000.
  readmem: type_addr: 1, addr:ffffa8a5bf180000, size:8
  vaddr_to_paddr_arm64: Can't read pgd
  readmem: Can't convert a virtual address(ffff0000092a542c) to physical
  address.
  readmem: type_addr: 0, addr:ffff0000092a542c, size:390
  check_release: Can't get the address of system_utsname

After this patch check_release() is ok, and also we are able to erase
symbol from vmcore (I checked this with kernel 4.18.0-rc4+):

  # makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
  The kernel version is not supported.
  The makedumpfile operation may be incomplete.
  Checking for memory holes                         : [100.0 %] \
  Checking for memory holes                         : [100.0 %] |
  Checking foExcluding unnecessary pages                       : [100.0 %]
  \
  Excluding unnecessary pages                       : [100.0 %] \

  The dumpfiles are saved to dumpfile_1, dumpfile_2, and dumpfile_3.

  makedumpfile Completed.

[0] https://www.spinics.net/lists/kexec/msg21195.html

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
Changes since v1:
 - Addressed review comments from James regarding commit log
 - v1 can be viewed here: https://lkml.org/lkml/2018/7/18/951
 - v2 is rebased against linux-next/master

 arch/arm64/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f62effc6e064..028df356a5fd 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -360,4 +360,5 @@ void arch_crash_save_vmcoreinfo(void)
 						kimage_voffset);
 	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
 						PHYS_OFFSET);
+	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
 }
-- 
2.7.4
