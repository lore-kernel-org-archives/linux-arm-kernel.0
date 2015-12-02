From: eric@anholt.net (Eric Anholt)
Date: Wed, 02 Dec 2015 11:41:57 -0800
Subject: [PATCH 2/3] pwm: bcm2835: prevent division by zero
In-Reply-To: <CANLsYkzsFzhVVPo6iykExgbCd-4spJPusMCXxKstOw=CXfwQbw@mail.gmail.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
 <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
 <CANLsYkzsFzhVVPo6iykExgbCd-4spJPusMCXxKstOw=CXfwQbw@mail.gmail.com>
Message-ID: <87oae88woq.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On 1 December 2015 at 15:55, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> It's possible that the pwm clock become an orphan. So better
>> check the result of clk_get_rate in order to prevent a division
>> by zero.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/pwm/pwm-bcm2835.c |   10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
>> index 174cca9..31a6992 100644
>> --- a/drivers/pwm/pwm-bcm2835.c
>> +++ b/drivers/pwm/pwm-bcm2835.c
>> @@ -65,7 +65,15 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>                               int duty_ns, int period_ns)
>>  {
>>         struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
>> -       unsigned long scaler = NSEC_PER_SEC / clk_get_rate(pc->clk);
>> +       unsigned long rate = clk_get_rate(pc->clk);
>> +       unsigned long scaler;
>> +
>> +       if (!rate) {
>> +               dev_err(pc->dev, "failed to get clock rate\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       scaler = NSEC_PER_SEC / rate;
>
> Stefan,
>
> Please merge this code into patch 1/3.  That way it is done the right
> way the first time around.

They're separate changes and are good as separate patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/f419b922/attachment-0001.sig>
