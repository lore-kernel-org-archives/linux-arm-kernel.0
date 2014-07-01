From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 1 Jul 2014 21:24:22 +0900
Subject: [PATCH] regulator: core: Still free GPIOs using gpio_free()
In-Reply-To: <20140701121142.GM23300@sirena.org.uk>
References: <1404215726-2480-1-git-send-email-broonie@kernel.org>
 <20140701120622.GJ32514@n2100.arm.linux.org.uk>
 <20140701121142.GM23300@sirena.org.uk>
Message-ID: <CAAVeFuJqRW0ih8Mg9MFwLf=wQ7eVK5+pm8deW0vTUdozJ16FfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 9:11 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 01, 2014 at 01:06:22PM +0100, Russell King - ARM Linux wrote:
>> On Tue, Jul 01, 2014 at 12:55:26PM +0100, Mark Brown wrote:
>
>> > Even though we mostly use GPIO descriptors internally we still use
>> > gpio_request_one() to request so we need to pair that with gpio_free() to
>> > release the GPIO.
>
>> This doesn't explain the reason...  I see the current GPIO code doing this:
>
>> void gpio_free(unsigned gpio)
>> {
>>         gpiod_free(gpio_to_desc(gpio));
>> }
>> EXPORT_SYMBOL_GPL(gpio_free);
>
> Huh, good point (though it still seems a bit neater to match up the
> request and release functions I guess).  Linus?

Yeah it's a nice habit to free the GPIOs using the same interface as
the one used to obtain them. Although if we are to allow the regulator
framework to request GPIO through both the integer and descriptor
interfaces, we certainly don't want to track that information forever.

On top of that we want to limit the use of gpio_to_desc() and
desc_to_gpio() in drivers as much as possible, so I'd say I prefer to
see gpiod_free() used no matter where the GPIO came from.
