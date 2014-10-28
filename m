From: johan@kernel.org (Johan Hovold)
Date: Tue, 28 Oct 2014 09:36:33 +0100
Subject: [PATCH v3] rtc: omap: add support for pmic_power_en
In-Reply-To: <20141027154031.4492ea11d401045ca04a3ff8@linux-foundation.org>
References: <1413913086-12730-1-git-send-email-johan@kernel.org>
 <1414397368-26480-1-git-send-email-johan@kernel.org>
 <20141027154031.4492ea11d401045ca04a3ff8@linux-foundation.org>
Message-ID: <20141028083633.GM2006@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 03:40:31PM -0700, Andrew Morton wrote:
> On Mon, 27 Oct 2014 09:09:28 +0100 Johan Hovold <johan@kernel.org> wrote:
> 
> > Add new property "ti,system-power-controller" to register the RTC as a
> > power-off handler.
> > 
> > Some RTC IP revisions can control an external PMIC via the pmic_power_en
> > pin, which can be configured to transition to OFF on ALARM2 events and
> > back to ON on subsequent ALARM (wakealarm) events.
> > 
> > This is based on earlier work by Colin Foe-Parker and AnilKumar Ch. [1]
> > 
> > [1] https://www.mail-archive.com/linux-omap at vger.kernel.org/msg82127.html
> > 
> > Tested-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> > 
> > Changes since v2:
> >  - add two-second delay to allow alarm to trigger before returning
> 
> hmpf.  As this sentence is below the ^--- it doesn't get into the
> changelog.

We usually don't keep the patch-revision change log in the commit message
(e.g. put in the cover letter).

But in general, how do you want to handle updates to a single patch in a
series you already have in your tree? Do you prefer a proper
incremental-fix patch (with commit message), just an updated single
patch, or a resend of the whole series?

> > ...
> >
> > +static void omap_rtc_power_off(void)
> > +{
> > +	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
> > +	struct rtc_time tm;
> > +	unsigned long now;
> > +	u32 val;
> > +
> > +	/* enable pmic_power_en control */
> > +	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
> > +	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
> > +
> > +	/* set alarm two seconds from now */
> > +	omap_rtc_read_time_raw(rtc, &tm);
> > +	bcd2tm(&tm);
> > +	rtc_tm_to_time(&tm, &now);
> > +	rtc_time_to_tm(now + 2, &tm);
> > +
> > +	if (tm2bcd(&tm) < 0) {
> > +		dev_err(&rtc->rtc->dev, "power off failed\n");
> > +		return;
> > +	}
> > +
> > +	rtc_wait_not_busy(rtc);
> > +
> > +	rtc_write(rtc, OMAP_RTC_ALARM2_SECONDS_REG, tm.tm_sec);
> > +	rtc_write(rtc, OMAP_RTC_ALARM2_MINUTES_REG, tm.tm_min);
> > +	rtc_write(rtc, OMAP_RTC_ALARM2_HOURS_REG, tm.tm_hour);
> > +	rtc_write(rtc, OMAP_RTC_ALARM2_DAYS_REG, tm.tm_mday);
> > +	rtc_write(rtc, OMAP_RTC_ALARM2_MONTHS_REG, tm.tm_mon);
> > +	rtc_write(rtc, OMAP_RTC_ALARM2_YEARS_REG, tm.tm_year);
> > +
> > +	/*
> > +	 * enable ALARM2 interrupt
> > +	 *
> > +	 * NOTE: this fails on AM3352 if rtc_write (writeb) is used
> > +	 */
> > +	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> > +	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
> > +			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> > +
> > +	mdelay(2000);
> 
> And it is uncommented.
> 
> How on earth is a reader to know why this is here?

The comment above the function reads:

 * The RTC can be used to control an external PMIC via the pmic_power_en pin,
 * which can be configured to transition to OFF on ALARM2 events.
 *
 * Notes:
 * The two-second alarm offset is the shortest offset possible as the alarm
 * registers must be set before the next timer update and the offset
 * calculation is too heavy for everything to be done within a single access
 * period (~15us).

So it's effect is at least fairly obvious and documented.

> I can do this
> 
> --- a/drivers/rtc/rtc-omap.c~rtc-omap-add-support-for-pmic_power_en-v3-fix
> +++ a/drivers/rtc/rtc-omap.c
> @@ -417,6 +417,7 @@ static void omap_rtc_power_off(void)
>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
>  
> +	/* Allow alarm to trigger before returning */
>  	mdelay(2000);
>  }

Looks good, and I should have put something like that there nonetheless.

> But it doesn't explain *why* we want the alarm to trigger before
> returning.

Should we really require every power-off handler to document arch
behaviour (even if its inconsistent and currently undocumented); in
this case that some arches return to user-space where we may oops if
called from process 0 (e.g. systemd, but not if using sysvinit)?

Johan
