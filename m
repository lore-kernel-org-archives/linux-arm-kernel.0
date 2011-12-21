From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 21 Dec 2011 09:20:46 +0800
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <20111220234844.GC6551@opensource.wolfsonmicro.com>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <1324264903-15395-5-git-send-email-richard.zhao@linaro.org>
 <20111220145904.GD29727@sirena.org.uk>
 <20111220232701.GA1698@richard-laptop>
 <20111220234844.GC6551@opensource.wolfsonmicro.com>
Message-ID: <20111221012046.GE15863@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Dec 20, 2011 at 11:48:45PM +0000, Mark Brown wrote:
> On Wed, Dec 21, 2011 at 07:27:03AM +0800, Richard Zhao wrote:
> > On Tue, Dec 20, 2011 at 02:59:04PM +0000, Mark Brown wrote:
> 
> > > My comments on the previous version of the patch still apply:
> 
> > >  - The voltage ranges being set need to be specified as ranges.
> 
> > cpu normally need strict voltages. and only proved operating opints
> > are allowed to set in dts. If the voltage changes slightly especially
> > for high frequency, it's easy to cause unstable.
> 
> Clearly there will be limits which get more and more restrictive as the
> frequencies get higher but there will always be at least some play in
> the numbers as one must at a minimum specify tolerance ranges, and at
> lower frequencies the ranges specified will typically get compartively
> large.
hmm, reasonable. I'll add it in dts. Thanks.
> 
> Note also that not all hardware specifies things in terms of a fixed set
> of operating points, sometimes only the minimum voltage specification is
> varied with frequency or sometimes you see maximum and minimum stepping
> independently.
cpus that don't use freq table is out of scope of this driver.
> 
> Further note that if all hardware really does have as tight a set of
> requirements as you suggest then the regulator support in the driver
> needs to be non-optional otherwise a board without software regulator
> control might drop the frequency without also dropping the voltage.
It's ok to only adjuct freq without changes voltage. You can find many
arm soc cpufreq drivers don't change voltage.
If dts specify voltage but don't have such regulator. I'll assume it
always runs on the initial volatage (highest for most cases).
> 
> > >  - Frequencies that can't be supported due to limitations of the
> > >    available supplies shouldn't be exposed to users.
> 
> > As I said, only proved operation points are allowed.
> 
> This statement appears to be unrelated to the comment you're replying
> to.
I meant the exact voltage can always successfull set. Anyway, I'll add
regulator_set_voltage return value checking.
> 
> > > You also need to define how the core supplies get looked up.
> 
> > It's pure software. platform uses this driver have to define "cpu" consumer.
> 
> You still need to define this in the binding.
You mean regulator DT binding? already in ? I'll check it.
> 
> > > > +	pr_info("Generic CPU frequency driver\n");
> 
> > > This seems noisy...
> 
> > Why? Do you think only errors and warnings can print out?
> 
> Yes.

Maybe I can remove it. But I'd probably add freq table dump. It's more important.
Agree?

I checked pr_fmt. Thanks very much. I'll use below and remove __func_.
#define pr_fmt(fmt)             KBUILD_MODNAME ": " fmt


Thanks
Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
