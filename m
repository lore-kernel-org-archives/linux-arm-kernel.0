From: dianders@chromium.org (Doug Anderson)
Date: Wed, 31 Aug 2016 15:24:36 -0700
Subject: [PATCH] ASoC: rockchip: implement system suspend/resume for i2s
In-Reply-To: <1467686711-52347-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1467686711-52347-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <CAD=FV=VF7NJ0+tbuWsKOxFnFS+hBqhbXmMhs5w_+DJ3EdBW9bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 4, 2016 at 7:45 PM, Sugar Zhang <sugar.zhang@rock-chips.com> wrote:
> restore hw registers after power loss during a suspend/resume cycle.
>
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
>
>  sound/soc/rockchip/rockchip_i2s.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
> index 574c6af..53970ac 100644
> --- a/sound/soc/rockchip/rockchip_i2s.c
> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -614,9 +614,35 @@ static const struct of_device_id rockchip_i2s_match[] = {
>         {},
>  };
>
> +#ifdef CONFIG_PM_SLEEP
> +static int rockchip_i2s_suspend(struct device *dev)

Rather than #ifdef, I think that the currently suggested way to do
this is to use __maybe_unused, like:
  static __maybe_unused int rockchip_i2s_suspend(struct device *dev)

> +{
> +       struct rk_i2s_dev *i2s = dev_get_drvdata(dev);
> +
> +       regcache_mark_dirty(i2s->regmap);
> +
> +       return 0;
> +}

I do wonder a little bit if we should be doing this work in pm_runtime
instead of actually adding suspend/resume hooks.

I think that technically you end up losing state when your power
domain dies, right?  Looking at rk3399, I see that i2s is in
"pd_sdioaudio" along with "sdio, spi, i2s, spdif".  That means (I
think) that if all of those peripherals happen to runtime suspend at
the same time (or they are totally unused) then you'll lose state when
you are runtime suspended.  Then when you runtime resume you need to
restore.

Maybe in your case you never actually get into the situation where the
power domain turns off except during suspend/resume, but it seems
possible it could happen.

Am I understanding this all properly?  Maybe someone can correct me.
I'm still a bit of a PM Runtime noob.


-Doug
