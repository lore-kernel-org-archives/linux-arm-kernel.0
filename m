From: robert.marklund@stericsson.com (Robert MARKLUND)
Date: Thu, 21 Feb 2013 15:20:56 +0100
Subject: [RFC 2/8] coresight: add CoreSight TMC driver
In-Reply-To: <1355858365-11849-3-git-send-email-pratikp@codeaurora.org>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
 <1355858365-11849-3-git-send-email-pratikp@codeaurora.org>
Message-ID: <2B1D156D95AE9B4EAD379CB9E465FE73272F65EE48@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is something fishy here.

> +static void __tmc_etb_dump(struct tmc_drvdata *drvdata)
> +{
> +	enum tmc_mem_intf_width memwidth;
> +	uint8_t memwords;
> +	char *bufp;
> +	uint32_t read_data;
> +	int i;
> +
> +	memwidth = BMVAL(tmc_readl(drvdata, CORESIGHT_DEVID), 8, 10);
> +	if (memwidth == TMC_MEM_INTF_WIDTH_32BITS)
> +		memwords = 1;
> +	else if (memwidth == TMC_MEM_INTF_WIDTH_64BITS)
> +		memwords = 2;
> +	else if (memwidth == TMC_MEM_INTF_WIDTH_128BITS)
> +		memwords = 4;
> +	else
> +		memwords = 8;
> +
> +	bufp = drvdata->buf;
> +	while (1) {
> +		for (i = 0; i < memwords; i++) {
> +			read_data = tmc_readl(drvdata, TMC_RRD);
> +			if (read_data == 0xFFFFFFFF)
> +				return;
> +			memcpy(bufp, &read_data, BYTES_PER_WORD);
> +			bufp += BYTES_PER_WORD;
> +		}
This will loop for every if in ETB mode because it will trace the reading because we have not disabled it before this.
So maybe disable it first and as a security check for buffer size you have it in the drvdata I think.

> +	}
> +}
> +
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

BR
Robert
