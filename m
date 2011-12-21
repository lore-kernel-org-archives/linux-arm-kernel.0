From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Dec 2011 01:32:21 +0000
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <20111221012046.GE15863@b20223-02.ap.freescale.net>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <1324264903-15395-5-git-send-email-richard.zhao@linaro.org>
 <20111220145904.GD29727@sirena.org.uk>
 <20111220232701.GA1698@richard-laptop>
 <20111220234844.GC6551@opensource.wolfsonmicro.com>
 <20111221012046.GE15863@b20223-02.ap.freescale.net>
Message-ID: <20111221013220.GA15398@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 09:20:46AM +0800, Richard Zhao wrote:
> On Tue, Dec 20, 2011 at 11:48:45PM +0000, Mark Brown wrote:

> > Note also that not all hardware specifies things in terms of a fixed set
> > of operating points, sometimes only the minimum voltage specification is
> > varied with frequency or sometimes you see maximum and minimum stepping
> > independently.

> cpus that don't use freq table is out of scope of this driver.

That's not the point - the point is that you may do something like
specify a defined set of frequencies and just drop the minimum supported
voltage without altering the maximum supported voltage as the frequency
gets lower.

> > Further note that if all hardware really does have as tight a set of
> > requirements as you suggest then the regulator support in the driver
> > needs to be non-optional otherwise a board without software regulator
> > control might drop the frequency without also dropping the voltage.

> It's ok to only adjuct freq without changes voltage. You can find many
> arm soc cpufreq drivers don't change voltage.
> If dts specify voltage but don't have such regulator. I'll assume it
> always runs on the initial volatage (highest for most cases).

My point exactly; such devices are examples of the policy outlined above
where only the minimum voltage changes with frequency and the maximum
voltage is constant.  The cpufreq driver would lower the supported
voltage when possible but wouldn't actually care if the voltage changes.

> > > >  - Frequencies that can't be supported due to limitations of the
> > > >    available supplies shouldn't be exposed to users.

> > > As I said, only proved operation points are allowed.

> > This statement appears to be unrelated to the comment you're replying
> > to.

> I meant the exact voltage can always successfull set. Anyway, I'll add

This is just not the case.  Regulators don't offer a continuous range of
voltages, they offer steps of varying sizes which may miss setting some
voltages, and board designers may choose not to support some of the
voltage range.

> regulator_set_voltage return value checking.

While this is important the driver should also be enumerating the
supported voltages at probe time and eliminating unsupportable settings
so that governors aren't constantly trying to set things that can never
be supported.  The s3c64xx cpufreq driver provides an implementation of
this.

> Maybe I can remove it. But I'd probably add freq table dump. It's more important.
> Agree?

That seems like something the core should be doing if
