From: nm@ti.com (Menon, Nishanth)
Date: Thu, 23 Feb 2012 09:05:44 -0600
Subject: [PATCHv5 03/14] arm: omap3+: voltage: parameter segregation
In-Reply-To: <1329988133.4102.500.camel@sokoban>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
 <1329833098-19900-4-git-send-email-t-kristo@ti.com>
 <CAOMWX4d+M9oagDtmSqG=X8Ln4kUEyLaqpfB9Pz0Y+6RmK=sjYw@mail.gmail.com>
 <1329988133.4102.500.camel@sokoban>
Message-ID: <CAOMWX4dR++A4qQKNkdh=k37XGtz8GZ8VGGRO0R8_Ca8-2vmTHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 03:08, Tero Kristo <t-kristo@ti.com> wrote:
> On Wed, 2012-02-22 at 19:37 -0600, Menon, Nishanth wrote:
>> On Tue, Feb 21, 2012 at 08:04, Tero Kristo <t-kristo@ti.com> wrote:
>> [...]
>> > diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
>> > index 949938d..940a0d6 100644
>> > --- a/arch/arm/mach-omap2/voltage.h
>> > +++ b/arch/arm/mach-omap2/voltage.h
>>
>> [...]
>> > @@ -171,6 +169,18 @@ struct omap_voltdm_pmic {
>> > ? ? ? ?u8 (*uv_to_vsel) (unsigned long uV);
>> > ?};
>> >
>> > +struct omap_vp_param {
>> > + ? ? ? u32 vddmax;
>> > + ? ? ? u32 vddmin;
>> > +};
>> > +
>>
>> Thinking a little deeper about this(SoC level vdd min and max) on a
>> slightly different angle- core of the question that intend to answer
>> are:
>> ?- what is the least voltage we want to allow in active transtion? it
>> should not be lower than retention voltage.
>
> I think this is a fair assumption, so we could init the vddmin to be the
> same as the retention voltage for the domain (or even drop the
> parameter.)
>
>> - what is the max voltage we want to allow in active transition? it
>> should be the max Nom voltage of all the OPPs for that domain.
>
> Isn't it higher? I guess smartreflex can scale voltages even up from the
> nominal level if we have a really old and/or bad silicon. Limiting this
> to max opp would be bad, no? Maybe we could use max opp voltage + some
> margin though... but what would be a safe margin here?
Vnom voltage definition tends to be a variant - yep. at least OMAP3,4 have
intended to have Vnom as the max voltage for the worst corner lot sample
at end of life - aka worst possible voltage for that OPP. But with newer process
technologies of the future SoCs, this definition might turn out to become the
start voltage.

OK, it is safer to have vnom max at max SoC supported voltage i guess to prevent
code churn in the future and maintain compatibility with current SoCs.


Regards,
Nishanth Menon
