From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Thu, 3 Feb 2011 18:31:24 +0530
Subject: [PATCHv2 2/2] Input: ads7846 - configure pendown gpio as input
In-Reply-To: <AANLkTi=J5dJ4N4_57fh0_HKmqfyo6C_tMs3BrnXHWQjq@mail.gmail.com>
References: <1296726530-32199-1-git-send-email-sourav.poddar@ti.com>
	<20110203095845.GK23561@legolas.emea.dhcp.ti.com>
	<AANLkTi=J5dJ4N4_57fh0_HKmqfyo6C_tMs3BrnXHWQjq@mail.gmail.com>
Message-ID: <AANLkTi=m1o2Fsw1OvCmZWJxmok2KCtCZp3F4aM7KmPch@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 3, 2011 at 3:34 PM, Varadarajan, Charulatha <charu@ti.com> wrote:
> Sourav,
>
> On Thu, Feb 3, 2011 at 15:28, Felipe Balbi <balbi@ti.com> wrote:
>> On Thu, Feb 03, 2011 at 03:18:50PM +0530, Sourav Poddar wrote:
>>> The ads7846 driver requests a gpio to detect pendown events,
>>> but does not configure its direction. Configure this gpio
>>> as an input after requesting it.
>>>
>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>> ---
>>> changes between v2 and v1: Added return error support in v2.
>>>
>>> drivers/input/touchscreen/ads7846.c | ? ?7 +++++++
>>> 1 files changed, 7 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>>> index 036f245..f30768b 100644
>>> --- a/drivers/input/touchscreen/ads7846.c
>>> +++ b/drivers/input/touchscreen/ads7846.c
>>> @@ -962,6 +962,13 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>>> ? ? ? ? ? ? ? return err;
>>> ? ? ? }
>>>
>>> + ? ? err = gpio_direction_input(pdata->gpio_pendown);
>>> + ? ? if (err) {
>>> + ? ? ? ? ? ? dev_err(&spi->dev, "failed to configure pendown GPIO input direction %d\n",
>>> + ? ? ? ? ? ? ? ? ? ? pdata->gpio_pendown);
>>> + ? ? ? ? ? ? return err;
>>
>> and now you miss a gpio_free().
>
> My question to your previous version is still unanswered.
> Would it be relevant to add gpio_set_debounce() for this
> gpio?
>
 I was also wondering that.I too think that just a request and then an
 configuring direction would do.But,I am not so sure about this one.
