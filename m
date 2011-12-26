From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Dec 2011 11:03:49 +0000
Subject: [PATCH 4/4] ASoC: OMAP: ams-delta: drop .set_bias_level callback
In-Reply-To: <1324681944-19067-5-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1324681944-19067-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1324681944-19067-5-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <20111226110348.GB8722@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 24, 2011 at 12:12:24AM +0100, Janusz Krzysztofik wrote:

> +struct regulator_consumer_data {
> +	struct mutex lock;
> +	struct regulator *regulator;
> +	bool enabled;
> +};
> +
> +static int regulator_toggle(struct regulator_consumer_data *consumer,
> +		bool enable)
> +{
> +	int err = 0;
> +
> +	if (!consumer->regulator)
> +		return -ENODEV;
> +
> +	mutex_lock(&consumer->lock);
> +	if (IS_ERR(consumer->regulator)) {
> +		err = PTR_ERR(consumer->regulator);
> +	} else if (enable) {
> +		if (!consumer->enabled) {
> +			err = regulator_enable(consumer->regulator);
> +			consumer->enabled = true;
> +		}
> +	} else {
> +		if (consumer->enabled) {
> +			err = regulator_disable(consumer->regulator);
> +			consumer->enabled = false;
> +		}
> +	}
> +	mutex_unlock(&consumer->lock);
> +
> +	return err;
> +}
> +

Why's this code not been dropped and what is it for?
