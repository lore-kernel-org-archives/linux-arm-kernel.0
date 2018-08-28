From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue, 28 Aug 2018 16:27:09 +0530
Subject: [PATCH 06/15] soc: octeontx2: Convert mbox msg id check to a macro
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1535453838-12154-7-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aleksey Makarov <amakarov@marvell.com>

With 10's of mailbox messages expected to be handled in future,
checking for message id could become a lengthy switch case. Hence
added a macro to auto generate the switch case for each msg id.

Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
---
 drivers/soc/marvell/octeontx2/rvu.c | 44 ++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index e795c2f..25f79bf 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -258,6 +258,12 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	return 0;
 }
 
+static int rvu_mbox_handler_READY(struct rvu *rvu, struct msg_req *req,
+				  struct ready_msg_rsp *rsp)
+{
+	return 0;
+}
+
 static int rvu_process_mbox_msg(struct rvu *rvu, int devid,
 				struct mbox_msghdr *req)
 {
@@ -265,13 +271,39 @@ static int rvu_process_mbox_msg(struct rvu *rvu, int devid,
 	if (req->sig != OTX2_MBOX_REQ_SIG)
 		goto bad_message;
 
-	if (req->id == MBOX_MSG_READY)
-		return 0;
-
+	switch (req->id) {
+#define M(_name, _id, _req_type, _rsp_type)				\
+	case _id: {							\
+		struct _rsp_type *rsp;					\
+		int err;						\
+									\
+		rsp = (struct _rsp_type *)otx2_mbox_alloc_msg(		\
+			&rvu->mbox, devid,				\
+			sizeof(struct _rsp_type));			\
+		if (rsp) {						\
+			rsp->hdr.id = _id;				\
+			rsp->hdr.sig = OTX2_MBOX_RSP_SIG;		\
+			rsp->hdr.pcifunc = req->pcifunc;		\
+			rsp->hdr.rc = 0;				\
+		}							\
+									\
+		err = rvu_mbox_handler_ ## _name(rvu,			\
+						 (struct _req_type *)req, \
+						 rsp);			\
+		if (rsp && err)						\
+			rsp->hdr.rc = err;				\
+									\
+		return rsp ? err : -ENOMEM;				\
+	}
+MBOX_MESSAGES
+#undef M
+		break;
 bad_message:
-	otx2_reply_invalid_msg(&rvu->mbox, devid, req->pcifunc,
-			       req->id);
-	return -ENODEV;
+	default:
+		otx2_reply_invalid_msg(&rvu->mbox, devid, req->pcifunc,
+				       req->id);
+		return -ENODEV;
+	}
 }
 
 static void rvu_mbox_handler(struct work_struct *work)
-- 
2.7.4
