From: dianders@chromium.org (Doug Anderson)
Date: Wed, 1 Oct 2014 15:47:06 -0700
Subject: [PATCH] i2c: rk3x: fix 0 length write transfers
In-Reply-To: <1412185241-24950-1-git-send-email-amstan@chromium.org>
References: <1412185241-24950-1-git-send-email-amstan@chromium.org>
Message-ID: <CAD=FV=VV1U2o41iz_NANvk=EZcMcrurvhN31s--_srU=4yuWcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex,

On Wed, Oct 1, 2014 at 10:40 AM, Alexandru M Stan <amstan@chromium.org> wrote:
> i2cdetect -q was broken (everything was a false positive, and no transfers were
> actually being sent over i2c). The way it works is by sending a 0 length write
> request and checking for NACK. This patch fixes the 0 length writes and actually
> sends them.
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> ---
>  drivers/i2c/busses/i2c-rk3x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index b41d979..f486d0e 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -238,7 +238,7 @@ static void rk3x_i2c_fill_transmit_buf(struct rk3x_i2c *i2c)
>         for (i = 0; i < 8; ++i) {
>                 val = 0;
>                 for (j = 0; j < 4; ++j) {
> -                       if (i2c->processed == i2c->msg->len)
> +                       if ((i2c->processed == i2c->msg->len) && (cnt != 0))

This looks good to me.  Basically we still need to write the address
of the device onto the bus even if there's no data.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

-Doug
