From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 16 Nov 2018 10:24:09 +0000
Subject: [PATCH 06/10] alpha: perf/core: generalise event exclusion checking
 with perf macro
In-Reply-To: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
Message-ID: <1542363853-13849-7-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace checking of perf event exclusion flags with perf macro.

This is a functional change as __hw_perf_event_init will now indicate
that it doesn't support exclude_host and exclude_guest event flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/alpha/kernel/perf_event.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 5613aa37..36f98ee 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -631,10 +631,8 @@ static int __hw_perf_event_init(struct perf_event *event)
 	}
 
 	/* The EV67 does not support mode exclusion */
-	if (attr->exclude_kernel || attr->exclude_user
-			|| attr->exclude_hv || attr->exclude_idle) {
+	if (event_has_exclude_flags(event))
 		return -EPERM;
-	}
 
 	/*
 	 * We place the event type in event_base here and leave calculation
-- 
2.7.4
