From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sun, 14 Jan 2018 22:50:36 +0900
Subject: [RESEND PATCH 2/2] selftest: ftrace: Fix to add 256 kprobe events
 correctly
In-Reply-To: <151593777761.23875.10360397710751679883.stgit@devbox>
References: <151593777761.23875.10360397710751679883.stgit@devbox>
Message-ID: <151593783656.23875.14563972262086825681.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current multiple-kprobe testcase only tries to add
kprobe events on first 256 text symbols. However
kprobes fails to probe on some text symbols (like
blacklisted symbols). Thus in the worst case,
the test can not add any kprobe events.

To avoid that, continue to try adding kprobe events
until 256 events. Also it confirms the number of
registered kprobe events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index e297bd7a2e79..ce361b9d62cf 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -12,9 +12,24 @@ case `uname -m` in
   *) OFFS=0;;
 esac
 
-echo "Setup up kprobes on first 256 text symbols"
+if [ -d events/kprobes ]; then
+  echo 0 > events/kprobes/enable
+  echo > kprobe_events
+fi
+
+N=0
+echo "Setup up kprobes on first available 256 text symbols"
 grep -i " t " /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
-head -n 256 | while read i; do echo p ${i}+${OFFS} ; done > kprobe_events ||:
+while read i; do
+  echo p ${i}+${OFFS} >> kprobe_events && N=$((N+1)) ||:
+  test $N -eq 256 && break
+done
+
+L=`wc -l kprobe_events`
+if [ $L -ne $N ]; then
+  echo "The number of kprobes events ($L) is not $N"
+  exit_fail
+fi
 
 echo 1 > events/kprobes/enable
 echo 0 > events/kprobes/enable
