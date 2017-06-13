From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 13 Jun 2017 11:53:36 -0600
Subject: [PATCH 03/12] coresight: Extend the PIDR mask to cover relevant
 bits in PIDR2
In-Reply-To: <1497278211-5001-4-git-send-email-suzuki.poulose@arm.com>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170613175336.GC6392@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 03:36:42PM +0100, Suzuki K Poulose wrote:
> As per coresight standards, PIDR2 register has the following format :
> 
>  [2-0]	- JEP106_bits6to4
>  [3]	- JEDEC, designer ID is specified by JEDEC.
> 
> However some of the drivers only use mask of 0x3 for the PIDR2 leaving
> bits [3-2] unchecked, which could potentially match the component for
> a different device altogether. This patch fixes the mask and the
> corresponding id bits for the existing devices.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> I have not touched the TPIU ids for Ux500 (see commit: 4339b699),
> as I don't have a platform to fix/correct the ids.
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c          | 4 ++--
>  drivers/hwtracing/coresight/coresight-replicator-qcom.c | 4 ++--
>  drivers/hwtracing/coresight/coresight-stm.c             | 8 ++++----
>  drivers/hwtracing/coresight/coresight-tmc.c             | 4 ++--
>  drivers/hwtracing/coresight/coresight-tpiu.c            | 4 ++--

Any reason for not adding ETMv3 to the list?  From what I see in the
documentation bit [2-0] need to 0b011 and the JEDEC bit is always 1.

>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 860fe6e..6f7f3d3 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -248,8 +248,8 @@ static const struct dev_pm_ops funnel_dev_pm_ops = {
>  
>  static struct amba_id funnel_ids[] = {
>  	{
> -		.id     = 0x0003b908,
> -		.mask   = 0x0003ffff,
> +		.id     = 0x000bb908,
> +		.mask   = 0x000fffff,
>  	},
>  	{ 0, 0},
>  };
> diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
> index b7e44d1..b029a5f 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
> @@ -177,8 +177,8 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
>  
>  static struct amba_id replicator_ids[] = {
>  	{
> -		.id     = 0x0003b909,
> -		.mask   = 0x0003ffff,
> +		.id     = 0x000bb909,
> +		.mask   = 0x000bffff,
>  		.data	= "REPLICATOR 1.0",
>  	},
>  	{ 0, 0 },
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 93fc26f..1bcda80 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -916,13 +916,13 @@ static const struct dev_pm_ops stm_dev_pm_ops = {
>  
>  static struct amba_id stm_ids[] = {
>  	{
> -		.id     = 0x0003b962,
> -		.mask   = 0x0003ffff,
> +		.id     = 0x000bb962,
> +		.mask   = 0x000fffff,
>  		.data	= "STM32",
>  	},
>  	{
> -		.id	= 0x0003b963,
> -		.mask	= 0x0003ffff,
> +		.id	= 0x000bb963,
> +		.mask	= 0x000fffff,
>  		.data	= "STM500",
>  	},
>  	{ 0, 0},
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 8644887..eb0c7b3 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -393,8 +393,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  static struct amba_id tmc_ids[] = {
>  	{
> -		.id     = 0x0003b961,
> -		.mask   = 0x0003ffff,
> +		.id     = 0x000bb961,
> +		.mask   = 0x000fffff,
>  	},
>  	{ 0, 0},
>  };
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 0673baf..59c1510 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -194,8 +194,8 @@ static const struct dev_pm_ops tpiu_dev_pm_ops = {
>  
>  static struct amba_id tpiu_ids[] = {
>  	{
> -		.id	= 0x0003b912,
> -		.mask	= 0x0003ffff,
> +		.id	= 0x000bb912,
> +		.mask	= 0x000fffff,
>  	},
>  	{
>  		.id	= 0x0004b912,
> -- 
> 2.7.4
> 
