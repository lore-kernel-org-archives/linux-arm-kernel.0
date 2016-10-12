From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 12 Oct 2016 16:07:48 +0300
Subject: [PATCH 6/10] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
In-Reply-To: <4009a66b-1e09-0780-b7c1-128ff1401b5f@marvell.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <ecde22fd342b0b2001ff5676ea1e67b7226d6946.1475853198.git-series.gregory.clement@free-electrons.com>
 <1b015f16-aa37-591c-3299-9431f6e82cce@intel.com>
 <4009a66b-1e09-0780-b7c1-128ff1401b5f@marvell.com>
Message-ID: <7939a923-eb97-ca44-ac4c-f0a3cd4f45bc@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/16 14:58, Ziji Hu wrote:
> Hi Adrian,
> 
> 	Thank you very much for your review.
> 	I will firstly fix the typo.
> 
> On 2016/10/11 20:37, Adrian Hunter wrote:
>> On 07/10/16 18:22, Gregory CLEMENT wrote:
>>> From: Ziji Hu <huziji@marvell.com>
>>>
>>> Add Xenon eMMC/SD/SDIO host controller core functionality.
>>> Add Xenon specific intialization process.
>>> Add Xenon specific mmc_host_ops APIs.
>>> Add Xenon specific register definitions.
>>>
>>> Add CONFIG_MMC_SDHCI_XENON support in drivers/mmc/host/Kconfig.
>>>
>>> Marvell Xenon SDHC conforms to SD Physical Layer Specification
>>> Version 3.01 and is designed according to the guidelines provided
>>> in the SD Host Controller Standard Specification Version 3.00.
>>>
>>> Signed-off-by: Hu Ziji <huziji@marvell.com>
>>> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> I looked at a couple of things but you need to sort out the issues with
>> card_candidate before going further.
>>
> 	Understood.
> 	I will improve the card_candidate. Please help check the details in below.
> 
>>> ---
> <snip>
>>> +
>>> +static int xenon_emmc_signal_voltage_switch(struct mmc_host *mmc,
>>> +					    struct mmc_ios *ios)
>>> +{
>>> +	unsigned char voltage = ios->signal_voltage;
>>> +
>>> +	if ((voltage == MMC_SIGNAL_VOLTAGE_330) ||
>>> +	    (voltage == MMC_SIGNAL_VOLTAGE_180))
>>> +		return __emmc_signal_voltage_switch(mmc, voltage);
>>> +
>>> +	dev_err(mmc_dev(mmc), "Unsupported signal voltage: %d\n",
>>> +		voltage);
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
>>> +					     struct mmc_ios *ios)
>>> +{
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>> +
>>> +	/*
>>> +	 * Before SD/SDIO set signal voltage, SD bus clock should be
>>> +	 * disabled. However, sdhci_set_clock will also disable the Internal
>>> +	 * clock in mmc_set_signal_voltage().
>>> +	 * If Internal clock is disabled, the 3.3V/1.8V bit can not be updated.
>>> +	 * Thus here manually enable internal clock.
>>> +	 *
>>> +	 * After switch completes, it is unnecessary to disable internal clock,
>>> +	 * since keeping internal clock active obeys SD spec.
>>> +	 */
>>> +	enable_xenon_internal_clk(host);
>>> +
>>> +	if (priv->card_candidate) {
>>
>> mmc_power_up() calls __mmc_set_signal_voltage() calls
>> host->ops->start_signal_voltage_switch so priv->card_candidate could be an
>> invalid reference to an old card.
>>
>> So that's not going to work if the card changes - not only for removable
>> cards but even for eMMC if init fails and retries.
>>
> 	As you point out, this piece of code have defects, even though it actually works on Marvell multiple platforms, unless eMMC card is removable.
> 
> 	I can add a property to explicitly indicate eMMC type in DTS.
> 	Then card_candidate access can be removed here.
> 	Does it sounds more reasonable to you?

Sure

> 
>>> +		if (mmc_card_mmc(priv->card_candidate))
>>> +			return xenon_emmc_signal_voltage_switch(mmc, ios);
>>
>> So if all you need to know is whether it is a eMMC, why can't DT tell you?
>>
> 	I can add an eMMC type property in DTS, to remove the card_candidate access here.
> 
>>> +	}
>>> +
>>> +	return sdhci_start_signal_voltage_switch(mmc, ios);
>>> +}
>>> +
>>> +/*
>>> + * After determining which slot is used for SDIO,
>>> + * some additional task is required.
>>> + */
>>> +static void xenon_init_card(struct mmc_host *mmc, struct mmc_card *card)
>>> +{
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +	u32 reg;
>>> +	u8 slot_idx;
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>> +
>>> +	/* Link the card for delay adjustment */
>>> +	priv->card_candidate = card;
>>
>> You really need a better way to get the card.  I suggest you take up the
>> issue with Ulf.  One possibility is to have mmc core set host->card = card
>> much earlier.
>>
> 	Could you please tell me if any issue related to card_candidate still exists, after the card_candidate is removed from xenon_start_signal_voltage_switch() in above?
> 	It seems that when init_card is called, the structure card has already been updated and stable in MMC/SD/SDIO initialization sequence.
> 	May I keep it here?

It works by accident rather than by design.  We can do better.

> 
>>> +	/* Set tuning functionality of this slot */
>>> +	xenon_slot_tuning_setup(host);
>>> +
>>> +	slot_idx = priv->slot_idx;
>>> +	if (!mmc_card_sdio(card)) {
>>> +		/* Re-enable the Auto-CMD12 cap flag. */
>>> +		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>>> +		host->flags |= SDHCI_AUTO_CMD12;
>>> +
>>> +		/* Clear SDIO Card Inserted indication */
>>> +		reg = sdhci_readl(host, SDHC_SYS_CFG_INFO);
>>> +		reg &= ~(1 << (slot_idx + SLOT_TYPE_SDIO_SHIFT));
>>> +		sdhci_writel(host, reg, SDHC_SYS_CFG_INFO);
>>> +
>>> +		if (mmc_card_mmc(card)) {
>>> +			mmc->caps |= MMC_CAP_NONREMOVABLE;
>>> +			if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))
>>> +				mmc->caps |= MMC_CAP_1_8V_DDR;
>>> +			/*
>>> +			 * Force to clear BUS_TEST to
>>> +			 * skip bus_test_pre and bus_test_post
>>> +			 */
>>> +			mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
>>> +			mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
>>> +				      MMC_CAP2_PACKED_CMD;
>>> +			if (mmc->caps & MMC_CAP_8_BIT_DATA)
>>> +				mmc->caps2 |= MMC_CAP2_HS400_1_8V;
>>> +		}
>>> +	} else {
>>> +		/*
>>> +		 * Delete the Auto-CMD12 cap flag.
>>> +		 * Otherwise, when sending multi-block CMD53,
>>> +		 * Driver will set Transfer Mode Register to enable Auto CMD12.
>>> +		 * However, SDIO device cannot recognize CMD12.
>>> +		 * Thus SDHC will time-out for waiting for CMD12 response.
>>> +		 */
>>> +		host->quirks &= ~SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>>> +		host->flags &= ~SDHCI_AUTO_CMD12;
>>
>> sdhci_set_transfer_mode() won't enable auto-CMD12 for CMD53 anyway, so is
>> this needed?
>>
> 	In Xenon driver, Auto-CMD12 flag is set to enable full support to Auto-CMD feature, both Auto-CMD12 and Auto-CMD23.
> 	As a result, when Xenon SDHC slot can both support SD and SDIO, Auto-CMD12 is disabled when SDIO card is inserted, and renabled when SD is inserted.
> 
> 	I recheck the sdhci code to set Auto-CMD bit in Transfer Mode register, in sdhci_set_transfer_mode():
> 	if (mmc_op_multi(cmd->opcode) || data->blocks > 1)
> 	As you can see, as long as it is CMD18/CMD25 OR there are multiple data blocks, Auto-CMD field will be set.
> 	CMD53 doesn't have CMD23. Thus Auto-CMD12 is selected since Auto-CMD12 flag is set.
> 	Thus I have to clear Auto-CMD12 to avoid issuing Auto-CMD12 in SDIO transfer.


The code is:

	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
		/*
		 * If we are sending CMD23, CMD12 never gets sent
		 * on successful completion (so no Auto-CMD12).
		 */
		if (sdhci_auto_cmd12(host, cmd->mrq) &&
		    (cmd->opcode != SD_IO_RW_EXTENDED))
			mode |= SDHCI_TRNS_AUTO_CMD12;
		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
			mode |= SDHCI_TRNS_AUTO_CMD23;
			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
		}
	}

You can see the check for SD_IO_RW_EXTENDED which is CMD53.

> 
> 	I just meet a similar issue in RPMB.
> 	When Auto-CMD12 flag is set, eMMC RPMB access will trigger Auto-CMD12, since CMD25 is in use.
> 	It will cause RPMB access failed.

Can you explain more about the RPMB issue.  Doesn't it use CMD23, so CMD12
wouldn't be used - auto or manually.

> 
> 	One possible solution is to drop Auto-CMD12 support and use Auto-CMD23 only, in Xenon driver.
> 	May I know you opinion, please?

I don't use auto-CMD12 because I don't know if it provides any benefit and
sdhci does not seem to have implemented Auto CMD12 Error Recovery, although
I have never looked at it closely.
