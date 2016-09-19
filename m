From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 19 Sep 2016 15:41:44 +0100
Subject: [PATCH v3 1/8] scpi: Add cmd indirection table to prepare for
 legacy commands
In-Reply-To: <1473262477-18045-2-git-send-email-narmstrong@baylibre.com>
References: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
 <1473262477-18045-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <213c023d-bac8-5148-4846-8501501bddf2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On 07/09/16 16:34, Neil Armstrong wrote:
> Add indirection table to permit multiple command values for legacy support.
>

I wrote the most of the patch and you changed the author too ;)

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/firmware/arm_scpi.c | 145 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 127 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 4388937..9a87687 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c

[..]

> @@ -161,6 +194,7 @@ struct scpi_drvinfo {
>  	u32 protocol_version;
>  	u32 firmware_version;
>  	int num_chans;
> +	int *scpi_cmds;
>  	atomic_t next_chan;
>  	struct scpi_ops *scpi_ops;
>  	struct scpi_chan *channels;
> @@ -390,6 +424,19 @@ static u32 scpi_get_version(void)
>  	return scpi_info->protocol_version;
>  }
>
> +static inline int check_cmd(unsigned int offset)
> +{
> +	if (offset >= CMD_MAX_COUNT ||

If we call scpi_send_message internally(as it's static) why is this
check needed ?


> +	    !scpi_info ||
> +	    !scpi_info->scpi_cmds)

Will be even reach to this point if above is true ?

> +		return -EINVAL;
> +
> +	if (scpi_info->scpi_cmds[offset] < 0)
> +		return -EOPNOTSUPP;

IMO just above couple of lines in the beginning of scpi_send_message
will suffice. You can just add this to my original patch.

>  static int
>  scpi_clk_get_range(u16 clk_id, unsigned long *min, unsigned long *max)
>  {
> @@ -397,8 +444,13 @@ scpi_clk_get_range(u16 clk_id, unsigned long *min, unsigned long *max)
>  	struct clk_get_info clk;
>  	__le16 le_clk_id = cpu_to_le16(clk_id);
>
> -	ret = scpi_send_message(SCPI_CMD_GET_CLOCK_INFO, &le_clk_id,
> -				sizeof(le_clk_id), &clk, sizeof(clk));
> +	ret = check_cmd(CMD_GET_CLOCK_INFO);
> +	if (ret)
> +		return ret;
> +

It's totally unnecessary to add check in each and every function calling
scpi_send_message, why not add it to scpi_send_message instead.

-- 
Regards,
Sudeep
