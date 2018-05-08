From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 8 May 2018 14:06:40 -0500
Subject: [PATCH 2/4] pid: Export find_task_by_vpid for use in external modules
Message-ID: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is in the context of allowing the Coresight h/w
trace driver suite to be loaded as modules.  Coresight uses
find_task_by_vpid when running in direct capture mode (via sysfs)
when getting/setting the context ID comparator to trigger on
(/sys/bus/coresight/devices/<x>.etm/ctxid_pid).

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Gargi Sharma <gs051095@gmail.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
Current CoreSight callsite:

https://lxr.missinglinkelectronics.com/linux/include/linux/coresight.h#L285

A quick look didn't find anything, but if Coresight needs to do
something differently, please comment.

 kernel/pid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/pid.c b/kernel/pid.c
index 157fe4b19971..92b1b623f3e0 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -342,6 +342,7 @@ struct task_struct *find_task_by_vpid(pid_t vnr)
 {
 	return find_task_by_pid_ns(vnr, task_active_pid_ns(current));
 }
+EXPORT_SYMBOL_GPL(find_task_by_vpid);
 
 struct task_struct *find_get_task_by_vpid(pid_t nr)
 {
-- 
2.17.0
