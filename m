From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 31 May 2012 08:08:51 +0530
Subject: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
In-Reply-To: <87mx4p5niq.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-5-git-send-email-t-kristo@ti.com> <87d363928g.fsf@ti.com>
 <CAMQu2gw5myvyvM8x225KnN59vEYBYLBiEsvML8RAoE0t+RrbYA@mail.gmail.com>
 <CAMQu2gywor2o+g8Fn80ogbTtEZPSXM74M65GsO2zH44tg-W7gQ@mail.gmail.com>
 <CAOMWX4ctJcfGNxXK4hT+QH-m7zUfP1N3H56oVDVzPFmhVTFOMw@mail.gmail.com>
 <87wr3t8s81.fsf@ti.com>
 <CAOMWX4ewVauzYW9pJq07=moLcgkBLyvx68o7T8975cGvshfK3Q@mail.gmail.com>
 <87mx4p5niq.fsf@ti.com>
Message-ID: <CAMQu2gyD7W0whj=0jBhpo91EyduXPDGOH396kxEc+K5OUepyPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 3:39 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>> On Wed, May 30, 2012 at 12:59 PM, Kevin Hilman <khilman@ti.com> wrote:
>>> "Menon, Nishanth" <nm@ti.com> writes:
>>>
>>>> On Thu, May 17, 2012 at 3:52 AM, Shilimkar, Santosh
>>>> <santosh.shilimkar@ti.com> wrote:
>>>>> On Thu, May 17, 2012 at 12:34 PM, Shilimkar, Santosh
>>>>> <santosh.shilimkar@ti.com> wrote:
>>>>>> On Thu, May 17, 2012 at 4:12 AM, Kevin Hilman <khilman@ti.com> wrote:
>>>>>>> Tero Kristo <t-kristo@ti.com> writes:
>>>>>>>
>>>> [...]
>>>>>>> - Rather than hooking into omap4_enter_lowpower(), should use
>>>>>>> ?the cluster PM enter/exit notifier chain.
>>>>>>>
>>>>>> This is again specific to device OFF only and not related to CPU
>>>>>> cluster state as such. So I don't think notifiers should be used here.
>>>>>>
>>>>>> O.w even when we attempt just MPU OSWR C-state, all these functions will
>>>>>> get called in notifier chain.
>>>>>>
>>>>> Just a thought, we can have a separate notifier chain for device OFF. It can
>>>>> allow use to get rid of 'enable_off_mode" kind of flags and can be
>>>>> used by many drivers too.
>>>>
>>>> Like the overall idea, but one minor dumb concern might be sequencing
>>>> of notifiers
>>>> ?- OFF entry and restore needs things to be executed in a specific sequence.
>>>> How do we plan to ensure the sequence is maintained in a notifier call
>>>> chain? one
>>>> possible option might be a "priority" based scheme?
>>>
>>> Or just combine the events that need a specific sequence into single
>>> notifier callback function.
>> There is other issues in case of failure cases -> abort of OFF
>> sequence due to pending interrupt
>> detected as part of a notifier - error handling needs to be sane in
>> proper sequence.
>> I understand and appreciate the intent of replacing the single mega
>> enter_sleep with a chain of notifiers
>> but any such option will need to be scalable enough to handle weird
>> erratum handling (HSI CAWAKE as an example)
>> which potentially break the logic flow and be either be equal or
>> better than what we have today interms of
>> error handling. since these notifiers will be triggered for
>> CPUIDLE(performance sensitive) and suspend, the intricacies
>> might be better understood by seeing how this proposed notifiers look like.
>
> Makes sense. ?Thanks for clarifying.
>
> What $SUBJECT series proposed was indeed a "mega function", but one that
> was just a list of function calls with no error checking or recovery,
> and no documentation/description about dependencies/sequencing etc. etc.
> Based on the patches at hadn (which is all reviewers have to go on),
> notifiers seemed to be a good fit.
>
> If there are good reasons that all of the device-off events need to be
> coordinated/synchronized/sequenced (and it sounds like there are, thanks
> for pointing them out), I am not opposed to that approach. ?It simply
> needs to be well described in the changlog.
>
There are sequence dependencies but lot of code can be extracted and put
into smaller blocks that is independent.

I agree for the error handling part notifier chain could be an issue.

Regards
Santosh
