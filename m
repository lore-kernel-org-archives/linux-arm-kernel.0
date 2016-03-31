From: simran.rai@broadcom.com (Simran Rai)
Date: Wed, 30 Mar 2016 17:09:10 -0700
Subject: [PATCH resend v5 2/3] ASoC: cygnus: Add Cygnus audio DAI driver
In-Reply-To: <20160329221634.GQ2350@sirena.org.uk>
References: <1459277192-10942-1-git-send-email-simran.rai@broadcom.com>
 <1459277192-10942-3-git-send-email-simran.rai@broadcom.com>
 <20160329221634.GQ2350@sirena.org.uk>
Message-ID: <CAES42NZ2EjuTNArnLEOTW69qKGRxnfbkJw-eo96USZ0YJdH1aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Resending my replies as plain text.Apologies for the duplicate.

On Tue, Mar 29, 2016 at 3:16 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 29, 2016 at 11:46:31AM -0700, Simran Rai wrote:
>
> A few issues here, a lot of them are stylistic though there's what look
> like a couple of small bugs here too.
>
>> +static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio,
>> +                     struct cygnus_audio *cygaud)
>> +{
>> +     u32 value, i = 0;
>> +     u32 mask = 0xf;
>> +     u32 sclk;
>> +     bool found = false;
>> +     const struct _ssp_clk_coeff *p_entry = NULL;
>> +
>> +     if ((!aio->lrclk) || (!aio->bit_per_frame)) {
>> +             dev_err(aio->cygaud->dev, "First set up port through hw_params()\n");
>> +             return -EINVAL;
>> +     }
>
> This function is only ever called from one site in hw_prams().  What is
> this defending against?  A check like this seems very worrying, if it
> ever goes off that seems to indicate either something is seriously wrong
> or we should be recording something then coming back and trying again
> later.
Will remove it.
>
>> +     for (i = 0; i < ARRAY_SIZE(ssp_clk_coeff); i++) {
>> +             p_entry = &ssp_clk_coeff[i];
>> +             if ((p_entry->rate == aio->lrclk) &&
>> +                             (p_entry->sclk_rate == aio->bit_per_frame) &&
>> +                             (p_entry->mclk == aio->mclk)) {
>
> Why the strange indentation here?
Will fix this.
>
>> +     /* Set sclk rate */
>> +     if (aio->port_type == PORT_TDM) {
>
> switch statment here for extensibility.
Will replace.
>
>> +             /* Configure channels as mono or stereo */
>> +             if (params_channels(params) == 1) {
>> +                     value = readl(aio->cygaud->audio +
>> +                             aio->regs.bf_sourcech_cfg);
>> +                     value |= BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
>> +                     value &= ~BIT(BF_SRC_CFGX_BUFFER_PAIR_ENABLE);
>> +                     writel(value, aio->cygaud->audio +
>> +                             aio->regs.bf_sourcech_cfg);
>> +             } else {
>> +                     value = readl(aio->cygaud->audio +
>> +                             aio->regs.bf_sourcech_cfg);
>> +                     value &= ~BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
>> +                     writel(value, aio->cygaud->audio +
>> +                             aio->regs.bf_sourcech_cfg);
>> +             }
>
> Either this should be a switch statement or the comment should say we
> support more than stereo.  It's also not clear to me how
> BUFFER_PAIR_ENABLE gets set again if we go from mono to stereo.
Will change to switch statement. Thanks for exposing the bug related to
BUFFER_PAIR_ENABLE. Will fix it.
>
>> +     if (!aio->is_slave) {
>> +             if (aio->clk_trace.cap_clk_en)
>> +                     clk_prepare_enable(aio->cygaud->
>> +                                     audio_clk[aio->pll_clk_num]);
>
> Should check the return value of clk_prepare_enable().
Will do.
>
>> +     .playback = {
>> +             .channels_min = 2,
>> +             .channels_max = 2,
>> +             .rates = CYGNUS_TDM_RATE | SNDRV_PCM_RATE_88200 |
>> +                     SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
>> +                     SNDRV_PCM_RATE_192000,
>> +             .formats = SNDRV_PCM_FMTBIT_S16_LE |
>> +                     SNDRV_PCM_FMTBIT_S32_LE,
>
> According to hw_params() the driver also supports S8 and S24.
SSP and TDM playback supports S8, S16 and S32. SSP and TDM capture
supports S16 and S32. SPDIF playback supports S16 and S32. Will fix the
code to reflect this.
>
>> +     if (port_type == PORT_TDM) {
>
>> +     } else { /* SPDIF case */
>
> switch statement...
Will do.

Thanks,
Simran
