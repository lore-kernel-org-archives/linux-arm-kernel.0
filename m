From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 21:55:32 +0200
Subject: [PATCH 1/2] i2c: s3c2410: add optional pin configuration using
 pinctrl interface
In-Reply-To: <1390693.DWkgTZ1iNF@amdc1227>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
 <2444562.GB3nOHUb9M@amdc1227>
 <CAJuYYwQCQDTnpPR5WABtbozZOgc6_SZRBv3b6D8KY78tzMt-Eg@mail.gmail.com>
 <1390693.DWkgTZ1iNF@amdc1227>
Message-ID: <CACRpkda+mu4P=-8UX1ad_UgCvJZ-2eYaO9vx27Ux20SYGYdKgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 2:28 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Thanks for your comments.
>
> On Thursday 06 of September 2012 16:36:08 Thomas Abraham wrote:
>> > This patch shows the problem of the need to explicitly migrate all
>> > drivers to pinctrl.
>> >
>> > Maybe we should consider extending the pinctrl subsystem to set the
>> > default state automatically before binding a driver to a device, at
>> > least in case of DT-based platforms?
>>
>> The pinctrl driver allows for activating default pin configuration
>> when the pinctrl driver loads. This is referred to as "hogging".
>
> What I suggested is that such default configuration would be applied just
> before binding a driver, i.e. when it's almost sure that the device will be
> actually used and the configuration will be needed.

In that case the pinctrl driver can poke down a default
register configuration, but just like Stephen remarks I do not see
the point either.

Hogs should work just fine?

> Of course such functionality would not have to be obligatory. For example,
> we could add new property, like pinctrl-set-default, to point in device
> tree that this device should have its pinctrl state set up automatically.

This doesn't have a semantic difference to a default hog AFAICT.

>> 1. After a suspend and resume cycle, the pin configuration registers
>> may be reset to default values. Hence, during resume, the pin
>> configuration has be redone.
>
> In my opinion it should be saved and restored by pinctrl driver (as it was
> done in case of GPIO subsystem previously).

This is one way to do it. I see Stephen has the same idea.

Another way is actually to go to the default state from the
default state. Or from any state to itself rather.

Currently pinctrl_select_state_locked() contains this:

        if (p->state == state)
                return 0;

If we just add pinctrl_select_state_force() excluding that
clause we can force re-poking of the state at any time.

Compare regulator_force_disable() and similar.

Maybe this is actually more helpful?

Yours,
Linus Walleij
