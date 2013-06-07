From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Jun 2013 10:21:46 -0600
Subject: Active-low behavior in gpiolib
In-Reply-To: <CACRpkdYmOHX2bPMKHwY=V2L+4EN-+5KzD-YCJhQtfkFeKV5p8g@mail.gmail.com>
References: <CAAVeFu+hQHScYYkvO1KOrUPLLaC0ju_O4SDZWyJE8KhLn_hibQ@mail.gmail.com>
 <CACRpkdYmOHX2bPMKHwY=V2L+4EN-+5KzD-YCJhQtfkFeKV5p8g@mail.gmail.com>
Message-ID: <51B2089A.1070404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 01:10 AM, Linus Walleij wrote:
> On Wed, Jun 5, 2013 at 7:22 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> 
>> FLAG_ACTIVE_LOW, on the other hand, is *only* set and used through
>> sysfs operations. Independently, the active low property can be
>> specified in gpio phandles and retrieved by
>> of_get_(named_)gpio_flags() - only it has to be kept in a separate
>> variable which must then be checked everytime one wants to change the
>> GPIO value to set the correct level.
> 
> Well it is designed as a sysfs-only thing according to the comment:
> drivers/gpio/gpiolib.c:#define FLAG_ACTIVE_LOW  6       /* sysfs value
> has active low */
> 
> So I think your actual question is whether it should also be
> enabled for the kernel-internal interfaces.
> 
> Currently we have things like this:
> 
> /**
>  * struct mmci_platform_data - platform configuration for the MMCI
>  * (also known as PL180) block.
> (...)
>  * @gpio_cd: read this GPIO pin to detect card insertion
>  * @cd_invert: true if the gpio_cd pin value is active low
> (...)
>         int     gpio_cd;
>         bool    cd_invert;
> 
> So the knowledge of whether a certain GPIO is active high or low
> is spread out through drivers, and the API only drives the line in a
> very explicit way.
...
> So the only thing gained is that gpiolib gets some knowledge
> of how the pin is used. But what is the gain of that?

Well, the big gain I see is that every driver needs to somehow find out
whether the GPIO is active-low or not, and store a separate flag for it,
and XOR all data with that flag. That's not a massive amount of code,
but it's really rather annoying. Why can't we just tell gpiolib what the
polarity is, and let it deal with it. In the DT case, this "tell gpiolib
what the polarity is" would be 100% hidden inside the DT parsing/mapping
(of_xlate) code. For non-DT, presumably this could be a flag that the
board file or platform code programs into gpiolib early on.

If you're worried about this hiding too much information, and that some
code might want to know what's really going on rather than the logical
values, perhaps:

gpiod_[gs]et() - return/accept logical values
gpiod_[gs]et_raw() - return the actual electrical level

gpiod_[gs]et() might also hide details of
open-drain/collector/source/... too, and do automatic tri-stating based
on the level of output that was desired?
