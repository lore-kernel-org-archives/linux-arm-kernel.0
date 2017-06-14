From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 14 Jun 2017 10:53:29 +0200
Subject: [PATCH v15 2/7] power: add power sequence library
In-Reply-To: <20170614015338.GA4635@b29397-desktop>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
 <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
 <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
 <20170614015338.GA4635@b29397-desktop>
Message-ID: <CAPDyKFrLL10TY1JZAhF44_0+qGETLNtFc6ujKVUu7Ay=O8+M5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 June 2017 at 03:53, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Tue, Jun 13, 2017 at 12:24:42PM +0200, Ulf Hansson wrote:
>> [...]
>>
>> > +
>> > +/**
>> > + * of_pwrseq_on - Carry out power sequence on for device node
>> > + *
>> > + * @np: the device node would like to power on
>> > + *
>> > + * Carry out a single device power on.  If multiple devices
>> > + * need to be handled, use of_pwrseq_on_list() instead.
>> > + *
>> > + * Return a pointer to the power sequence instance on success,
>> > + * or an error code otherwise.
>> > + */
>> > +struct pwrseq *of_pwrseq_on(struct device_node *np)
>> > +{
>> > +       struct pwrseq *pwrseq;
>> > +       int ret;
>> > +
>> > +       pwrseq = pwrseq_find_available_instance(np);
>> > +       if (!pwrseq)
>> > +               return ERR_PTR(-ENOENT);
>>
>> In case the pwrseq instance hasn't been registered yet, then there is
>> no way to deal with -EPROBE_DEFER properly here.
>>
>> I haven't been following the discussions in-depth during all
>> iterations, so perhaps you have already discussed why doing it like
>> this.
>
> Yes, it has been discussed. In order to compare with compatible string
> at dts, we need to have one registered pwrseq instance for each
> pwrseq library, this pre-registered one is allocated using
> postcore_initcall, and the new (eg, second) instance is registered
> after pwrseq_get has succeeded.

I understand you need one compatible per pwrseq library, but how does
that have anything to do with -EPROBE_DEFER?

My point is that, if a driver calls of_pwrseq_on() (which calls
pwrseq_find_available_instance()), but the corresponding pwrseq
library and instance has not yet been registered for that device. Then
how will you handle -EPROBE_DEFER? I guess you simply can't, which is
why *all* pwrseq libraries needs to be registered in early boot phase,
like at postcore_initcall(). Right?

If that is the case, I really don't like it.

Moreover, I have found yet another severe problem but reviewing the code:
In the struct pwrseq, you have a "bool used", which you are setting to
"true" once the pwrseq has been hooked up with the device, when a
driver calls of_pwrseq_on(). Setting that variable to true, will also
prevent another driver from using the same instance of the pwrseq for
its device. So, to cope with multiple users, you register a new
instance of the same pwrseq library that got hooked up, once the
->get() callback is about to complete.

The problem the occurs, when there is another driver calling
of_pwrseq_on() in between, meaning that the new instance has not yet
been registered. This will simply fail, won't it?

Sorry for jumping in late, however to me it seems like there is still
some pieces missing to make this work.

[...]

Kind regards
Uffe
