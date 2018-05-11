From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 11 May 2018 20:06:13 +0100
Subject: [PATCH v2 12/40] mm: export symbol mmput_async
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Message-ID: <20180511190641.23008-13-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases releasing a mm bound to a device might invoke an exit
handler, that takes a lock already held by the function calling mmput().
This is the case for VFIO, which needs to call mmput_async to avoid a
deadlock. Other drivers using SVA might follow. Since they can be built as
modules, export the mmput_async symbol.

Cc: akpm at linux-foundation.org
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 1062f7450e97..bf05d188c8de 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -999,6 +999,7 @@ void mmput_async(struct mm_struct *mm)
 		schedule_work(&mm->async_put_work);
 	}
 }
+EXPORT_SYMBOL_GPL(mmput_async);
 #endif
 
 /**
-- 
2.17.0
