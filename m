From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 4 Feb 2014 11:09:03 -0800
Subject: [PATCH] regulator: core: Make regulator object reflect configured
 voltage
In-Reply-To: <20140204181831.GP22609@sirena.org.uk>
References: <1391493268-3242-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20140204110531.GR22609@sirena.org.uk>
 <CAJAp7OjCnJ=P9Gi20=D9gybREiSaqd1CaQ0K=9fGbCzU1gTFLw@mail.gmail.com>
 <20140204181831.GP22609@sirena.org.uk>
Message-ID: <CAJAp7Ohn3ch2nK_S8j9ieRBzNeyt6OJmumEhRXXykB9RgMJsQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 10:18 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 04, 2014 at 10:02:14AM -0800, Bjorn Andersson wrote:
>> On Tue, Feb 4, 2014 at 3:05 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Why not do this at the time we apply the voltage?  That would seem to be
>> > more robust, doing it in a separate place means that we might update one
>> > bit of code and not the other or might change the execution path so that
>> > one gets run and the other doesn't.
>
>> I do share your concerns about having this logic mirrored here is
>> risky, unfortunately the regulator object is created upon request from
>> a consumer; so it is not available when regulator_register() calls
>> set_machine_constraints().
>
> Oh, hang on - that's what you mean by a regulator object...   I don't
> think this fixes the problem you think it does.  What is the actual
> problem you're trying to fix here?  The min_uV and max_uV on a consumer
> struct are supposed to be the request from that consumer, they should
> only be set if the consumer actually made a request for a voltage range.

I have a regulator that's being configured from DT as:
regulator-min-microvolt = <2950000>;
regulator-max-microvolt = <2950000>;

In the consumer I do regulator_set_voltage(2.95V).

As min == max the voltage is applied by the regulator framework on registration
of the regulator; and the regulator_set_voltage() fails as
REGULATOR_CHANGE_VOLTAGE is not set for this regulator.

This makes sense, until I change regulator-min-microvolt to say 2000000 then
the regulator_set_voltage() succeeds; and the call is required for the device to
function properly.

So in the consumer I get different behavior depending on how the regulator is
configured in DT.


The proposed fix solves this by making the consumer object aware of
the initialized
voltage (as it's fixed in this case), making it okay for calls to
regulator_set_voltage()
given that it's the same value as the configured value; failing for others.

>
>> An alternative is to drop the conditional setting of
>> REGULATOR_CHANGE_VOLTAGE from of_regulator.c and force the regulator
>> drivers to set this flag explicitly; to avoid the difference in
>> behavior depending on configuration.
>
> Why would having each individual driver open code things help?

Without this fix I explicitly need to add REGULATOR_CHANGE_VOLTAGE to the
valid_ops_mask of my regulators, ignoring the fact that
of_get_regulation_constraints()
does apply some logic in this area.

Regards,
Bjorn
