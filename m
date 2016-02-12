From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Feb 2016 09:51:44 +0000
Subject: [PATCH V1 6/6] acpi: apei: handle SEA notification type for ARMv8
In-Reply-To: <56BD0D43.4060901@codeaurora.org>
References: <1454699608-22760-1-git-send-email-tbaicar@codeaurora.org>
 <1454699608-22760-7-git-send-email-tbaicar@codeaurora.org>
 <20160210180332.GU1052@arm.com> <56BD0D43.4060901@codeaurora.org>
Message-ID: <20160212095143.GC25087@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 03:37:55PM -0700, Baicar, Tyler wrote:
> On 2/10/2016 11:03 AM, Will Deacon wrote:
> >On Fri, Feb 05, 2016 at 12:13:28PM -0700, Tyler Baicar wrote:
> >>diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> >>index 6c68100..ed64b97 100644
> >>--- a/drivers/acpi/apei/ghes.c
> >>+++ b/drivers/acpi/apei/ghes.c
> >>@@ -50,6 +50,10 @@
> >>  #include <acpi/apei.h>
> >>  #include <asm/tlbflush.h>
> >>+#ifdef CONFIG_HAVE_ACPI_APEI_SEA
> >>+#include <asm/system_misc.h>
> >>+#endif
> >>+
> >>  #include "apei-internal.h"
> >>  #define GHES_PFX	"GHES: "
> >>@@ -784,6 +788,62 @@ static struct notifier_block ghes_notifier_sci = {
> >>  	.notifier_call = ghes_notify_sci,
> >>  };
> >>+#ifdef CONFIG_HAVE_ACPI_APEI_SEA
> >>+static LIST_HEAD(ghes_sea);
> >>+
> >>+static int ghes_notify_sea(struct notifier_block *this,
> >>+				  unsigned long event, void *data)
> >>+{
> >>+	struct ghes *ghes;
> >>+	int ret = NOTIFY_DONE;
> >>+
> >>+	rcu_read_lock();
> >>+	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
> >>+		if (!ghes_proc(ghes))
> >>+			ret = NOTIFY_OK;
> >>+	}
> >>+	rcu_read_unlock();
> >>+
> >>+	return ret;
> >>+}
> >>+
> >>+static struct notifier_block ghes_notifier_sea = {
> >>+	.notifier_call = ghes_notify_sea,
> >>+};
> >>+
> >>+static int ghes_sea_add(struct ghes *ghes)
> >>+{
> >>+	mutex_lock(&ghes_list_mutex);
> >Can you just use spin_lock, to be consistent with our other excception
> >hooks?
> This mutex is being used throughout ghes.c for editing the lists, so I think
> this is the proper (or at least consistent) implementation. This mutex was
> defined specifically for editing the lists according to the comment above
> the mutex definition:
> 
> "All error sources notified with SCI shares one notifier function, so they
> need to be linked and checked one by one. This is applied to NMI too. RCU is
> used for these lists, so ghes_list_mutex is only used for list changing, not
> for traversing."
> 
> The use of this mutex is identical to the way that SCI and NMI use it when
> adding or deleting from the lists. Should I add to this comment that this
> applies to SEA as well?

No, it's fine. I overlooked the fact that this was under drivers/acpi/,
so if you're consistent with other code under there then there's no need
to change anything.

Will
