From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 4 Feb 2014 10:02:14 -0800
Subject: [PATCH] regulator: core: Make regulator object reflect configured
 voltage
In-Reply-To: <20140204110531.GR22609@sirena.org.uk>
References: <1391493268-3242-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20140204110531.GR22609@sirena.org.uk>
Message-ID: <CAJAp7OjCnJ=P9Gi20=D9gybREiSaqd1CaQ0K=9fGbCzU1gTFLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 3:05 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 03, 2014 at 09:54:28PM -0800, Bjorn Andersson wrote:
>
>> +     /*
>> +      * Make the regulator reflect the configured voltage selected in
>> +      * machine_constraints_voltage()
>> +      */
>> +     if (rdev->constraints->apply_uV &&
>> +         rdev->constraints->min_uV == rdev->constraints->max_uV) {
>> +             regulator->min_uV = rdev->constraints->min_uV;
>> +             regulator->max_uV = rdev->constraints->min_uV;
>> +     }
>> +
>
> Why not do this at the time we apply the voltage?  That would seem to be
> more robust, doing it in a separate place means that we might update one
> bit of code and not the other or might change the execution path so that
> one gets run and the other doesn't.

I do share your concerns about having this logic mirrored here is
risky, unfortunately the regulator object is created upon request from
a consumer; so it is not available when regulator_register() calls
set_machine_constraints().

An alternative is to drop the conditional setting of
REGULATOR_CHANGE_VOLTAGE from of_regulator.c and force the regulator
drivers to set this flag explicitly; to avoid the difference in
behavior depending on configuration.

Regards,
Bjorn
