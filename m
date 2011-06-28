From: highguy@gmail.com (Stijn Devriendt)
Date: Tue, 28 Jun 2011 13:53:07 +0200
Subject: [PATCH 0/2] RFC: gpio: driver-local pin configuration
In-Reply-To: <BANLkTikpMdakfTU+RRsXQVnpO4-KGkOGJQ@mail.gmail.com>
References: <1307695731-28018-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTinxptCJRETreCpUoV-nU2K4fuFcmQ@mail.gmail.com>
	<BANLkTimMSChGFUSnFWFHv3nNUca_Fyawaw@mail.gmail.com>
	<20110627120256.GA19531@opensource.wolfsonmicro.com>
	<BANLkTikpMdakfTU+RRsXQVnpO4-KGkOGJQ@mail.gmail.com>
Message-ID: <BANLkTinWmdWgGD9ui+WVV7DyCzy73S5AkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 2:37 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 27, 2011 at 2:02 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Mon, Jun 27, 2011 at 01:44:43PM +0200, Linus Walleij wrote:
>>
>>> Yes. To make the driver platform neutral, it needs to for example
>>> provide a callback in the platform data like (* set_pin_bias) or so,
>>> and then your platform has to implement this biasing.
>>
>>> In this specific case that kind of stuff would likely be preferable
>>> to have in the platform anyway, but I understand what you mean.
>>
>> How about device tree usage? ?I guess there we'd end up doing it by
>> putting the configuration on the GPIO end of things rather than on the
>> GPIO user side?
>
> Sorry I can't quite understand that, please elaborate!
>

I have some code doing this as well (in a very limited fashion):

int of_request_gpio(..., int* remaining_flags)
{
  of_get_gpio_flags(of_dev, i, remaining_flags)
  if (flags & bias_X) {
     gpio_set_bias(gpio, ...)
     flags &= ~bias_X
  }
  // interpret all generic flags here
};

So drivers need not worry about all gpio flags and special things.
They just request the pin; what they receive is a fully configured
pin (with the exception of unknown flags passed out via
remaining_flags).

Regards,
Stijn
