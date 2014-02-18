From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 18 Feb 2014 12:56:23 -0600
Subject: [PATCH v5 1/6] spmi: Linux driver framework for SPMI
In-Reply-To: <20140215234748.GA26494@saruman.home>
References: <1391468739-20987-1-git-send-email-joshc@codeaurora.org>
 <1391468739-20987-2-git-send-email-joshc@codeaurora.org>
 <20140215234748.GA26494@saruman.home>
Message-ID: <20140218185623.GF31116@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 05:47:48PM -0600, Felipe Balbi wrote:
> On Mon, Feb 03, 2014 at 05:05:33PM -0600, Josh Cartwright wrote:
> > +#ifdef CONFIG_PM_RUNTIME
> > +static int spmi_runtime_suspend(struct device *dev)
> > +{
> > +	struct spmi_device *sdev = to_spmi_device(dev);
> > +	int err;
> > +
> > +	err = pm_generic_runtime_suspend(dev);
> > +	if (err)
> > +		return err;
> > +
> > +	return spmi_command_sleep(sdev);
> 
> shouldn't this too calls be swapped ? I mean, some pm_runtime
> implementations could be gating clocks at the driver's
> ->runtime_suspend() callback.

Perhaps.  I had added the explicit SLEEP/WAKEUP commands to
suspend()/resume(), but now I'm thinking issuing these commands should
not be the responsibility of the core, since the semantics of the
SLEEP/ACTIVE state aren't well defined in general (each
implementation/slave defines what, if anything, these states mean).

Fortunately, there are no users yet, so this is a painless change. :)

Thanks for taking a look.

  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
