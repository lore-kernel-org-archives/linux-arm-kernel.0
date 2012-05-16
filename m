From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2012 13:59:42 +0200
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120516111744.GB9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <20120516111744.GB9571@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdazMG1D6L6nWo330EWTZ_Fn6K0F5cjZSfMRGmk9OsaVXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 1:17 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> This series removes the dependence on the dma_slave_config direction
>> argument for the PL08x DMA engine driver, and in doing so, we end up
>> with less code in the driver.
>>
>> We now compute the cctl values for both directions, and continue to
>> select the appropriate one at prepare time.  If this is found to be
>> invalid, the prepare function will return NULL.
>>
>> However, we still use the direction argument in the slave configuration
>> call to determine whether we should report and fail an invalid
>> configuration.  Eventually this will be removed.

The direction of this is sound.

I think one thing that needs fixing along with this is the PL180/MMCI
driver since it currently accepts a single channel and then switch
direction of that channel depending on whether we read or write
from/to the device.

All channel providers and machines need to be checked to see
they use the parameter from prep_slave_sg() instead. The pair
I can think of is the COH901318 DMAengine driver and the U300
platform data (the ux500 has two channels, TX and RX).

Don't let this hold you back though, I'm happy to fix up any breakage
to get this moving.

> This is the final patch, which is not part of this RFC, which illustrates
> where we should be with this driver. ?Note that this will require all
> slave users to issue a DMA slave configuration call before they use the
> channel; the "defaults" are no longer used. ?I think this is the case
> today anyway. ?Note - even more code reduction...

This looks good. I tried to apply the patch to test it but failed so I
guess there is some more development underneath it.

> @@ -47,7 +47,8 @@ enum {
> ?* devices with static assignments
> ?* @muxval: a number usually used to poke into some mux regiser to
> ?* mux in the signal to this channel
> - * @cctl_opt: default options for the channel control register
> + * @cctl: default options for the channel control register
> + * ?*** not used for slave channels ***

Maybe just rename this thing cctl_memcpy then?

Yours,
Linus Walleij
