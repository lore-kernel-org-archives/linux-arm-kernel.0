From: ssimran@broadcom.com (Simran Rai)
Date: Tue, 1 Dec 2015 18:17:54 -0800
Subject: [PATCH v4 2/3] ASoC: cygnus: Add Cygnus audio DAI driver
In-Reply-To: <20151122134440.GQ26072@sirena.org.uk>
References: <1447114664-21799-1-git-send-email-ssimran@broadcom.com>
 <1447114664-21799-3-git-send-email-ssimran@broadcom.com>
 <20151122134440.GQ26072@sirena.org.uk>
Message-ID: <565E54D2.50806@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/22/2015 5:44 AM, Mark Brown wrote:
> On Mon, Nov 09, 2015 at 04:17:43PM -0800, Simran Rai wrote:
>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int cygnus_ssp_suspend(struct snd_soc_dai *cpu_dai)
>> +{
>> +	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(cpu_dai);
>> +	struct cygnus_audio *cygaud = snd_soc_dai_get_drvdata(cpu_dai);
>> +
>> +	audio_ssp_out_disable(aio);
>> +	audio_ssp_in_disable(aio);
>> +	if (cygaud->active_ports > 0)
>> +		cygaud->active_ports--;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
>> +{
>> +	return 0;
>> +}
> I'm a bit confused here - why do we need to disable things on suspend
> but not reenable them on resume?  I'd expect that the core would have
> quiesced any streams that need to be suspended before we get as far as
> suspending the drivers.
>
> Please also remove empty functions.
>
> Now I check I see that I'm repeating the questions I had on my previous
> review:
>
> | Blank line between functions and remove empty functions.  Though I'm not
> | clear why the result doesn't undo what the suspend did...
>
> Please don't ignore review comments.

Let me investigate this further and debug why the core did not 
quiescence the streams.

>
>> +	parent = clk_get_parent(cygaud->audio_clk[0]);
>> +	if (IS_ERR(parent)) {
>> +		error = PTR_ERR(parent);
>> +		goto err_get_parent;
>> +	}
>> +
>> +	/* Set PLL VCO Frequency (Hz) to default */
>> +	error = clk_set_rate(parent, DEFAULT_VCO);
>> +	if (error) {
>> +		dev_err(&pdev->dev,
>> +			"%s Set PLL VCO rate failed: %d\n", __func__, error);
>> +		goto err_get_parent;
>> +	}
> I would expect any initialisationn of clocks beyond the ones that the
> device directly interacts with to be handled within the clock API
> configuration rather than in a specific driver, this avoids the driver
> being dependent on a particular system integration.

I will have to figure out a way to propagate the frequency from leaf clocks to the parent
clock. Will send out another patch with the fix.

Thanks,
Simran
