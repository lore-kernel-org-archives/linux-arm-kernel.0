From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Oct 2012 14:19:57 +0200
Subject: [PATCH V2 3/3] spi: spi-pl022: Minor simplification for runtime pm
In-Reply-To: <CAPDyKFqZXKtpJ8vSFKfZuD8FGayQUhmYKtZKzkZ15jKRA5nu6Q@mail.gmail.com>
References: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
 <1349337881-15917-4-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqZXKtpJ8vSFKfZuD8FGayQUhmYKtZKzkZ15jKRA5nu6Q@mail.gmail.com>
Message-ID: <CACRpkdb9mLy1640Y9xuN_EgUd2xCwjpc1ErZaBmLOcJT4ffaxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2012 at 11:07 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Mark, I am not sure this particular patch is actually wanted. Realized
> that when reading up on the driver/base/* patches for PM changes this
> summer. Especially how device probe/suspend/shutdown etc. has been
> changed for runtime PM point of view.

Mark will get you for top-posting ;-)

>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> In probe pm_runtime_put_autosuspend has the same effect as doing
>> pm_runtime_put. This due to upper layer in driver core is preventing
>> the device from being runtime suspended by a pm_runtime_get*.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/spi/spi-pl022.c |    5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
>> index a1db91a..51b7a95 100644
>> --- a/drivers/spi/spi-pl022.c
>> +++ b/drivers/spi/spi-pl022.c
>> @@ -2246,10 +2246,9 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>>                 pm_runtime_set_autosuspend_delay(dev,
>>                         platform_info->autosuspend_delay);
>>                 pm_runtime_use_autosuspend(dev);
>> -               pm_runtime_put_autosuspend(dev);
>> -       } else {
>> -               pm_runtime_put(dev);
>>         }
>> +       pm_runtime_put(dev);
>> +
>>         return 0;

I'm paging Rafael and Magnus for their comments so we don't
overload Mark with runtime PM semantics...

Yours,
Linus Walleij
