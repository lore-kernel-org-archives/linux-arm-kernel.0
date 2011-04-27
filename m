From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Wed, 27 Apr 2011 12:33:08 +0530
Subject: [PATCH v4 11/11] da850: pruss CAN board specific additions.
In-Reply-To: <4DB6A509.2010009@mvista.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-12-git-send-email-subhasish@mistralsolutions.com>
	<4DB6A509.2010009@mvista.com>
Message-ID: <1F65A5A7A9494B73A22BDA7D64355767@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> +static int __init da850_evm_pruss_can_setup(void)
>> +{
>> + int ret, val = 0;
>> + void __iomem *cfg_chip3_reg;
>> +
>> + ret = davinci_cfg_reg_list(da850_evm_pruss_can_pins);
>> + if (ret)
>> + pr_warning("%s: da850_evm_pruss_can_pins mux setup "
>> + "failed:%d\n", __func__, ret);
>
>    Yet you continue to initialize... you should stop here I think.

SG - Ok, will ret error.

>
>> + /* value = 0 to enable the CAN transceiver */
>> + ret = gpio_request_one(DA850_PRUSS_CAN_TRX_PIN,
>> + GPIOF_OUT_INIT_LOW, "pruss_can_en");
>> + if (ret) {
>> + pr_warning("Cannot setup GPIO %d\n", DA850_PRUSS_CAN_TRX_PIN);
>> + gpio_free(DA850_PRUSS_CAN_TRX_PIN);
>
>    Doesn't gpio_request_one() handle freeing GPIO on error?

SG - It does handle error, will remove. But I have another problem,
        Suppose the init failed due to some other reason during probe.
        How can I do a gpio_free, do I need some kind of deinit for the 
setup ?

 
