From: david@lechnology.com (David Lechner)
Date: Wed, 4 Apr 2018 10:52:46 -0500
Subject: [PATCH] ARM: davinci: dm644x: remove unnecessary
 postcore_initcall()
In-Reply-To: <20180404125759.27061-1-nsekhar@ti.com>
References: <20180404125759.27061-1-nsekhar@ti.com>
Message-ID: <87b4ad61-93f4-db74-d373-9e8ac0d1a5b9@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2018 07:57 AM, Sekhar Nori wrote:
> dm644x_init_devices() is unnecessarily implemented as a
> postcore_initcall().
> 
> This does not cause any issues now, but creates issues when
> converting to common clock framework where clocks themselves
> become platform devices and are initialized later. Because of
> this, device clock acquisition and runtime PM on that device
> fails.
> 
> Move the call to .init_machine() callback along with rest of
> platform device's registration.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>   arch/arm/mach-davinci/board-dm644x-evm.c  | 5 +++++
>   arch/arm/mach-davinci/board-neuros-osd2.c | 5 +++++
>   arch/arm/mach-davinci/board-sffsdr.c      | 6 ++++++
>   arch/arm/mach-davinci/davinci.h           | 1 +
>   arch/arm/mach-davinci/dm644x.c            | 6 +-----
>   5 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> index 95b55aae1366..d1a7239a80d6 100644
> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> @@ -768,6 +768,11 @@ static __init void davinci_evm_init(void)
>   	struct clk *aemif_clk;
>   	struct davinci_soc_info *soc_info = &davinci_soc_info;
>   
> +	ret = dm644x_init_devices();
> +	if (ret)
> +		pr_warn("%s: dm644x_init_devices() failed: %d\n",
> +			__func__, ret);
> +
>   	ret = dm644x_gpio_register();
>   	if (ret)
>   		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
> diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
> index f2875770fbff..23f4f0b70752 100644
> --- a/arch/arm/mach-davinci/board-neuros-osd2.c
> +++ b/arch/arm/mach-davinci/board-neuros-osd2.c
> @@ -174,6 +174,11 @@ static __init void davinci_ntosd2_init(void)
>   	struct clk *aemif_clk;
>   	struct davinci_soc_info *soc_info = &davinci_soc_info;
>   
> +	ret = dm644x_init_devices();
> +	if (ret)
> +		pr_warn("%s: dm644x_init_devices() failed: %d\n",
> +			__func__, ret);
> +
>   	ret = dm644x_gpio_register();
>   	if (ret)
>   		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
> diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
> index 2922da9d1684..d9900d7c26d3 100644
> --- a/arch/arm/mach-davinci/board-sffsdr.c
> +++ b/arch/arm/mach-davinci/board-sffsdr.c
> @@ -133,6 +133,12 @@ static void __init davinci_sffsdr_map_io(void)
>   static __init void davinci_sffsdr_init(void)
>   {
>   	struct davinci_soc_info *soc_info = &davinci_soc_info;
> +	int ret;
> +
> +	ret = dm644x_init_devices();
> +	if (ret)
> +		pr_warn("%s: dm644x_init_devices() failed: %d\n",
> +			__func__, ret);

dm644x_init_devices() already prints a warning in all failure cases, so
printing another warning seems a bit redundant. It is probably OK to just
ignore the return value here and in the similar uses above.
