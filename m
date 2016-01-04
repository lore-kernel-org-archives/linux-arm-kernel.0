From: hramrach@gmail.com (Michal Suchanek)
Date: Mon, 4 Jan 2016 22:16:32 +0100
Subject: [linux-sunxi] Re: [PATCH v2 1/3] reset: Add shared
 reset_control_[de]assert variants
In-Reply-To: <1451939999.3884.89.camel@pengutronix.de>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
 <20151214093607.GF19456@lukather> <1450086655.3407.23.camel@pengutronix.de>
 <20151216102934.GR19456@lukather> <1450264908.3421.36.camel@pengutronix.de>
 <20151218110810.GK30359@lukather> <5675378F.5010904@redhat.com>
 <1451939999.3884.89.camel@pengutronix.de>
Message-ID: <CAOMqctR4MTaQXF=SOwR6Tsq4RKc5rjFT=6PHeYjF12=r-TsFGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2016 at 21:39, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Samstag, den 19.12.2015, 11:55 +0100 schrieb Hans de Goede:
>> On 18-12-15 12:08, Maxime Ripard wrote:

>> >      - If the reset line is in a !exclusive use with more than 1 user,
>> >        the refcount is modified and an error is returned to notify that
>> >        it didn't happen.
>>
>> Also ack, except for returning the error, if a driver has used
>> reset_control_get_shared, it should simply be aware that doing an assert
>> might not necessarily actually assert the line, just like doing a clk-disable
>> does not really necessary disable the clock, etc. If a driver is not prepared
>> to deal with this, it should simply not use reset_control_get_shared.
>>
>> I see returning an error if the assert did not happen due to other users /
>> deassert_count != 0 as inconsistent compared to how clks, regulators and phys
>> handle this, these all simply return success in this case.
>
> I wouldn't want drivers to have to differentiate between relevant and
> irrelevant error codes, so in the clock-like refcounting use case
> reset_assert should not return an error if it just correctly decremented
> the refcount. I'd still prefer to have separate API for the counted
> must_deassert/may_assert vs the exclusive must_assert/must_deassert use
> cases, but I just can't think of a good name.
>

Maybe something along the lines of assert_now or assert_sync. It
should be possible to call on shared line and then get an error when
the operation is blocked by other user.

The driver may not really care. Depending on the hardware the line can
be shared on one device and exclusive on another. The driver may just
let the line go when the device is powered off. And it may require a
reset cycle when it detects the device is hosed and return an error
when the reset fails for whatever reason.

Thanks

Michal
