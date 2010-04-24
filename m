From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Sat, 24 Apr 2010 16:42:15 +0200
Subject: [PATCH] net/ipsec: don't treat EINPROGRESS as a regular error
In-Reply-To: <4BCE125F.30200@gmail.com>
References: <4B12F9E7.1020207@gmail.com>
	<20091130211531.GK18101@deprecation.cyrius.com>
	<4B144627.7060901@gmail.com>
	<20091204212847.GC28480@deprecation.cyrius.com>
	<4BCB4009.70707@gmail.com>
	<20100418191719.GA2508@Chamillionaire.breakpoint.cc>
	<4BCE125F.30200@gmail.com>
Message-ID: <20100424144215.GA9057@Chamillionaire.breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

a driver might drop EINPROGRESS because its internal queue is full and
not because something went wrong. In that case there will be another
call back invocation and the stack should not free the skb.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 net/xfrm/xfrm_output.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 6a32915..34dd460 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -86,10 +86,10 @@ static int xfrm_output_one(struct sk_buff *skb, int err)
 		spin_unlock_bh(&x->lock);
 
 		err = x->type->output(x, skb);
+resume:
 		if (err == -EINPROGRESS)
 			goto out_exit;
 
-resume:
 		if (err) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTSTATEPROTOERROR);
 			goto error_nolock;
-- 
1.6.6.1
