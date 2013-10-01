From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 01 Oct 2013 11:42:59 -0700
Subject: [PATCH] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <1380635493-31040-2-git-send-email-zonque@gmail.com> (Daniel
 Mack's message of "Tue, 1 Oct 2013 15:51:33 +0200")
References: <1380635493-31040-1-git-send-email-zonque@gmail.com>
 <1380635493-31040-2-git-send-email-zonque@gmail.com>
Message-ID: <87pproj0i4.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:

> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams.

Please add a little more detail abou why the EDMA loses its context
across suspend/resume (e.g. which power domain(s) its in, and why they
lose context across suspend/resume.

Also, is a full context save necessary every time?  What if no channels
are in use?  Also, is a full restore necessary every time? Are there
cases where the domain doesn't lose context and a restore would not be
necessary?  Often this can be checked by reading register(s) that has a
known power-on reset value.

> The code was shamelessly taken from an ancient BSP tree.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>

[...]

> +static int edma_pm_suspend(struct device *dev)
> +{
> +	int i, j;
> +
> +	pm_runtime_get_sync(dev);
> +
> +	for (i = 0; i < arch_num_cc; i++) {
> +		struct edma *ecc = edma_cc[i];
> +
> +		/* backup channel data */
> +		for (j = 0; j < ecc->num_channels; j++)
> +			ecc->context.ch_map[j] =
> +				edma_read_array(i, EDMA_DCHMAP, j);
> +
> +		/* backup DMA Queue Number */
> +		for (j = 0; j < 8; j++)
> +			ecc->context.que_num[j] =
> +				edma_read_array(i, EDMA_DMAQNUM, j);
> +
> +		/* backup DMA shadow Event Set data */
> +		ecc->context.sh_esr = edma_shadow0_read_array(i, SH_ESR, 0);
> +		ecc->context.sh_esrh = edma_shadow0_read_array(i, SH_ESR, 1);
> +
> +		/* backup DMA Shadow Event Enable Set data */
> +		ecc->context.sh_eesr =
> +			edma_shadow0_read_array(i, SH_EER, 0);
> +		ecc->context.sh_eesrh =
> +			edma_shadow0_read_array(i, SH_EER, 1);
> +
> +		/* backup DMA Shadow Interrupt Enable Set data */
> +		ecc->context.sh_iesr =
> +			edma_shadow0_read_array(i, SH_IER, 0);
> +		ecc->context.sh_iesrh =
> +			edma_shadow0_read_array(i, SH_IER, 1);
> +
> +		ecc->context.que_tc_map = edma_read(i, EDMA_QUETCMAP);
> +
> +		/* backup DMA Queue Priority data */
> +		ecc->context.que_pri = edma_read(i, EDMA_QUEPRI);
> +
> +		/* backup paramset */
> +		for (j = 0; j < ecc->num_slots; j++)
> +			memcpy_fromio(&ecc->context.prm_set[j],
> +				      edmacc_regs_base[i] + PARM_OFFSET(j),
> +				      PARM_SIZE);
> +	}

The actual context save doesn't belong here, it belongs in the
->runtime_suspend callback(), and conversly the context restore belongs
in the ->runtime_resume() callback.

> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}

Kevin
