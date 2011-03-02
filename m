From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Thu,  3 Mar 2011 06:41:23 +0800
Subject: [PATCH] arm: etm: fix section mismatch warning
Message-ID: <1299105683-2936-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <tom.leiming@gmail.com>

The patch fixes the warning below:

WARNING: arch/arm/kernel/built-in.o(.data+0x27c): Section mismatch in reference from the variable etb_driver to the function .init.text:etb_probe()
The variable etb_driver references
the function __init etb_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: arch/arm/kernel/built-in.o(.data+0x2cc): Section mismatch in reference from the variable etm_driver to the function .init.text:etm_probe()
The variable etm_driver references
the function __init etm_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/kernel/etm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 052b509..1bec8b5 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -338,7 +338,7 @@ static struct miscdevice etb_miscdev = {
 	.fops = &etb_fops,
 };
 
-static int __init etb_probe(struct amba_device *dev, const struct amba_id *id)
+static int __devinit etb_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct tracectx *t = &tracer;
 	int ret = 0;
@@ -530,7 +530,7 @@ static ssize_t trace_mode_store(struct kobject *kobj,
 static struct kobj_attribute trace_mode_attr =
 	__ATTR(trace_mode, 0644, trace_mode_show, trace_mode_store);
 
-static int __init etm_probe(struct amba_device *dev, const struct amba_id *id)
+static int __devinit etm_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct tracectx *t = &tracer;
 	int ret = 0;
-- 
1.7.3
