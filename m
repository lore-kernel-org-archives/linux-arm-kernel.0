From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sun, 14 Jan 2018 22:50:07 +0900
Subject: [RESEND PATCH 1/2] [BUGFIX] selftest: ftrace: Fix to pick text
 symbols for kprobes
In-Reply-To: <151593777761.23875.10360397710751679883.stgit@devbox>
References: <151593777761.23875.10360397710751679883.stgit@devbox>
Message-ID: <151593780745.23875.14592346020233219552.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix to pick text symbols for multiple kprobe testcase.
kallsyms shows text symbols with " t " or " T " but
current testcase picks all symbols including "t",
so it picks data symbols if it includes 't' (e.g. "str").

This fixes it to find symbol lines with " t " or " T "
(including spaces).

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Russell King <linux@armlinux.org.uk>
---
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index bb16cf91f1b5..e297bd7a2e79 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -12,8 +12,8 @@ case `uname -m` in
   *) OFFS=0;;
 esac
 
-echo "Setup up to 256 kprobes"
-grep t /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
+echo "Setup up kprobes on first 256 text symbols"
+grep -i " t " /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
 head -n 256 | while read i; do echo p ${i}+${OFFS} ; done > kprobe_events ||:
 
 echo 1 > events/kprobes/enable
