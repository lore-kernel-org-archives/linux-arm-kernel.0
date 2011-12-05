From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 5 Dec 2011 23:52:45 +0530
Subject: [PATCH v2 2/4] regulator: pass device_node to
 of_get_regulator_init_data()
In-Reply-To: <1322731268-12158-3-git-send-email-shawn.guo@linaro.org>
References: <1322731268-12158-1-git-send-email-shawn.guo@linaro.org>
 <1322731268-12158-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAJuYYwShCJ5kWRNuQRCFsGptfXwKA9ogVD8=3WO-N9FFSFca1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2011 14:51, Shawn Guo <shawn.guo@linaro.org> wrote:
> It's not always true that the device_node of regulator can be found
> at dev->of_node at the time when of_get_regulator_init_data() is being
> called, because in some cases the regulator nodes in device tree do
> not have 'struct device' behind them until regulator_dev gets created
> for it by core function regulator_register().
>
> The patch adds device_node as a new parameter to
> of_get_regulator_init_data(), so that caller can pass in the node of
> regulator directly.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> ---
> ?drivers/regulator/fixed.c ? ? ? ? ? ? ?| ? ?2 +-
> ?drivers/regulator/of_regulator.c ? ? ? | ? ?7 ++++---
> ?include/linux/regulator/of_regulator.h | ? ?6 ++++--
> ?3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index 72abbf5..a44a017 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -64,7 +64,7 @@ of_get_fixed_voltage_config(struct device *dev)
> ? ? ? ?if (!config)
> ? ? ? ? ? ? ? ?return NULL;
>
> - ? ? ? config->init_data = of_get_regulator_init_data(dev);
> + ? ? ? config->init_data = of_get_regulator_init_data(dev, dev->of_node);
> ? ? ? ?if (!config->init_data)
> ? ? ? ? ? ? ? ?return NULL;
>
> diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
> index acd7045..6caf641 100644
> --- a/drivers/regulator/of_regulator.c
> +++ b/drivers/regulator/of_regulator.c
> @@ -66,18 +66,19 @@ static void of_get_regulation_constraints(struct device_node *np,
> ?* tree node, returns a pointer to the populated struture or NULL if memory
> ?* alloc fails.
> ?*/
> -struct regulator_init_data *of_get_regulator_init_data(struct device *dev)
> +struct regulator_init_data *of_get_regulator_init_data(struct device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct device_node *node)

The new parameter 'node' should be added in the documentation which is
above this function.

> ?{
> ? ? ? ?struct regulator_init_data *init_data;
>
> - ? ? ? if (!dev->of_node)
> + ? ? ? if (!node)
> ? ? ? ? ? ? ? ?return NULL;
>
> ? ? ? ?init_data = devm_kzalloc(dev, sizeof(*init_data), GFP_KERNEL);
> ? ? ? ?if (!init_data)
> ? ? ? ? ? ? ? ?return NULL; /* Out of memory? */
>
> - ? ? ? of_get_regulation_constraints(dev->of_node, &init_data);
> + ? ? ? of_get_regulation_constraints(node, &init_data);
> ? ? ? ?return init_data;
> ?}
> ?EXPORT_SYMBOL_GPL(of_get_regulator_init_data);
> diff --git a/include/linux/regulator/of_regulator.h b/include/linux/regulator/of_regulator.h
> index d83a98d..769704f 100644
> --- a/include/linux/regulator/of_regulator.h
> +++ b/include/linux/regulator/of_regulator.h
> @@ -8,10 +8,12 @@
>
> ?#if defined(CONFIG_OF)
> ?extern struct regulator_init_data
> - ? ? ? *of_get_regulator_init_data(struct device *dev);
> + ? ? ? *of_get_regulator_init_data(struct device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct device_node *node);
> ?#else
> ?static inline struct regulator_init_data
> - ? ? ? *of_get_regulator_init_data(struct device *dev)
> + ? ? ? *of_get_regulator_init_data(struct device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct device_node *node)
> ?{
> ? ? ? ?return NULL;
> ?}

This was useful while adding regulator DT support for Origen board.
Acked-by: Thomas Abraham <thomas.abraham@linaro.org>


> --
> 1.7.4.1
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
