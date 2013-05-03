From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 16:35:28 +0200
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <517AF0C1.60009@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <515319D5.20105@wwwdotorg.org>
 <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
 <5155C902.7080207@wwwdotorg.org>
 <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org>
 <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
 <51671D7B.5060303@wwwdotorg.org>
 <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
 <51673D70.3010503@wwwdotorg.org>
 <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
 <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
 <516C31C3.9040505@wwwdotorg.org> <516C7C43.3040105@wwwdotorg.org>
 <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org>
 <516DA60A.5070000@ti.com> <516DCCA8.3070108@wwwdotorg.org>
 <516DDB4D.9020500@ti.com> <516EC2AF.9090905@wwwdotorg.org>
 <CACRpkdaOOrooK7kff2Y-7gH6L6m-MsiU7PfHnqBkPpc=tk_iWA@mail.gmail.com>
 <517AF0C1.60009@ti.com>
Message-ID: <CACRpkdbSjKaeAreG02Q4c3bZ3-Zzg6d=qUKfm4WTQKWsX8B_Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 11:25 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> On 04/26/2013 02:27 AM, Linus Walleij wrote:

>> You will just have to give the xlate function information about which
>> GPIOs are used as IRQs only, and only request the GPIO on these.
>
> That should not be necessary. The xlate is only called in the case where
> the gpio controller is declared as the interrupt controller in the
> device tree source ...

Sorry I don't understand this. Irqdomains are not device tree
concepts. Why would it only be called if it was declared such
or such in the device tree?

> eth at 0 {
>         compatible = "ks8851";
>         ...
>         interrupt-parent = <&gpio2>;
>         interrupts = <2 8>; /* gpio line 34, low triggered */
>         ...
> };
>
> So in the case where you have a driver call gpio_request() and then
> request_irq(), in the device tree source, the gpio controller will not
> be declared as an interrupt controller. It will just list the gpios ...

And how do you get from there to the conclusion that
gpio_to_irq() will not ever be called, maybe by
some other driver than the ethernet?

> sdhci at c8000200 {
>         ...
>         cd-gpios = <&gpio 69 0>; /* gpio PI5 */
>         wp-gpios = <&gpio 57 0>; /* gpio PH1 */
>         ...
> };

Like if this driver wants to set up an IRQ?

>> It all comes back to this: keep all applicable knowledge in the
>> system, so it can make proper decisions, don't try to create
>> mechanisms that will half-guess things.
>
> Agreed. However the xlate looks like a good place to request the gpio
> without needing to add these "input-hogs" or any other platform code. So
> if this is not considered abuse of the xlate, then it seems like an
> ideal solution. I have been also implementing a generic xlate so that we
> don't need to have a xlate for each platform as well.

I'm still not following. Maybe I'm just too stupid...

How do you *avoid* requesting the GPIO in the translation
for a certain IRQ if the driver first issues gpio_request() and
then goes on to perform gpio_to_irq() itself?

Yours,
Linus Walleij
