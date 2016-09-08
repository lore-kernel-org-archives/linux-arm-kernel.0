From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2016 15:21:08 +0200
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160905122611.GO1041@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home> <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home> <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home> <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <CACRpkdZBNH=4qZEfcLzqZAN=tum2f3YeoQj0D5PsH+P0Cf+7LQ@mail.gmail.com>
 <20160905122611.GO1041@n2100.armlinux.org.uk>
Message-ID: <CACRpkdZkCHqYYpYKA+Nvj4XY1zecdbZxMuRe=bbdziJL2fHf6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 5, 2016 at 2:26 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Sep 05, 2016 at 11:06:28AM +0200, Linus Walleij wrote:
>> I couldn't resist testing on the Compaq iPAQ h3600. It works the
>> same as before so:
>> Tested-by: Linus Walleij <linus.walleij@linaro.org> [for Compaq iPAQ H3600]
>
> Great news.  I've been thinking about digging out my h3600, but it's
> very old, and hasn't been turned on for many years.  I'm not sure what
> state it's in.
>
> I've been hoping to try booting some kernels with qemu-system-arm, but
> so far I've completely failed to get qemu-system-arm to do anything
> useful - it just sits there doing apparently nothing, irrespective of
> which platform I choose or which kernel I give it.
>
>> The only news in the bootlog is this:
>> sa11x0-pcmcia: probe of sa11x0-pcmcia failed with error -2
>
> Not so great news - that's -ENOENT.  Did that happen before these
> changes?  That could be that the gpiod lookup table isn't found.
> However, if that were the case, I'd have expected an error message
> along the lines of:
>
> Failed to get GPIO for xxx: -nnn
>
> from soc_pcmcia_request_gpiods().  The other possibility is that
> we're not getting to sa11x0_drv_pcmcia_legacy_probe() but instead
> trying to initialise it as a generic sa11x0 socket, and
> sa11x0_pcmcia_hw_init() is failing as a result.
>
> We should be using the legacy probe on H3600, so sa11x0_pcmcia_hw_init()
> should never be reached.

However that is what happens, this is my callstack after
adding some prints:

sa11x0_pcmcia_init
sa11x0_drv_pcmcia_probe
soc_pcmcia_init_one
soc_pcmcia_add_one
soc_pcmcia_hw_init
sa11x0_pcmcia_hw_init
soc_pcmcia_add_one: pcmcia HW init failed
sa11x0-pcmcia: probe of sa11x0-pcmcia failed with error -2

It bails out when trying to get the "reset" gpio.

I'm trying to figure out how this can happen.

On the plus side: this minor snag is all the problems I have.
All other GPIOs work exactly as they should.

Yours,
Linus Walleij
