From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 22 Mar 2018 10:33:11 -0400
Subject: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
Message-ID: <507571ad-b6a5-7020-45fa-609b44e0166b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more time hopefully without HTML this time.


On 03/22/2018 08:48 AM, okaya at codeaurora.org wrote:
>> Can you remove the writeq change if it is too late for me to fix?
>>
>> This is an infrastructural issue on xtensa arch.
>>
>> Probably, it won't get fixed today.
>
> AFAIS, even writeq won't compile on this arch. I started questioning 
> this build test.

I found out that the solution is this:

#include <linux/io-64-nonatomic-hi-lo.h>

https://patchwork.ozlabs.org/patch/511801/

I did a compile test with this change on xtensa and it passed. I'll 
repost with the added diff.

+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -46,7 +46,7 @@
 ?#include <linux/timer.h>
 ?#include <linux/io.h>
 ?#include <linux/workqueue.h>
-
+#include <linux/io-64-nonatomic-hi-lo.h>
 ?#include <asm/byteorder.h>

 ?#include <net/net_namespace.h>
