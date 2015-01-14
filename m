From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 12:56:24 +0100
Subject: [PATCH v2 06/16] ASoC: samsung: i2s: Move clk enable to the
 platform driver probe()
In-Reply-To: <20150106180619.GN2634@sirena.org.uk>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
 <1418997336-17777-7-git-send-email-s.nawrocki@samsung.com>
 <20150106180619.GN2634@sirena.org.uk>
Message-ID: <54B65968.8040404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/15 19:06, Mark Brown wrote:
> On Fri, Dec 19, 2014 at 02:55:26PM +0100, Sylwester Nawrocki wrote:
>> Gating the I2S bus clock in the driver's runtime PM callbacks has
>> currently really no effect since the clock is being enabled
>> in the DAI's probe() and thus is permanently turned on. Now we just
>> move the enable to the platform driver's probe(), which doesn't
>> change the situation much. It will allow us to register a clock
>> provider already in samsung_i2s_probe() function.
> 
> That doesn't sound quite right - the normal idiom for this stuff is to
> enable on probe, mark the device as active then if runtime PM is enabled
> it can idle the device and turn off the clock.  That way if runtime PM
> is disabled things continue to run.  I've not checked to see if this is
> actually happening correctly all the way through but that's what's
> supposed to happen and means that enabling in the probe should still
> result in working clock management.
> 
> It will as things currently stand be broken for the dual DAI case so
> this is a fix for that (the dual DAI case will double enable if both
> links are in use) but the analysis isn't quite correct.

I agree that the device should be additionally marked as active, however
things will stop working unless we also do other changes to ensure
the BUSCLK is enabled when required.

AFAIU the clock will not be double enabled when both links are used,
since the clk_get/clk_prepare_enable part in DAI probe() is done only
for the primary DAI. I actually checked it with single and both links
and the clk_enable_count is always 1 after system initialization:

# grep . /sys/kernel/debug/clk/*i2s*/clk_enable_count

/sys/kernel/debug/clk/dout_i2s/clk_enable_count:0
/sys/kernel/debug/clk/i2s0/clk_enable_count:0
/sys/kernel/debug/clk/i2s1/clk_enable_count:0
/sys/kernel/debug/clk/i2s2/clk_enable_count:0
/sys/kernel/debug/clk/i2s_bus/clk_enable_count:1
/sys/kernel/debug/clk/mout_i2s/clk_enable_count:0
/sys/kernel/debug/clk/sclk_i2s/clk_enable_count:0
/sys/kernel/debug/clk/sclk_i2s1/clk_enable_count:0
/sys/kernel/debug/clk/sclk_i2s2/clk_enable_count:0

I'm going to rephrase the changelog to something like:

"The clk_prepare_enable() call on the "iis" clock is moved to happen
 earlier in the DAI platform device driver's probe() callback, so the
 I2S registers can be safely accessed through the clk API, after the clk
 supplier is registered in the platform device probe().

 After this patch the "iis" clock is kept enabled since the (primary)
 I2S platform device probe() and until the platform device driver remove()
 call.  This is similar to gating the clock in the snd_soc_dai probe() and
 remove() callbacks.
 Normally, in addition to that we should mark the device as PM runtime
 active, so if runtime PM is enabled it can idle the device by turning off
 the clock.  Correcting this issue is left for a separate patch series,
 as we need to ensure the BUSCLK clock is always enabled when required."
