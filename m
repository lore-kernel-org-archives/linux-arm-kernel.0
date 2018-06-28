From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Thu, 28 Jun 2018 10:52:06 +0530
Subject: [PATCH v5 07/10] trace_uprobe/sdt: Prevent multiple reference counter
 for same uprobe
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
Message-ID: <20180628052209.13056-8-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We assume to have only one reference counter for one uprobe.
Don't allow user to add multiple trace_uprobe entries having
same inode+offset but different reference counter.

Ex,
  # echo "p:sdt_tick/loop2 /home/ravi/tick:0x6e4(0x10036)" > uprobe_events
  # echo "p:sdt_tick/loop2_1 /home/ravi/tick:0x6e4(0x10030)" >> uprobe_events
  bash: echo: write error: Invalid argument

  # dmesg
  trace_kprobe: Reference counter offset mismatch.

One exception to this is when user is trying to replace the old
entry with the new one. We allow this if the new entry does not
conflict with any other existing entry.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/trace/trace_uprobe.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index bf2be098eb08..7dd86f302f2a 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -324,6 +324,34 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 	return 0;
 }
 
+/*
+ * Uprobe with multiple reference counter is not allowed. i.e.
+ * If inode and offset matches, reference counter offset *must*
+ * match as well. Only one exception to this is when we are
+ * replacing old trace_uprobe with new one(same group/event).
+ */
+static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
+{
+	struct trace_uprobe *tmp, *old = NULL;
+	struct inode *new_inode = d_real_inode(new->path.dentry);
+
+	old = find_probe_event(trace_event_name(&new->tp.call),
+				new->tp.call.class->system);
+	if (!new->ref_ctr_offset)
+		return old;
+
+	list_for_each_entry(tmp, &uprobe_list, list) {
+		if (new_inode == d_real_inode(tmp->path.dentry) &&
+		    new->offset == tmp->offset &&
+		    new->ref_ctr_offset != tmp->ref_ctr_offset &&
+		    tmp != old) {
+			pr_warn("Reference counter offset mismatch.");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+	return old;
+}
+
 /* Register a trace_uprobe and probe_event */
 static int register_trace_uprobe(struct trace_uprobe *tu)
 {
@@ -333,8 +361,12 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	mutex_lock(&uprobe_lock);
 
 	/* register as an event */
-	old_tu = find_probe_event(trace_event_name(&tu->tp.call),
-			tu->tp.call.class->system);
+	old_tu = find_old_trace_uprobe(tu);
+	if (IS_ERR(old_tu)) {
+		ret = PTR_ERR(old_tu);
+		goto end;
+	}
+
 	if (old_tu) {
 		/* delete old event */
 		ret = unregister_trace_uprobe(old_tu);
-- 
2.14.4
