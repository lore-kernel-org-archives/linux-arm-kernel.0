From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 25 Jun 2018 14:44:45 -0500
Subject: [PATCH 2/2] soc: qcom: cmd-db: Fix compiler warnings
In-Reply-To: <1529946347-12740-2-git-send-email-andy.gross@linaro.org>
References: <1529946347-12740-1-git-send-email-andy.gross@linaro.org>
 <1529946347-12740-2-git-send-email-andy.gross@linaro.org>
Message-ID: <20180625194445.GB4689@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 12:05:47PM -0500, Andy Gross wrote:
> This patch adds initialization of the entry_header structs to avoid
> compiler warnings like the following:
> 
>   CC      drivers/soc/qcom/cmd-db.o
> drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_addr?:
> drivers/soc/qcom/cmd-db.c:194:21: warning: ?ent.addr? may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>   return ret < 0 ? 0 : le32_to_cpu(ent.addr);
> 
> drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_aux_data_len?:
> drivers/soc/qcom/cmd-db.c:247:38: warning: ?ent.len? may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>   return ret < 0 ? 0 : le16_to_cpu(ent.len);
>                                       ^
> 
> drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_slave_id?:
> drivers/soc/qcom/cmd-db.c:269:7: warning: ?ent.addr? may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>   addr = le32_to_cpu(ent.addr);
> 
> drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_aux_data?:
> drivers/soc/qcom/cmd-db.c:221:10: warning: ?ent.len? may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>   ent_len = le16_to_cpu(ent.len);
> 
> drivers/soc/qcom/cmd-db.c:226:15: warning: ?*((void *)&rsc_hdr+4)? may
> be used uninitialized in this function [-Wmaybe-uninitialized]
>   memcpy(data, rsc_offset(&rsc_hdr, &ent), len);
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/soc/qcom/cmd-db.c:226:15: warning: ?*((void *)&ent+22)? may be
> used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

I flubbed this one due to missing an already existing patch that fixes
the warnings.  I'm going to package that one up with the errno check
patch and send a fixes pull request.

precursor patch:
https://patchwork.kernel.org/patch/10384143/


Andy
