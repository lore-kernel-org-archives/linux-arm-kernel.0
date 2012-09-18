From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Sep 2012 16:44:16 +0100
Subject: [PATCH v2 04/13] regulators: Versatile Express regulator driver
In-Reply-To: <20120918150212.GA12543@opensource.wolfsonmicro.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
 <20120918150212.GA12543@opensource.wolfsonmicro.com>
Message-ID: <1347983056.11116.11.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-18 at 16:02 +0100, Mark Brown wrote:
> On Tue, Sep 18, 2012 at 03:17:46PM +0100, Pawel Moll wrote:
> > Implementation of the regulator framework driver for the
> > Versatile Express voltage control. Devices without
> > voltage constraints (ie. "regulator-[min|max]-microvolt"
> > properties in the DT node) are treated as fixed (or rather
> > read-only) regulators.
> 
> This doesn't seem great...  it doesn't seem to know or represent
> anything at all about the hardware, I'd expect a voltage regulator to at
> a minimum be able to implement list_voltage().  You've not provided any
> information on what the hardware actually is and the driver just seems
> to proxy through to some other API which actually implements the
> regulator support.

Well, that's what it really is. The config API sends a request "set xyz
uV" to the microcontrollers. And the micro can (at least in theory) get
you any voltage within the min/max limits by whatever means it has (at
least some of the daugtherboards use micro's DAC to adjust reference
voltage for a DC/DC converter with a feedback loop using ADC).

But fair enough, I should have done better work in describing this.

> > +	init_data->constraints.apply_uV = 0;
> 
> This seems broken, why are you interfering with the supplied
> constraints?

Hm. It's been about a month since I wrote that, so the best I can tell
now is "because fixed.c does the same" (and that's what I was looking
at)... Anyway, looked at the code again and tried everything without
that line and indeed I see no reason to do that, so consider it gone.

v3 to follow.

Cheers!

Pawel
