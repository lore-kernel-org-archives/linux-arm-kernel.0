From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Nov 2015 17:12:53 +0100
Subject: [PATCH 03/10] pwm: sunxi: Yield some time to the pwm-block to
 become ready
In-Reply-To: <1445895161-2317-4-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-4-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <20151106161253.GH8418@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 10:32:34PM +0100, Olliver Schinagl wrote:
> The pwm-block of some of the sunxi chips feature a 'ready' flag to
> indicate the software that it is ready for new commands.
> 
> Right now, when we call pwm_config and set the period, we write the
> values to the registers, and turn off the clock to the IP. Because of
> this, the hardware does not have time to configure the hardware and set
> the 'ready' flag.
> 
> By running the clock just before making new changes and before checking
> if the hardware is ready, the hardware has time to reconfigure itself
> and set the clear the flag appropriately.
> 
> Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)

This looks okay to me (except for one minor thing I noticed, see below),
but I'd like an Acked-by from one of the sunxi people. Maxime, any
comments on this?

> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 58ff424..4d84d9d 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -104,6 +104,22 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u64 clk_rate, div = 0;
>  	unsigned int prescaler = 0;
>  	int err;
> +	int ret = 0;

Why not reuse err?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/1c46750c/attachment-0001.sig>
