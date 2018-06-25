From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 25 Jun 2018 12:05:47 -0500
Subject: [PATCH 2/2] soc: qcom: cmd-db: Fix compiler warnings
In-Reply-To: <1529946347-12740-1-git-send-email-andy.gross@linaro.org>
References: <1529946347-12740-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1529946347-12740-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initialization of the entry_header structs to avoid
compiler warnings like the following:

  CC      drivers/soc/qcom/cmd-db.o
drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_addr?:
drivers/soc/qcom/cmd-db.c:194:21: warning: ?ent.addr? may be used
uninitialized in this function [-Wmaybe-uninitialized]
  return ret < 0 ? 0 : le32_to_cpu(ent.addr);

drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_aux_data_len?:
drivers/soc/qcom/cmd-db.c:247:38: warning: ?ent.len? may be used
uninitialized in this function [-Wmaybe-uninitialized]
  return ret < 0 ? 0 : le16_to_cpu(ent.len);
                                      ^

drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_slave_id?:
drivers/soc/qcom/cmd-db.c:269:7: warning: ?ent.addr? may be used
uninitialized in this function [-Wmaybe-uninitialized]
  addr = le32_to_cpu(ent.addr);

drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_aux_data?:
drivers/soc/qcom/cmd-db.c:221:10: warning: ?ent.len? may be used
uninitialized in this function [-Wmaybe-uninitialized]
  ent_len = le16_to_cpu(ent.len);

drivers/soc/qcom/cmd-db.c:226:15: warning: ?*((void *)&rsc_hdr+4)? may
be used uninitialized in this function [-Wmaybe-uninitialized]
  memcpy(data, rsc_offset(&rsc_hdr, &ent), len);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/cmd-db.c:226:15: warning: ?*((void *)&ent+22)? may be
used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index deb2b90..1007e79 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -186,7 +186,7 @@ static int cmd_db_get_header(const char *id, struct entry_header *eh,
 u32 cmd_db_read_addr(const char *id)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {};
 	struct rsc_hdr rsc_hdr;
 
 	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(cmd_db_read_addr);
 int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {};
 	struct rsc_hdr rsc_hdr;
 	u16 ent_len;
 
@@ -239,7 +239,7 @@ EXPORT_SYMBOL(cmd_db_read_aux_data);
 size_t cmd_db_read_aux_data_len(const char *id)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {};
 	struct rsc_hdr rsc_hdr;
 
 	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
@@ -258,7 +258,7 @@ EXPORT_SYMBOL(cmd_db_read_aux_data_len);
 enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {};
 	struct rsc_hdr rsc_hdr;
 	u32 addr;
 
-- 
2.7.4
