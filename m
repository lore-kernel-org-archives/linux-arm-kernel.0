From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 May 2010 01:52:00 +0100
Subject: [alsa-devel] [patch 3/5] cs42l51: add asoc driver
In-Reply-To: <m38w77gjla.fsf@anduin.mandriva.com>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.121399024@mandriva.com>
	<20100525225151.GA13890@opensource.wolfsonmicro.com>
	<m38w77gjla.fsf@anduin.mandriva.com>
Message-ID: <20100527005200.GB22091@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 10:20:33AM +0200, Arnaud Patard wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> > On Tue, May 25, 2010 at 02:22:39PM +0200, apatard at mandriva.com wrote:

> >> +	/* route microphone */
> >> +	ret = snd_soc_write(codec, CS42L51_ADC_INPUT, 0xF0);
> >> +	if (ret < 0)
> >> +		goto error_alloc;

> > As I said last time this really should be visible to userspace rather
> > than fixed function in the driver.

> It is visible userspace. Look at the DAPM widgets
> cs42l51_adcl_mux_controls/cs42l51_adcr_mux_controls. It's there to set a
> nice default.

As discussed last time you should use the hardware defaults.  This
configuration may not be deisrable on some other boards so best to
assume that the hardware default will at worst be non-harmful.

> >> +#define DAPM_EVENT_PRE_POST_PMD	(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)

> > As I said last time this should be in soc-dapm.h rather than in the
> > driver.

> You told me it was not so important as I'm the only user so I have been
> lazy and didn't sent a patch for that. Of course, if it's really
> important, please say it and I'll be happy to send a patch to
> soc-dapm.h.

It wasn't a reason to reject the driver in and of itself but it is
disappointing to see that it wasn't fixed when the patch was respun.

> >> +	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
> >> +	case SND_SOC_DAIFMT_CBM_CFM:
> >> +		cs42l51->func = MODE_MASTER;
> >> +		break;
> >> +	default:
> >> +	case SND_SOC_DAIFMT_CBS_CFS:
> >> +		cs42l51->func = MODE_SLAVE_AUTO;
> >> +		break;

> > Is the device really capable of automatically coping with mixed master
> > buses automatically,

> hm... seeing such question means it may be yet an other bad naming. The
> _AUTO part is refering to the speed mode of the codec. It's to set the
> AUTO bit of the CS42L51_MIC_POWER_CTL reg and avoid most of the
> clocks configurations.

...

> >  or should the default be to return an error?

> I wanted to make sure things were working even with not supported
> setting but it looks like it was not a good idea otherwise you wouldn't
> ask. Will fix to return an error.

If you accept the value then it looks like the setting is supposed to
work, which it obviously won't do if the device is not able to support
it.  This won't help anyone trying to debug a broken clocking setup.

> >> +	dev_info(&pdev->dev, "CS42L51 ALSA SoC Codec\n");

> > I really would prefer to remove this.

> I'd like to keep it. Being able to tell from logs if the codec driver
> has been loaded or not is really nice for debugging purpose.

ASoC already generates debug logs for you when the driver is registered
with the core, which is the critical bit here.  There's no need to
clutter up the console with non-information like this, it just slows
things down.
