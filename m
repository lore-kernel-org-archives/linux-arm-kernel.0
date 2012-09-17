From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 17 Sep 2012 16:20:50 +0530
Subject: [PATCH] spi: pl022: Add clk_{un}prepare() support in runtime PM
In-Reply-To: <1f784b72399e0e96414f00866b209e2e218065af.1347877746.git.vipulkumar.samar@st.com>
References: <1f784b72399e0e96414f00866b209e2e218065af.1347877746.git.vipulkumar.samar@st.com>
Message-ID: <CAOh2x==hxYpfQtW6vzgvqp8YFhtxyESnS5_ebjwO9c0K5FHqhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 4:07 PM, Vipul Kumar Samar
<vipulkumar.samar@st.com> wrote:
> clk_{un}prepare is mandatory for platforms using common clock framework. Add
> clk_{un}prepare() support for spi-pl022 runtime PM.

You are not calling these routines in actualy patch.. Fix commit log and add my
Reviewed-by.

> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> ---
>  drivers/spi/spi-pl022.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index f2a80ff..500e75e 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2334,7 +2334,7 @@ static int pl022_runtime_suspend(struct device *dev)
>  {
>         struct pl022 *pl022 = dev_get_drvdata(dev);
>
> -       clk_disable(pl022->clk);
> +       clk_disable_unprepare(pl022->clk);
>
>         return 0;
>  }
> @@ -2342,10 +2342,13 @@ static int pl022_runtime_suspend(struct device *dev)
>  static int pl022_runtime_resume(struct device *dev)
>  {
>         struct pl022 *pl022 = dev_get_drvdata(dev);
> +       int ret = 0;
>
> -       clk_enable(pl022->clk);
> +       ret = clk_prepare_enable(pl022->clk);
> +       if (ret)
> +               dev_err(dev, "could not enable SSP/SPI bus clock\n");
>
> -       return 0;
> +       return ret;
>  }
>  #endif
>
> --
> 1.7.2.2
>
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
