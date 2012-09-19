From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Sep 2012 12:34:31 +0200
Subject: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT
 property for broken voltage quirk
In-Reply-To: <m3a9wmgvip.fsf@pullcord.laptop.org>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1587150.uFGRdL0s8e@amdc1227> <m3a9wmgvip.fsf@pullcord.laptop.org>
Message-ID: <1907099.4JSZthrgh2@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Wednesday 19 of September 2012 06:24:46 Chris Ball wrote:
> Hi Tomasz,
> 
> On Wed, Sep 19 2012, Tomasz Figa wrote:
> > Hi Chris,
> > 
> > On Wednesday 19 of September 2012 01:42:01 Chris Ball wrote:
> >> On Tue, Sep 04 2012, Tomasz Figa wrote:
> >> > Some boards use fixed voltage regulator for vmmc supply (e.g. for
> >> > eMMC
> >> > memories). MMC_CAP2_BROKEN_VOLTAGE must be enabled for them to
> >> > operate
> >> > correctly.
> >> 
> >> Is there a reason we can't make this a property on the regulator
> >> instead?> 
> > Is there a reason we can't make this a property of the mmc subsystem?
> > ;)
> > 
> > Now, seriously, could you elaborate on this a bit more? Do you mean
> > that a regulator should provide a dummy set voltage operation that
> > would accept any voltage?
> 
> Sorry for the terseness.
> 
> It seems like we're encoding exactly the same information twice in two
> different subsystems -- I don't see the point, so I'd like to think
> about how we could do better.
> 
> For example, if we're only concerned about fixed regulators, could we
> just detect a fixed regulator in the driver and avoid the failing call
> to regulator_set_voltage() directly, without needing to go via this
> capability?  Seems like the capability doesn't tell us anything we
> couldn't already have known.

We could just check if the regulator provides the capability to change the 
voltage.

I don't see any direct way of querying the regulator for provided 
capabilities (correct me if I'm just blind), but calling 
regulator_count_voltages() on the regulator and checking if the returned 
value is 1 should be enough to assume that the regulator is fixed.

What do you think?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
