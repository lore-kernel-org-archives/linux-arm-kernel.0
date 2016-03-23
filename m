From: carlo@endlessm.com (Carlo Caione)
Date: Wed, 23 Mar 2016 17:04:19 +0100
Subject: [PATCH v3 2/2] documentation: Fix pinctrl documentation for
 Meson8 / Meson8b
In-Reply-To: <20160323152052.GA20906@rob-hp-laptop>
References: <1458724440-32228-1-git-send-email-carlo@caione.org>
 <1458724440-32228-3-git-send-email-carlo@caione.org>
 <20160323152052.GA20906@rob-hp-laptop>
Message-ID: <CAL9uMOGaf5556KX5RJWbaW0d1zcTZu4S6FvoqEXQCWXg1QUDpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 4:20 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 23, 2016 at 10:14:00AM +0100, Carlo Caione wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Fix pin controller documentation introducing the new compatibles for
>> the pinctrl drivers specific for aobus / cbus.
>>
>> This is needed because we have changed the pin controller driver: we
>> have now a single specialized pinctrl driver / compatible for each bus
>> the controller is attached to, instead of one single driver dealing with
>> all the controllers we have on different buses.
>
> Aren't you breaking compatibility with old DTs here? If so, you need to
> be clear that you are and why you think that is okay.

Rob,
It's a bit too late to worry about breaking compatibility since the
driver changes are already landed in mainline and currently Meson8 and
Meson8b platforms are broken because of this.
You can read the whole discussion here [1] and here [2]. Driver and DT
changes were supposed to go in together but a bit of general
misunderstanding caused this issue.

We decided to break compatibility with the old DTs since the the
platform support is still in the really early stage so I really don't
think this is going to cause any problem and we have a lot of good
reasons to split the pinctrl driver. First of all it makes sense from
the hardware prospective, since we actually have two different pin
controllers on two different buses. Splitting the driver allows us to
introduce in the DTS both CBUS and AOBUS as simple buses. We need a
clear description of the two buses in the DTS since several devices
have a different register mapping depending on which bus they are
attached to. Also as you can read here [3] we want to map the whole
CBUS as a syscon device to be able to access several registers
scattered inside CBUS.

As Andreas pointed out gxbb arch already models CBUS and AOBUS as
simple-buses so we could reuse this driver also for that architecture.

Thanks,

[1] http://www.spinics.net/lists/arm-kernel/msg489730.html
[2] http://www.spinics.net/lists/devicetree/msg116771.html
[3] http://www.spinics.net/lists/devicetree/msg115019.html

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
