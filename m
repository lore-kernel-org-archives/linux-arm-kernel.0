From: julia@diku.dk (Julia Lawall)
Date: Sat, 17 Oct 2009 08:40:02 +0200 (CEST)
Subject: [PATCH 7/14] drivers/mmc: Move dereference after NULL test
Message-ID: <Pine.LNX.4.64.0910170839430.9213@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <julia@diku.dk>

If the NULL test on mrq is needed, then the derefernce should be after the
NULL test.

A simplified version of the semantic match that detects this problem is as
follows (http://coccinelle.lip6.fr/):

// <smpl>
@match exists@
expression x, E;
identifier fld;
@@

* x->fld
  ... when != \(x = E\|&x\)
* x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/mmc/host/s3cmci.c           |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 99b74a3..5be6962 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -820,7 +820,7 @@ fail_request:
 static void finalize_request(struct s3cmci_host *host)
 {
 	struct mmc_request *mrq = host->mrq;
-	struct mmc_command *cmd = host->cmd_is_stop ? mrq->stop : mrq->cmd;
+	struct mmc_command *cmd;
 	int debug_as_failure = 0;
 
 	if (host->complete_what != COMPLETION_FINALIZE)
@@ -828,6 +828,7 @@ static void finalize_request(struct s3cmci_host *host)
 
 	if (!mrq)
 		return;
+	cmd = host->cmd_is_stop ? mrq->stop : mrq->cmd;
 
 	if (cmd->data && (cmd->error == 0) &&
 	    (cmd->data->error == 0)) {
