From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Jul 2017 14:46:14 +0200
Subject: [[PATCH]] Revert "leds: handle suspend/resume in heartbeat
 trigger"
In-Reply-To: <20170713120333.GI1363@amd>
References: <1497321560-46817-1-git-send-email-bo.zhang@nxp.com>
 <CACRpkdY6-REXoXjWNUrfCuPn3GYHhV0di7Lhbb=wRhBtPC0+mA@mail.gmail.com>
 <20170713120333.GI1363@amd>
Message-ID: <CACRpkdZuXHRhX4athuf6-=fwMkqpWetVWn85uKB0-k3K9PRdfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 2:03 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2017-06-13 11:35:22, Linus Walleij wrote:
>> On Tue, Jun 13, 2017 at 4:39 AM, Zhang Bo <bo.zhang@nxp.com> wrote:
>>
>> > This reverts commit 5ab92a7cb82c66bf30685583a38a18538e3807db.
>> >
>> > System cannot enter suspend mode because of heartbeat led trigger.
>> > In autosleep_wq, try_to_suspend function will try to enter suspend
>> > mode in specific period. it will get wakeup_count then call pm_notifier
>> > chain callback function and freeze processes.
>> > Heartbeat_pm_notifier is called and it call led_trigger_unregister to
>> > change the trigger of led device to none. It will send uevent message
>> > and the wakeup source count changed. As wakeup_count changed, suspend
>> > will abort.
>> >
>> > Signed-off-by: Zhang Bo <bo.zhang@nxp.com>
>>
>> OK I was stupid, lesson learned.
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> You may still want to submit patch to turn the LED off over suspend
> for your platform...

I think it would make more sense to have the LED subsystem handle
that. Given that it already keeps track of LED_SUSPENDED in a
special flag.

Probably optionally, like LEDs can opt in to be turned off during
suspend.

Yours,
Linus Walleij
