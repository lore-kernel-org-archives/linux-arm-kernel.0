From: josh.coombs@gmail.com (Josh Coombs)
Date: Wed, 2 Jan 2013 23:50:15 -0500
Subject: Kirkwood issues with 3.8-rc1 - Ooops and hang on reboot
In-Reply-To: <20121230002301.GA2631@n2100.arm.linux.org.uk>
References: <20121228171749.GA6152@lunn.ch>
 <20121228173818.GD24604@n2100.arm.linux.org.uk>
 <CAMW5UfaPv=Rq64MVtJNsdt8L4+0bq=cvbw5nqFBEcjY_+3cHZA@mail.gmail.com>
 <20121230002301.GA2631@n2100.arm.linux.org.uk>
Message-ID: <CAMW5UfZiUmGs9BRMz-NOAiU=E3uH8ZnSkAKPM6vud-PRwKfjZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 29, 2012 at 7:23 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Dec 29, 2012 at 06:31:37PM -0500, Josh Coombs wrote:
>> Bah, didn't send to everyone last time...
>>
>> Building with CONFIG_DEBUG_SECTION_MISMATCH enabled, the only warning
>> I get is for drivers/w1/masters/w1-gpio.o.
>>
>> WARNING: drivers/w1/masters/w1-gpio.o(.data+0x0): Section mismatch in
>> reference from the variable w1_gpio_driver to the function
>> .init.text:w1_gpio_probe()
>> The variable w1_gpio_driver references
>> the function __init w1_gpio_probe()
>> If the reference is valid then annotate the
>> variable with __init* or __refdata (see linux/init.h) or name the variable:
>> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>>
>> Shouldn't I be seeing a warning for
>> drivers/clk/mvebu/clk-gating-ctrl.o at this point as well?
>
> Unfortunately not.  mvebu_clk_gating_get_src() is referenced by another
> __init function, which is registering the pointer to
> mvebu_clk_gating_get_src() into other code.  That reference (obviously
> from the oops dump) persists past the point where the __init sections
> are freed.
>
> Hence why no section mismatch warning issued from the static tools;
> they're not infallible.

Ok, so a workaround would be to remove the __init tag so persists
properly, but it sounds like what I really should do is to find out
where that other reference is and why it's persisting to make sure
that's the right behavior in the first place?

Josh C
