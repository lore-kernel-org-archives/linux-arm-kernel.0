From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Tue, 27 Dec 2011 15:16:08 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: cx20442: add bias control over a
 platform provided regulator
In-Reply-To: <20111226110201.GA8722@opensource.wolfsonmicro.com>
References: <1324681944-19067-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1324681944-19067-3-git-send-email-jkrzyszt@tis.icnet.pl>
 <20111226110201.GA8722@opensource.wolfsonmicro.com>
Message-ID: <201112271516.09114.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 of December 2011 at 12:02:01, Mark Brown wrote:
> On Sat, Dec 24, 2011 at 12:12:22AM +0100, Janusz Krzysztofik wrote:
> 
> > +	case SND_SOC_BIAS_ON:
> > +	case SND_SOC_BIAS_PREPARE:
> > +		if (IS_ERR(cx20442->por.regulator)) {
> > +			err = PTR_ERR(cx20442->por.regulator);
> > +		} else if (!cx20442->por.enabled) {
> > +			err = regulator_enable(cx20442->por.regulator);
> > +			if (!err)
> > +				cx20442->por.enabled = true;
> > +		}
> > +		break;
> > +	case SND_SOC_BIAS_STANDBY:
> > +	case SND_SOC_BIAS_OFF:
> > +		if (IS_ERR(cx20442->por.regulator)) {
> > +			err = PTR_ERR(cx20442->por.regulator);
> > +		} else if (cx20442->por.enabled) {
> > +			err = regulator_disable(cx20442->por.regulator);
> > +			if (!err)
> > +				cx20442->por.enabled = false;
> > +		}
> > +	}
> > +	mutex_unlock(&cx20442->por.lock);
> 
> You can avoid the mutex and simplify the code by relying on the fact
> that the only possible transitions are:
> 
>    OFF <-> STANDBY <-> PREPARE <-> ON
> 
> which would look a lot more natural - you shouldn't need to remember if
> the regulator is enabled, you should just turn it on in the STANDBY to
> PREPARE transition and turn it off in the ON to PREPARE or PREPARE to
> STANDBY transitions.

Can I assume STANDBY or OFF at the time the codec .remove method is 
called? If not, is there a helper function available which can be called 
in order to perform all those ON -> PREPARE -> STANDBY [-> OFF] transitions before calling regulator_put()?

Thanks,
Janusz
