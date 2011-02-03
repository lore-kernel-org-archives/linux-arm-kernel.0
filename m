From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Thu, 3 Feb 2011 17:12:56 +0530
Subject: [PATCHv2 2/2] Input: ads7846 - configure pendown gpio as input
In-Reply-To: <20110203100528.GA6508@pengutronix.de>
References: <1296726530-32199-1-git-send-email-sourav.poddar@ti.com>
	<20110203095845.GK23561@legolas.emea.dhcp.ti.com>
	<20110203100528.GA6508@pengutronix.de>
Message-ID: <AANLkTi=dkNkqtBiUm-BJKw+RS2wFZ_mTSc9PFW+MrP05@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 3, 2011 at 3:40 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Feb 03, 2011 at 11:58:45AM +0200, Felipe Balbi wrote:
>> On Thu, Feb 03, 2011 at 03:18:50PM +0530, Sourav Poddar wrote:
>> > The ads7846 driver requests a gpio to detect pendown events,
>> > but does not configure its direction. Configure this gpio
>> > as an input after requesting it.
>> >
>> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> > ---
>> > changes between v2 and v1: Added return error support in v2.
>> >
>> > drivers/input/touchscreen/ads7846.c | ? ?7 +++++++
>> > 1 files changed, 7 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>> > index 036f245..f30768b 100644
>> > --- a/drivers/input/touchscreen/ads7846.c
>> > +++ b/drivers/input/touchscreen/ads7846.c
>> > @@ -962,6 +962,13 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>> > ? ? ? ? ? ? return err;
>> > ? ? }
>> >
>> > + ? err = gpio_direction_input(pdata->gpio_pendown);
>> > + ? if (err) {
>> > + ? ? ? ? ? dev_err(&spi->dev, "failed to configure pendown GPIO input direction %d\n",
>> > + ? ? ? ? ? ? ? ? ? pdata->gpio_pendown);
>> > + ? ? ? ? ? return err;
>>
>> and now you miss a gpio_free().
>
> Better use gpio_request_one()?

Totally agreed,using gpio_request_one seems to be the better option.
Will post a patch for it.
