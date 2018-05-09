From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  9 May 2018 12:06:08 -0600
Subject: [PATCH 6/6] coresight: Remove %px for printing pcsr value
In-Reply-To: <1525889168-20574-1-git-send-email-mathieu.poirier@linaro.org>
References: <1525889168-20574-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1525889168-20574-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

The driver prints pcsr twice: the first time it uses specifier %px to
print hexadecimal pcsr value and the second time uses specifier %pS for
output kernel symbols.

As suggested by Kees, using %pS should be sufficient and %px isn't
necessary; the reason is if the pcsr is a kernel space address, we can
easily get to know the code line from %pS format, on the other hand, if
the pcsr value doesn't fall into kernel space range (e.g. if the CPU is
stuck in firmware), %pS also gives out pcsr hexadecimal value.

So this commit removes useless %px and update section "Output format"
in the document for alignment between the code and document.

Suggested-by: Kees Cook <keescook@chromium.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight-cpu-debug.txt       | 4 ++--
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/coresight-cpu-debug.txt b/Documentation/trace/coresight-cpu-debug.txt
index 2b9b51cd501e..89ab09e78e8d 100644
--- a/Documentation/trace/coresight-cpu-debug.txt
+++ b/Documentation/trace/coresight-cpu-debug.txt
@@ -177,11 +177,11 @@ Here is an example of the debugging output format:
 ARM external debug module:
 coresight-cpu-debug 850000.debug: CPU[0]:
 coresight-cpu-debug 850000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
-coresight-cpu-debug 850000.debug:  EDPCSR:  [<ffff00000808e9bc>] handle_IPI+0x174/0x1d8
+coresight-cpu-debug 850000.debug:  EDPCSR:  handle_IPI+0x174/0x1d8
 coresight-cpu-debug 850000.debug:  EDCIDSR: 00000000
 coresight-cpu-debug 850000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
 coresight-cpu-debug 852000.debug: CPU[1]:
 coresight-cpu-debug 852000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
-coresight-cpu-debug 852000.debug:  EDPCSR:  [<ffff0000087fab34>] debug_notifier_call+0x23c/0x358
+coresight-cpu-debug 852000.debug:  EDPCSR:  debug_notifier_call+0x23c/0x358
 coresight-cpu-debug 852000.debug:  EDCIDSR: 00000000
 coresight-cpu-debug 852000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 33d2470b0595..45b2460f3166 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -303,7 +303,7 @@ static void debug_dump_regs(struct debug_drvdata *drvdata)
 	}
 
 	pc = debug_adjust_pc(drvdata);
-	dev_emerg(dev, " EDPCSR:  [<%px>] %pS\n", (void *)pc, (void *)pc);
+	dev_emerg(dev, " EDPCSR:  %pS\n", (void *)pc);
 
 	if (drvdata->edcidsr_present)
 		dev_emerg(dev, " EDCIDSR: %08x\n", drvdata->edcidsr);
-- 
2.7.4
