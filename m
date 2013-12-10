From: liucy214@gmail.com (Aaron Liu)
Date: Tue, 10 Dec 2013 14:21:44 +0800
Subject: [PATCH] arm64 ptrace.c
Message-ID: <CAAXgzBNP_O9u4-tve27shFEwyoT1yx7M+C1RzmvXHLd-tQGi8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

In these dayes, I use gdb to debug my program on ARM foundation model
and fast model with Linux 3.12.0-4.12 from ubuntu.
The gdb reports errors about setting hardware debug register when
stepping pthread_create().
After investigating gdb 7.6.1 source and Linux 3.12 source, I prepare
a patch for arch/arm64/kernel/ptrace.c.
Although the patch could solve gdb error, I am not sure it has no side effects.
May somebody help to give suggestions?
Thank you.

Ref. to https://bugs.launchpad.net/gdb-linaro/+bug/1205391

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6777a21..981f961 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -214,9 +214,16 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int
note_type,
 {
  int err, len, type, disabled = !ctrl.enabled;

+ /*
+  * Does not change type and len in disabled case because it will
+  * break the assertion that only 2 types (TYPE_DATA and TYPE_INST) in
+  * the event linked list in ./kernel/events/hw_breakpoint.c
+  */
  if (disabled) {
- len = 0;
- type = HW_BREAKPOINT_EMPTY;
+ /*
+  * len = 0;
+  * type = HW_BREAKPOINT_EMPTY;
+  */
  } else {
  err = arch_bp_generic_fields(ctrl, &len, &type);
  if (err)
@@ -234,10 +241,10 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned
int note_type,
  default:
  return -EINVAL;
  }
+ attr->bp_len = len;
+ attr->bp_type = type;
  }

- attr->bp_len = len;
- attr->bp_type = type;
  attr->disabled = disabled;

  return 0;
--
Aaron Liu
