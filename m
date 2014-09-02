From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Sep 2014 19:51:27 +0100
Subject: [PATCH v11 01/19] arm: fiq: Add callbacks to manage FIQ routings
In-Reply-To: <1409662853-29313-2-git-send-email-daniel.thompson@linaro.org>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140902185127.GV30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 02:00:35PM +0100, Daniel Thompson wrote:
>  void enable_fiq(int fiq)
>  {
> +	struct fiq_data *data = lookup_fiq_data(fiq);
> +
> +	if (data) {
> +		if (data->fiq_chip->fiq_enable)
> +			data->fiq_chip->fiq_enable(data->irq_data);
> +		enable_irq(fiq);

Why do we call the FIQ chip's enable and enable_irq() as well?

>  void disable_fiq(int fiq)
>  {
> +	struct fiq_data *data = lookup_fiq_data(fiq);
> +
> +	if (data) {
> +		if (data->fiq_chip->fiq_disable)
> +			data->fiq_chip->fiq_disable(data->irq_data);
> +		disable_irq(fiq);

Same question here.

> +bool has_fiq(int fiq)
> +{
> +	struct fiq_data *data = lookup_fiq_data(fiq);
> +
> +	if (data)
> +		return true;
> +
> +	if (fiq_start == -1)
> +		return false;
> +
> +	return fiq >= fiq_start;

Are you sure this is correct... it looks wrong to me.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
