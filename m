From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Feb 2012 11:41:31 +0100
Subject: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl
 interaction
In-Reply-To: <20120220073941.GC22562@n2100.arm.linux.org.uk>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
 <20120220073941.GC22562@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbMFN3=XTSg1oE310eTHecrs6XaMz+DCNYJzwOg8JEEiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 8:39 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Feb 19, 2012 at 11:27:42PM -0700, Stephen Warren wrote:
>> Update gpio.txt based on recent discussions regarding interaction with the
>> pinctrl subsystem.
>>
>> Previously, gpio_request() was described as explicitly not performing any
>> required mux setup operations etc.
>>
>> Now, gpio_request() is explicitly as explicitly performing any required mux
>> setup operations where possible. In the case it isn't, platform code is
>> required to have set up any required muxing or other configuration prior to
>> gpio_request() being called, in order to maintain the same semantics.
>
> So what if you need to have the pin as a GPIO, manipulate it as a GPIO,
> and then hand it off to a special function, and then take it back as
> a GPIO before you shut the special function down ?

I remember this case very well and we designed for it, so it should be handled
by pin control and GPIO thusly:

Example: use pins 1,2 as I2C, then convert them to GPIO for a while
then back again:

// This call looks up a map containing pins 1,2 and reserve them
p = pinctrl_get(dev, "i2c");
if (IS_ERR(p))
  ...
pinctrl_enable(p);
pinctrl_disable(p);
// This will free up the pins again
pinctrl_put(p);
// So now we can do this...
// NB: the GPIO driver calls pinctr_request_gpio() to check
// that it can take these pins
gpio_request(1, "gpio1"):
gpio_request(2, "gpio2");
// This will trigger a reset or something
gpio_direction_output(1, 1);
gpio_direction_output(2, 1);
// Release pins again
gpio_free(1);
gpio_free(2);
// Take them back for this function
p = pinctrl_get(dev, "i2c");

It's a bit kludgy but works and makes sure the pins are only used
for one thing at a time.

BTW: Russell, which specific platform and driver was it that had this
usecase? I'd like to have a look at the code to educate myself.

Yours,
Linus Walleij
