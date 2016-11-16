From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 16 Nov 2016 14:53:02 +0800
Subject: [PATCH V2 fix 4/6] mm: mempolicy: intruduce a helper huge_nodemask()
In-Reply-To: <1479107259-2011-5-git-send-email-shijie.huang@arm.com>
References: <1479107259-2011-5-git-send-email-shijie.huang@arm.com>
Message-ID: <1479279182-31294-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch intruduces a new helper huge_nodemask(),
we can use it to get the node mask.

This idea of the function is from the init_nodemask_of_mempolicy():
   Return true if we can succeed in extracting the node_mask
for 'bind' or 'interleave' policy or initializing the node_mask
to contain the single node for 'preferred' or 'local' policy.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
The previous version does not treat the MPOL_PREFERRED/MPOL_INTERLEAVE cases.
This patch adds the code to set proper node mask for
MPOL_PREFERRED/MPOL_INTERLEAVE.
---
 include/linux/mempolicy.h |  8 ++++++++
 mm/mempolicy.c            | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 5e5b296..7796a40 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -145,6 +145,8 @@ extern void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new,
 				enum mpol_rebind_step step);
 extern void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new);
 
+extern bool huge_nodemask(struct vm_area_struct *vma,
+				unsigned long addr, nodemask_t *mask);
 extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
 				unsigned long addr, gfp_t gfp_flags,
 				struct mempolicy **mpol, nodemask_t **nodemask);
@@ -261,6 +263,12 @@ static inline void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 }
 
+static inline bool huge_nodemask(struct vm_area_struct *vma,
+				unsigned long addr, nodemask_t *mask)
+{
+	return false;
+}
+
 static inline struct zonelist *huge_zonelist(struct vm_area_struct *vma,
 				unsigned long addr, gfp_t gfp_flags,
 				struct mempolicy **mpol, nodemask_t **nodemask)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6d3639e..5063a69 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1800,6 +1800,53 @@ static inline unsigned interleave_nid(struct mempolicy *pol,
 
 #ifdef CONFIG_HUGETLBFS
 /*
+ * huge_nodemask(@vma, @addr, @mask)
+ * @vma: virtual memory area whose policy is sought
+ * @addr: address in @vma
+ * @mask: a nodemask pointer
+ *
+ * Return true if we can succeed in extracting the policy nodemask
+ * for 'bind' or 'interleave' policy into the argument @mask, or
+ * initializing the argument @mask to contain the single node for
+ * 'preferred' or 'local' policy.
+ */
+bool huge_nodemask(struct vm_area_struct *vma, unsigned long addr,
+			nodemask_t *mask)
+{
+	struct mempolicy *mpol;
+	bool ret = true;
+	int nid;
+
+	if (!mask)
+		return false;
+
+	mpol = get_vma_policy(vma, addr);
+
+	switch (mpol->mode) {
+	case MPOL_PREFERRED:
+		if (mpol->flags & MPOL_F_LOCAL)
+			nid = numa_node_id();
+		else
+			nid = mpol->v.preferred_node;
+		init_nodemask_of_node(mask, nid);
+		break;
+
+	case MPOL_BIND:
+		/* Fall through */
+	case MPOL_INTERLEAVE:
+		*mask = mpol->v.nodes;
+		break;
+
+	default:
+		ret = false;
+		break;
+	}
+	mpol_cond_put(mpol);
+
+	return ret;
+}
+
+/*
  * huge_zonelist(@vma, @addr, @gfp_flags, @mpol)
  * @vma: virtual memory area whose policy is sought
  * @addr: address in @vma for shared policy lookup and interleave policy
-- 
2.5.5
