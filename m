From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 15:29:38 +0100
Subject: [Bulk] Re: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol
 driver for arch-vt8500
In-Reply-To: <1363062095.23051.16.camel@gitbox>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
 <513E09FE.5040104@wwwdotorg.org> <1363062095.23051.16.camel@gitbox>
Message-ID: <CACRpkdYTKk-fPkUX_jOoHoqxgpsEh2L1ryGC7VSNiAbsmOtcEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 5:21 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> On Mon, 2013-03-11 at 10:44 -0600, Stephen Warren wrote:

>> > +Required subnode-properties:
>> > +- wm,pins: An array of cells. Each cell contains the ID of a pin.
>>
>> That's a little odd. Presumably this is to allow configuring "pin
>> configuration" data beyond the mux function and pull. Why aren't those
>> options exposed as explicit properties, rather than allowing manual
>> register tweaking?
>
> Little confused about this one - wm,pins is the same as the brcm binding
> and is the pins being configured.
>
> I assume you mean wm,pinmux is confusing.
>
> The wm,pinmux does, as you guessed, control some addition pinmux
> alternate features. I exposed it this way because we don't know what
> most of the bits in the register do (There is no vendor hardware
> documentation for these SoCs), and rather than having to churn the code
> constantly to add the new configurations it seemed to make sense to just
> expose the register this way and let people configure it in the DT. It
> is masked so that we can change only the bits we know and leave the rest
> as configured by the bootloader.
>
> Also, it would also add a lot of complexity to the pinctrl code to
> support the few additional functions we know this register provides
> because each SoC has a different layout for bits in this register, and
> we don't actually know which pins/pads are controlled by each bit
> (again, lack of documentation).
>
> I realise this is contradictory to the point of having a pinctrl driver,
> but it was the best I could come up with given the poor information we
> have.
>
> Always open to suggestions..

In that case I strongly prefer that you try to encode this into the driver
as such if that is possible. Putting it into the device tree will be
subject to flux, and while we can handle some drastic code changes
internally in the kernel, device trees will need to stay
backward-compatible.

Isn't it possible to put a table for this into the kernel code and just
switch the right numbers in from the compatible= string?

Yours,
Linus Walleij
