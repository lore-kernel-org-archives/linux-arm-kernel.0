From: krzysztof.adamski@tieto.com (Krzysztof Adamski)
Date: Tue, 16 Feb 2016 09:00:05 +0100
Subject: [PATCH] pinctrl: sunxi: set pin function as input on export
In-Reply-To: <CACRpkdbd4f3yj2MnR6PU5SuhV5Tj4HzWLc0UX8jQkcJp7MoTig@mail.gmail.com>
References: <1454942242-25690-1-git-send-email-krzysztof.adamski@tieto.com>
 <CACRpkdbd4f3yj2MnR6PU5SuhV5Tj4HzWLc0UX8jQkcJp7MoTig@mail.gmail.com>
Message-ID: <20160216080004.GA24625@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 11:04:26PM +0100, Linus Walleij wrote:
>On Mon, Feb 8, 2016 at 3:37 PM, Krzysztof Adamski
><krzysztof.adamski@tieto.com> wrote:
>
>> Default function of a pin in sunxi SoCs is "disabled". By default gpios
>> exported by sysfs are set as input and indeed, when reading "direction"
>> file you will get "in". The "value" pin won't return proper value,
>> though, confusing user of this interface.
>>
>> This patch sets direction of a GPIO as input when exporting it.
>>
>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@tieto.com>
>
>As maxime says it's not a sunxi problem.
>
>So maybe it is wrong to set pins to either input or output when
>exporting them, I suspect they should be exported as is.
>
>Also: the sysfs ABI is deprecated. I suggest you invest your time
>in working on the new chardev ABI.

While sysfs API may be very limited it does have it's strengths too. One 
of them is that it's trivially scriptable even from bash or other 
scripting languages and the other one is that it's there for so long 
that it's very popular and it will take much time before all the 
tutorials and existing applications are updated. So, well, I still find 
it useful to have good support for it.

I find current behaviour of sysfs interface broken (it says that GPIO is 
in input mode when in reality it isn't) and still think it's a good idea 
to fix it. But putting sysfs issue aside, wouldn't it be safer to set 
some well known state of the pin when requesting it instead of leaving 
it at whatever was set before? The same question goes for freeing, 
actually, shouldn't the pin be disabled when we call gpio_free instead 
of leaving it at its last state?

There are existing drivers that set gpio direction to input when 
requesting the pin (for example pinctrl-plgpio.c, pinctrl-sirf.c) so 
sunxi wouldn't be the only driver to do this. This does also show that 
indeed the problem is not sunxi specific, though.

Best regards,
Krzysztof Adamski
