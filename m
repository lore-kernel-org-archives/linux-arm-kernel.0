From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 22 Mar 2018 09:33:26 +0100
Subject: [PATCH v2] i2c: i2c-stm32f7: fix no check on returned setup
In-Reply-To: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
References: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <f6763dfd-9535-1206-fed0-a611b9ea81b7@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/21/2018 05:48 PM, Pierre-Yves MORDRET wrote:
> Before assigning returned setup structure check if not null
> 
> Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>       v1:
>           * Initial
>       v2:
>           * fill "ret" with error statement before go to "clk_free"
> ---
> ---
>   drivers/i2c/busses/i2c-stm32f7.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index b445b3b..f273e28 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -888,6 +888,11 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>   	}
>   
>   	setup = of_device_get_match_data(&pdev->dev);
> +	if (!setup) {
> +		dev_err(&pdev->dev, "Can't get device data\n");
> +		ret = -ENODEV;
> +		goto clk_free;
> +	}
>   	i2c_dev->setup = *setup;
>   
>   	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-rising-time-ns",
> 
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
