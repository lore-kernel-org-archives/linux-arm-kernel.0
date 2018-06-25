From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 25 Jun 2018 12:14:53 -0700
Subject: [PATCH 1/2] soc: qcom: cmd-db: Fix incorrect errno checks
In-Reply-To: <1529946347-12740-1-git-send-email-andy.gross@linaro.org>
References: <1529946347-12740-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20180625191453.GB1860@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 25 Jun 10:05 PDT 2018, Andy Gross wrote:

> This patch fixes a couple of checks for errno that should have been
> checking for ret < 0.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/cmd-db.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index a6f6462..deb2b90 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -121,7 +121,7 @@ rsc_offset(struct rsc_hdr *hdr, struct entry_header *ent)
>  /**
>   * cmd_db_ready - Indicates if command DB is available
>   *
> - * Return: 0 on success, errno otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  int cmd_db_ready(void)
>  {
> @@ -143,7 +143,7 @@ static int cmd_db_get_header(const char *id, struct entry_header *eh,
>  	u8 query[8];
>  
>  	ret = cmd_db_ready();
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	if (!eh || !rh)
> @@ -202,7 +202,7 @@ EXPORT_SYMBOL(cmd_db_read_addr);
>   *  @data: Data buffer to copy returned aux data to. Returns size on NULL
>   *  @len: Caller provides size of data buffer passed in.
>   *
> - *  Return: size of data on success, errno otherwise
> + *  Return: size of data on success, -errno otherwise
>   */
>  int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
>  {
> @@ -215,7 +215,7 @@ int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
>  		return -EINVAL;
>  
>  	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	ent_len = le16_to_cpu(ent.len);
> -- 
> 2.7.4
> 
