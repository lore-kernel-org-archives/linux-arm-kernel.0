From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Aug 2015 10:48:59 +0100
Subject: [PATCH 1/3] [v2] hvc_dcc: don't ignore errors during
 initialization
In-Reply-To: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
References: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
Message-ID: <20150810094859.GF1604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 01:16:33AM +0100, Timur Tabi wrote:
> hvc_instantiate() and hvc_alloc() return errors if they fail, so don't
> ignore them.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/tty/hvc/hvc_dcc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index 809920d..47654ea 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -70,20 +70,29 @@ static const struct hv_ops hvc_dcc_get_put_ops = {
>  
>  static int __init hvc_dcc_console_init(void)
>  {
> +	int ret;
> +
> +	/* This always runs on boot core */

Does this really "always run on the boot core"? I couldn't find anything
suggesting that console_init is limited in that regard.

Will
