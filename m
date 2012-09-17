From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 17 Sep 2012 16:09:34 +0400
Subject: [PATCH] spi: pl022:  Add clk_{un}prepare() support in runtime PM
In-Reply-To: <1f784b72399e0e96414f00866b209e2e218065af.1347877746.git.vipulkumar.samar@st.com>
References: <1f784b72399e0e96414f00866b209e2e218065af.1347877746.git.vipulkumar.samar@st.com>
Message-ID: <505712FE.3040500@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-09-2012 14:37, Vipul Kumar Samar wrote:

> clk_{un}prepare is mandatory for platforms using common clock framework. Add
> clk_{un}prepare() support for spi-pl022 runtime PM.

> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
[...]

> @@ -2342,10 +2342,13 @@ static int pl022_runtime_suspend(struct device *dev)
>   static int pl022_runtime_resume(struct device *dev)
>   {
>   	struct pl022 *pl022 = dev_get_drvdata(dev);
> +	int ret = 0;

    Don't need to init it at all.

> -	clk_enable(pl022->clk);
> +	ret = clk_prepare_enable(pl022->clk);
> +	if (ret)
> +		dev_err(dev, "could not enable SSP/SPI bus clock\n");
>
> -	return 0;
> +	return ret;
>   }
>   #endif

WBR, Sergei
