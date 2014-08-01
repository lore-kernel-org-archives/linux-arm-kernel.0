From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 01 Aug 2014 18:08:55 +0400
Subject: [PATCH] dma: at_hdmac: fix invalid remaining bytes detection
In-Reply-To: <1406887406-10567-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1406887406-10567-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <53DB9F77.6000102@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/01/2014 02:03 PM, Alexandre Belloni wrote:

> Found using smatch:
> drivers/dma/at_hdmac.c:299 atc_get_bytes_left() warn: unsigned
> 'atchan->remain_desc' is never less than zero.

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   drivers/dma/at_hdmac.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index c13a3bb0f594..9ec84ee2fa25 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -294,14 +294,16 @@ static int atc_get_bytes_left(struct dma_chan *chan)
>   			ret = -EINVAL;
>   			goto out;
>   		}
> -		atchan->remain_desc -= (desc_cur->lli.ctrla & ATC_BTSIZE_MAX)
> -						<< (desc_first->tx_width);
> -		if (atchan->remain_desc < 0) {
> +
> +		count = (desc_cur->lli.ctrla & ATC_BTSIZE_MAX)
> +			<< (desc_first->tx_width);

    Parens not needed here.

[...]

WBR, Sergei
