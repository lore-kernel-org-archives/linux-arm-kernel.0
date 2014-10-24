From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 24 Oct 2014 17:02:37 +0400
Subject: [PATCH v3 2/3] i2c/at91: add support for system PM
In-Reply-To: <1414133417-11530-3-git-send-email-wenyou.yang@atmel.com>
References: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
 <1414133417-11530-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <544A4DED.6090009@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/24/2014 10:50 AM, Wenyou Yang wrote:

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>   drivers/i2c/busses/i2c-at91.c |   26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)

> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index a25fb5e..6a84a2a 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -861,7 +861,33 @@ static int at91_twi_runtime_resume(struct device *dev)
[...]
> +static int at91_twi_resume_noirq(struct device *dev)
> +{
> +	int ret;
> +
> +	if (!pm_runtime_status_suspended(dev)) {
> +		ret = at91_twi_runtime_resume(dev);

    Resume if *not* suspended?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_request_autosuspend(dev);
> +
> +	return 0;
> +}
> +
[...]

WBR, Sergei
