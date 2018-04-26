From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Apr 2018 11:12:21 +0200
Subject: [PATCH v2] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <2820412.JxDUeWI2ec@debian64>
References: <20180402121005.10080-1-chunkeey@gmail.com>
 <20180402150447.GH510@tuxbook-pro> <2820412.JxDUeWI2ec@debian64>
Message-ID: <CACRpkda6nD_nb7D1s7KHX3CxzmAw3qzdEe6m+V+TbaZ5gaZhaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I see I might have missed this mail, sorry for that.

On Thu, Apr 5, 2018 at 6:35 PM, Christian Lamparter <chunkeey@gmail.com> wrote:
> On Montag, 2. April 2018 17:04:47 CEST Bjorn Andersson wrote:
>> On Mon 02 Apr 05:10 PDT 2018, Christian Lamparter wrote:
>> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> > index 495432f3341b..258fa357d946 100644
>> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> > @@ -831,11 +831,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>> >             return ret;
>> >     }
>> >
>> > -   ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
>> > -   if (ret) {
>> > -           dev_err(pctrl->dev, "Failed to add pin range\n");
>> > -           gpiochip_remove(&pctrl->chip);
>> > -           return ret;
>> > +   if (!is_of_node(pctrl->dev->fwnode)) {
>>
>> Afaict this still means that if I boot this kernel with yesterday's dtb
>> (without gpio-ranges) I will not get any gpios. This isn't okay.
> Ok, fair point. I drop this chunk.
>
>> @Linus, I count 24 callers of gpiochip_add_pin_range(). Is this
>> suggestion reasonable?
>>
>> Can we make gpiochip_add_pin_range() check if there's already a
>> gpio-range and return ok in some way?

I think I replied in some other mail that I think we need to
be backwards compatible and it's not too hard to do
both. (Correct me if I'm wrong.)

> Looks like Linus is currently really busy updating the gemini
> target (a lot of work went into it) for OpenWrt.
> <https://lists.openwrt.org/pipermail/openwrt-devel/2018-April/043752.html>
> (Kinda funny, because I do help to maintain the apm821xx and the new
> ipq40xx target over there.)

Yeah it was more of a hobby, partly research for a lecture
on maintaining old ARM systems and all dangerous aftermarket
devices that is littering the world.

Since I have noticed that the adoption of OpenWRT/LEDE goes
far beyond routers and it is one of the most prevalent
distributions that is existing in the IoT of darkness on the
planet being the most deployed OS for bitcoin mining and
being picked up for functional safety (such as automotive)
because of its minimalist userspace.

I'm still amazed by the weirdness of our business.

> In any case, I implemented your suggestion and it does look reasonable.
> The gpiolib already uses the gpio_offset as an ID of some sorts. For
> now I went with a simple ID value check, but this could be extended to
> a range/intersection check if necessary. But then again, let's not
> overengineer it. Comments are welcome, I'll wait around till sometime
> next week before I post v3.

I'm going through my mailbox now, sorry for delays in feedback
and review :(

Yours,
Linus Walleij
