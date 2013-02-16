From: will.deacon@arm.com (Will Deacon)
Date: Sat, 16 Feb 2013 12:26:46 +0000
Subject: [PATCH] ARM:kernel: a bug by a redundancy charactor ';'
In-Reply-To: <511F4574.7000707@asianux.com>
References: <511F2C0D.4030206@asianux.com> <511F3D8C.6090603@gmail.com>
 <511F4574.7000707@asianux.com>
Message-ID: <20130216122646.GA14174@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 16, 2013 at 08:38:12AM +0000, Chen Gang wrote:
> ? 2013?02?16? 16:04, Dirk Behme ??:
> > 
> > Wondering against which branch this patch is, I found that this issue
> > isn't in recent mainline from today, but in -next. Introduced by the patch
> > 
> > ARM: perf: simplify __hw_perf_event_init err handling
> > http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=9dcbf466559f6f2f55d60eb5a1bbebc8e694b52a
> > 

Damn, I really should have spotted this. Thanks for reporting/fixing it.

> > While the subject/commit message could be improved (at least mentioning
> > 'perf' somehow and charactor -> character), the change itself looks good.
> 
>   if still suggest to commit current patch:
>     does the subject like this ?
>      [PATCH] ARM:kernel: a bug for perf by a redundancy character ';'

If you're ok with the following patch, I'll take it into the ARM perf
tree.

Cheers,

Will

--->8

>From 21fa771c94c4359807bb92dc8532b25c323ac543 Mon Sep 17 00:00:00 2001
From: Chen Gang <gang.chen@asianux.com>
Date: Sat, 16 Feb 2013 06:49:49 +0000
Subject: [PATCH] ARM: perf: remove erroneous semicolon from event
 initialisation

Commit 9dcbf466559f ("ARM: perf: simplify __hw_perf_event_init err
handling") tidied up the error handling code for perf event
initialisation on ARM, but a copy-and-paste error left a dangling
semicolon at the end of an if statement.

This patch removes the broken semicolon, restoring the old group
validation semantics.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 31e0eb3..a892067 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -400,7 +400,7 @@ __hw_perf_event_init(struct perf_event *event)
 	}
 
 	if (event->group_leader != event) {
-		if (validate_group(event) != 0);
+		if (validate_group(event) != 0)
 			return -EINVAL;
 	}
 
-- 
1.8.0
