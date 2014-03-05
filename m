From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Mar 2014 09:31:42 +0800
Subject: pinctrl: pinctrl-single vs custom driver
In-Reply-To: <530BFEC0.2070805@broadcom.com>
References: <530BFEC0.2070805@broadcom.com>
Message-ID: <CACRpkdYhCDpKxkMxcHHLyp2mTf8-3mhioZkNqQACHcKjL+3erQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 10:24 AM, Sherman Yin <syin@broadcom.com> wrote:

>> Your driver defining pins and functions is better.
>
> Like the bcm281xx, in this SoC, each pin is also controlled by 1 register,
> so pinctrl-single should work.

One other deciding factor is what kind of information you have available
on these pin registers and what format they are in. If your system is
well documented and not delivered in some register map description
format you should typically open code the hardware information in the
driver.

>  The difference between this SoC and bcm281xx
> is that the pin registers in this SoC are only accessible via a messaging
> mechanism (send a command then wait for a reply), not a simple register
> read-write.  We have defined one message for reading the register and one
> for writing to it.

This is no different from e.g. drivers/pinctrl/pinctrl-abx500.c which marshals
register writes to an MFD device. (Which in turn is on I2C.)

> In a driver like pinctrl-bcm281xx, pinmux and pin configs are separately
> applied and on a per-pin basis.  A simple update of 1 pin will thus result
> in numerous messages:
>
>  1. Send cmd to read register, block for reply
>  2. Rcv reply with value
>  3. Modify pinmux portion
>  4. Send cmd to write register
>  5. Send cmd to read register, block for reply
>  6. Rcv reply with value
>  7. Modify pin configs portion
>  8. Send cmd to write register
>
> With pinctrl-single, updating pins will be much simpler with just 1 message
> to directly write the whole register.

OK I see the point, however... which solution is easiest for a developer
to understand?

> Is this efficiency enough to warrant using pinctrl-single over a "normal"
> pinctrl driver in this case?

So I would say that this code execution is likely not on the time-critical
path?

Also take the debuggability and understandability of the code as a
very important factor. Which driver will be easiest for a developer to
cope with, and which will be easiest to use when debugging the
system?

Yours,
Linus Walleij
