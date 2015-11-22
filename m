From: broonie@kernel.org (Mark Brown)
Date: Sun, 22 Nov 2015 13:44:40 +0000
Subject: [PATCH v4 2/3] ASoC: cygnus: Add Cygnus audio DAI driver
In-Reply-To: <1447114664-21799-3-git-send-email-ssimran@broadcom.com>
References: <1447114664-21799-1-git-send-email-ssimran@broadcom.com>
 <1447114664-21799-3-git-send-email-ssimran@broadcom.com>
Message-ID: <20151122134440.GQ26072@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 04:17:43PM -0800, Simran Rai wrote:

> +#ifdef CONFIG_PM_SLEEP
> +static int cygnus_ssp_suspend(struct snd_soc_dai *cpu_dai)
> +{
> +	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(cpu_dai);
> +	struct cygnus_audio *cygaud = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	audio_ssp_out_disable(aio);
> +	audio_ssp_in_disable(aio);
> +	if (cygaud->active_ports > 0)
> +		cygaud->active_ports--;
> +
> +	return 0;
> +}
> +
> +static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
> +{
> +	return 0;
> +}

I'm a bit confused here - why do we need to disable things on suspend
but not reenable them on resume?  I'd expect that the core would have
quiesced any streams that need to be suspended before we get as far as
suspending the drivers.

Please also remove empty functions.

Now I check I see that I'm repeating the questions I had on my previous
review:

| Blank line between functions and remove empty functions.  Though I'm not
| clear why the result doesn't undo what the suspend did...

Please don't ignore review comments.

> +	parent = clk_get_parent(cygaud->audio_clk[0]);
> +	if (IS_ERR(parent)) {
> +		error = PTR_ERR(parent);
> +		goto err_get_parent;
> +	}
> +
> +	/* Set PLL VCO Frequency (Hz) to default */
> +	error = clk_set_rate(parent, DEFAULT_VCO);
> +	if (error) {
> +		dev_err(&pdev->dev,
> +			"%s Set PLL VCO rate failed: %d\n", __func__, error);
> +		goto err_get_parent;
> +	}

I would expect any initialisationn of clocks beyond the ones that the
device directly interacts with to be handled within the clock API
configuration rather than in a specific driver, this avoids the driver
being dependent on a particular system integration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151122/33925a71/attachment.sig>
