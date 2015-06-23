From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 23 Jun 2015 13:33:09 +0530
Subject: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
In-Reply-To: <20150623071647.GD3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <20150623025031.GD16776@linux> <20150623071647.GD3245@x1>
Message-ID: <20150623080309.GI16776@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23-06-15, 08:16, Lee Jones wrote:
> Thanks for your timely review Viresh.

Your welcome Lee :)

> On Tue, 23 Jun 2015, Viresh Kumar wrote:
> > On 22-06-15, 16:43, Lee Jones wrote:
> > > +config ARM_ST_CPUFREQ
> > > +	bool "ST CPUFreq support"
> > 
> > Isn't using ST just too generic? There are multiple SoCs ST has been
> > involved with, I have worked on a completely different series.
> > Probably a more relative string is required here, like stih407 ?
> 
> This is ST's only CPUFreq implementation and is pretty board
> agnostic.  This particular driver only currently supports the STiH407
> family, but internally it supports some others too.  I'll have a chat
> and see if we can make it more specific somehow.

So, SPEAr is also from ST. And it already have a driver for itself.

> > > +	if (!ddata->dvfs_tab_count) {
> > > +		dev_err(&pdev->dev, "No suitable AVS table found\n");
> > 
> > Why is this an error? I thought in this case you will go ahead with
> > the normal OPP-table.
> 
> I've written it so it's an error within this function, as it makes the
> function fail, but is downgraded by the caller to a warning and
> gracefully bypassed to still allow frequency scaling.

Not that, I was asking about the print. I thought we will still try to
find OPP from the CPU node and a warning or a error might not be the
right choice. You can surely add a debug print. Currently you are
doing a dev_err() here, followed by a dev_warn() I think..

> > So you have added new OPPs here, but cpufreq-dt will try to add old
> > OPPs. You must be getting lots of warnings ?
> 
> Yes, we recieve the 'duplicate OPPs detected' warning, but there is
> nothing we can do about that.

:)

OPP-v2 will get that solved too..

> > > +	if (ddata->substrate < 0)
> > > +		goto set_default;
> > 
> > Maybe:
> > 
> > 	if (ddata->substrate >= 0)
> >                 return;
> 
> 0 is a valid substrate value.

I had >= in the comparison. Wasn't that right?
And I was just suggesting that a single return can be used instead of

if (xyz)
        goto set_default;
return;

-- 
viresh
