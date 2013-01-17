From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 17 Jan 2013 15:27:20 +0100
Subject: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
 (Vaibhav Bedia's message of "Mon, 31 Dec 2012 18:37:09 +0530")
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <87ip6vlwaf.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "V" == Vaibhav Bedia <vaibhav.bedia@ti.com> writes:

Hi,

 V> +static void am33xx_pm_firmware_cb(const struct firmware *fw, void *context)
 V> +{
 V> +	struct wkup_m3_context *wkup_m3_context = context;
 V> +	struct platform_device *pdev = to_platform_device(wkup_m3_context->dev);
 V> +	int ret = 0;
 V> +
 V> +	/* no firmware found */
 V> +	if (!fw) {
 V> +		dev_err(wkup_m3_context->dev, "request_firmware failed\n");
 V> +		goto err;
 V> +	}
 V> +
 V> +	memcpy((void *)wkup_m3_context->code, fw->data, fw->size);

A size check would be good. I don't know much about the finer details
about the m3 and how it is connected, but don't you need to ensure data
is flushed before resetting the m3?



 V> +	pr_info("Copied the M3 firmware to UMEM\n");
 V> +
 V> +	wkup_m3->state = M3_STATE_RESET;
 V> +
 V> +	ret = omap_device_deassert_hardreset(pdev, "wkup_m3");
 V> +	if (ret) {
 V> +		pr_err("Could not deassert the reset for WKUP_M3\n");
 V> +		goto err;
 V> +	} else {
 V> +#ifdef CONFIG_SUSPEND
 V> +		suspend_set_ops(&am33xx_pm_ops);
 V> +		/*
 V> +		 * Physical resume address to be used by ROM code
 V> +		 */
 V> +		wkup_m3->ipc_data.resume_addr = (AM33XX_OCMC_END -
 V> +				am33xx_do_wfi_sz + am33xx_resume_offset + 0x4);
 V> +#endif
 V> +		return;
 V> +	}
 V> +
 V> +err:
 V> +	mailbox_put(wkup_m3_context->mbox, &wkup_mbox_notifier);
 V> +}

-- 
Bye, Peter Korsgaard
