From: bryantly@linux.vnet.ibm.com (Bryant G. Ly)
Date: Wed,  8 Jun 2016 14:43:42 -0500
Subject: [PATCH] target: Fix for hang of Ordered task in TCM
In-Reply-To: <1464067904.22249.53.camel@haakon3.risingtidesystems.com>
References: <1464067904.22249.53.camel@haakon3.risingtidesystems.com>
Message-ID: <1465415022-79833-1-git-send-email-bryantly@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

If a command with a Simple task attribute is failed due to a Unit
Attention, then a subsequent command with an Ordered task attribute
will hang forever.  The reason for this is that the Unit Attention
status is checked for in target_setup_cmd_from_cdb, before the call
to target_execute_cmd, which calls target_handle_task_attr, which
in turn increments dev->simple_cmds.

However, transport_generic_request_failure still calls
transport_complete_task_attr, which will decrement dev->simple_cmds.
In this case, simple_cmds is now -1.  So when a command with the
Ordered task attribute is sent, target_handle_task_attr sees that
dev->simple_cmds is not 0, so it decides it can't execute the
command until all the (nonexistent) Simple commands have completed.

Reported-by: Michael Cyr <mikecyr@linux.vnet.ibm.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
---
 drivers/target/target_core_internal.h  |  1 +
 drivers/target/target_core_sbc.c       |  2 +-
 drivers/target/target_core_transport.c | 62 +++++++++++++++++++---------------
 include/target/target_core_fabric.h    |  1 -
 4 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index fc91e85..e2c970a 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -146,6 +146,7 @@ sense_reason_t	target_cmd_size_check(struct se_cmd *cmd, unsigned int size);
 void	target_qf_do_work(struct work_struct *work);
 bool	target_check_wce(struct se_device *dev);
 bool	target_check_fua(struct se_device *dev);
+void	__target_execute_cmd(struct se_cmd *, bool);
 
 /* target_core_stat.c */
 void	target_stat_setup_dev_default_groups(struct se_device *);
diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index a9057aa..04f616b 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -602,7 +602,7 @@ static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool succes
 	cmd->transport_state |= CMD_T_ACTIVE|CMD_T_BUSY|CMD_T_SENT;
 	spin_unlock_irq(&cmd->t_state_lock);
 
-	__target_execute_cmd(cmd);
+	__target_execute_cmd(cmd, false);
 
 	kfree(buf);
 	return ret;
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index e887635..7c4ea39 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1303,23 +1303,6 @@ target_setup_cmd_from_cdb(struct se_cmd *cmd, unsigned char *cdb)
 
 	trace_target_sequencer_start(cmd);
 
-	/*
-	 * Check for an existing UNIT ATTENTION condition
-	 */
-	ret = target_scsi3_ua_check(cmd);
-	if (ret)
-		return ret;
-
-	ret = target_alua_state_check(cmd);
-	if (ret)
-		return ret;
-
-	ret = target_check_reservation(cmd);
-	if (ret) {
-		cmd->scsi_status = SAM_STAT_RESERVATION_CONFLICT;
-		return ret;
-	}
-
 	ret = dev->transport->parse_cdb(cmd);
 	if (ret == TCM_UNSUPPORTED_SCSI_OPCODE)
 		pr_warn_ratelimited("%s/%s: Unsupported SCSI Opcode 0x%02x, sending CHECK_CONDITION.\n",
@@ -1762,20 +1745,45 @@ queue_full:
 }
 EXPORT_SYMBOL(transport_generic_request_failure);
 
-void __target_execute_cmd(struct se_cmd *cmd)
+void __target_execute_cmd(struct se_cmd *cmd, bool do_checks)
 {
 	sense_reason_t ret;
 
-	if (cmd->execute_cmd) {
-		ret = cmd->execute_cmd(cmd);
-		if (ret) {
-			spin_lock_irq(&cmd->t_state_lock);
-			cmd->transport_state &= ~(CMD_T_BUSY|CMD_T_SENT);
-			spin_unlock_irq(&cmd->t_state_lock);
+	if (!cmd->execute_cmd) {
+		ret = TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
+		goto err;
+	}
+	if (do_checks) {
+		/*
+		 * Check for an existing UNIT ATTENTION condition after
+		 * target_handle_task_attr() has done SAM task attr
+		 * checking, and possibly have already defered execution
+		 * out to target_restart_delayed_cmds() context.
+		 */
+		ret = target_scsi3_ua_check(cmd);
+		if (ret)
+			goto err;
+
+		ret = target_alua_state_check(cmd);
+		if (ret)
+			goto err;
 
-			transport_generic_request_failure(cmd, ret);
+		ret = target_check_reservation(cmd);
+		if (ret) {
+			cmd->scsi_status = SAM_STAT_RESERVATION_CONFLICT;
+			goto err;
 		}
 	}
+
+	ret = cmd->execute_cmd(cmd);
+	if (!ret)
+		return;
+err:
+	spin_lock_irq(&cmd->t_state_lock);
+	cmd->transport_state &= ~(CMD_T_BUSY|CMD_T_SENT);
+	spin_unlock_irq(&cmd->t_state_lock);
+
+	transport_generic_request_failure(cmd, ret);
 }
 
 static int target_write_prot_action(struct se_cmd *cmd)
@@ -1900,7 +1908,7 @@ void target_execute_cmd(struct se_cmd *cmd)
 		return;
 	}
 
-	__target_execute_cmd(cmd);
+	__target_execute_cmd(cmd, true);
 }
 EXPORT_SYMBOL(target_execute_cmd);
 
@@ -1924,7 +1932,7 @@ static void target_restart_delayed_cmds(struct se_device *dev)
 		list_del(&cmd->se_delayed_node);
 		spin_unlock(&dev->delayed_cmd_lock);
 
-		__target_execute_cmd(cmd);
+		__target_execute_cmd(cmd, true);
 
 		if (cmd->sam_task_attr == TCM_ORDERED_TAG)
 			break;
diff --git a/include/target/target_core_fabric.h b/include/target/target_core_fabric.h
index de44462..5cd6faa 100644
--- a/include/target/target_core_fabric.h
+++ b/include/target/target_core_fabric.h
@@ -163,7 +163,6 @@ int	core_tmr_alloc_req(struct se_cmd *, void *, u8, gfp_t);
 void	core_tmr_release_req(struct se_tmr_req *);
 int	transport_generic_handle_tmr(struct se_cmd *);
 void	transport_generic_request_failure(struct se_cmd *, sense_reason_t);
-void	__target_execute_cmd(struct se_cmd *);
 int	transport_lookup_tmr_lun(struct se_cmd *, u64);
 void	core_allocate_nexus_loss_ua(struct se_node_acl *acl);
 
--

Hi Nic,

So I was testing the ibmvscsi target driver and I ran into some problems
again with UA stuff and it looks like you didnt remove the UA checks from
target_setup_cmd_from_cdb? Was that intentional? I thought we agreed to move
it completely to target_execute_cmd and not have both?

Let me know.

Thanks,

Bryant
2.5.4 (Apple Git-61)
