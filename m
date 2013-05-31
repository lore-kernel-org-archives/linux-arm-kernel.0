From: cjb@laptop.org (Chris Ball)
Date: Fri, 31 May 2013 12:15:55 -0400
Subject: [PATCH V4 2/3] ARM: mmc: bcm281xx SDHCI driver
In-Reply-To: <1369860607-25572-2-git-send-email-csd@broadcom.com> (Christian
 Daudt's message of "Wed, 29 May 2013 13:50:06 -0700")
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
 <1369860607-25572-2-git-send-email-csd@broadcom.com>
Message-ID: <87d2s7ceh0.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On Wed, May 29 2013, Christian Daudt wrote:
> +	/* if device is eMMC, emulate card insert right here */
> +	if (kona_dev->non_removable) {
> +		ret = sdhci_bcm_kona_sd_card_emulate(host, 1);
> +		if (ret) {
> +			dev_err(dev,
> +				"unable to emulate card insertion\n");
> +			goto err_remove_host;
> +		}
> +	} else if (gpio_is_valid(kona_dev->cd_gpio)) {
> +		ret = devm_gpio_request(dev, kona_dev->cd_gpio, "sdio cd");
> +		if (ret < 0) {
> +			dev_err(mmc_dev(host->mmc),
> +				"Unable to request GPIO pin %d\n",
> +				kona_dev->cd_gpio);
> +			goto err_remove_host;
> +		}
> +
> +		gpio_direction_input(kona_dev->cd_gpio);
> +
> +		/* Set debounce for SD Card detect to maximum value (128ms)
> +		 *
> +		 * NOTE-1: If gpio_set_debounce() returns error we still
> +		 * continue with the default debounce value set. Another reason
> +		 * for doing this is that on rhea-ray boards the SD Detect GPIO
> +		 * is on GPIO Expander and gpio_set_debounce() will return error
> +		 * and if we return error from here, then probe() would fail and
> +		 * SD detection would always fail.
> +		 *
> +		 * NOTE-2: We also give a msleep() of the "debounce" time here
> +		 * so that we give enough time for the debounce to stabilize
> +		 * before we read the gpio value in gpio_get_value_cansleep().
> +		 */
> +		ret = gpio_set_debounce(kona_dev->cd_gpio,
> +				(SD_DETECT_GPIO_DEBOUNCE_128MS * 1000));
> +		if (ret < 0) {
> +			dev_err(mmc_dev(host->mmc),
> +				"%s: gpio set debounce failed."
> +				"default debounce value assumed\n", __func__);
> +		}
> +
> +		/* Sleep for 128ms to allow debounce to stabilize */
> +		msleep(SD_DETECT_GPIO_DEBOUNCE_128MS);
> +		/* request irq for cd_gpio after the gpio debounce is
> +		 * stabilized, otherwise, some bogus gpio interrupts might be
> +		 * triggered.
> +		 */
> +		irq = gpio_to_irq(kona_dev->cd_gpio);
> +		ret = devm_request_threaded_irq(dev,
> +				irq,
> +				NULL,
> +				sdhci_bcm_kona_pltfm_cd_interrupt,
> +				IRQF_TRIGGER_FALLING|
> +				IRQF_TRIGGER_RISING |
> +				IRQF_ONESHOT |
> +				IRQF_NO_SUSPEND, "sdio cd", host);
> +		if (ret) {
> +			dev_err(mmc_dev(host->mmc),
> +				"Failed irq %d request for gpio=%d ret=%d\n",
> +				gpio_to_irq(kona_dev->cd_gpio),
> +				kona_dev->cd_gpio, ret);
> +			goto err_remove_host;
> +		}
> +		if (gpio_is_valid(kona_dev->wp_gpio)) {
> +			ret = devm_gpio_request(dev,
> +				kona_dev->wp_gpio, "sdio wp");
> +			if (ret < 0) {
> +				dev_err(&pdev->dev,
> +					"Unable to request WP pin %d\n",
> +					kona_dev->wp_gpio);
> +				kona_dev->wp_gpio = -1;
> +			} else {
> +				gpio_direction_input(kona_dev->wp_gpio);
> +			}
> +		}

Could you investigate replacing this section of code with a call to
mmc_of_parse(), please?  It should be able to replace your parsing
and handling of bus-width, cd-gpios, wp-gpios, and non-removable
(other than the initialization quirks specific to your hardware).

I'd like to avoid every driver having its own DT parsing.
Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
