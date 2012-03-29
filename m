From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Mar 2012 23:22:55 +0200
Subject: [PATCH] serial: PL011: move interrupt clearing
In-Reply-To: <CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
Message-ID: <CACRpkdZ4pxUDpe3aEv3y_Smn5K17f_Q5G-k=EVPzw8NvxpF2iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 10:49 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:

>> Commit 360f748b204275229f8398cb2f9f53955db1503b
>> "serial: PL011: clear pending interrupts"
>> attempts to clear interrupts by writing to a
>> yet-unassigned memory address. This fixes the issue.
>
> Ugh; the original patch is obviously broken. ?How did it get applied
> without testing?

I've felt bad about that for a while, but to the best of my knowledge I did
test it. Either I did some manual slip with the boot images or there was
something else causing it to actually work as it looked... Chanho also
had it working IIRC.

> Greg, can you get this out to Linus ASAP please? ?I have one comment
> below, but I don't think it should block merging this patch.
>
> Tested-by: Grant Likely <grant.likely@secretlab.ca>

Thanks.

>> - ? ? ? /* Ensure interrupts from this UART are masked and cleared */
>> - ? ? ? writew(0, uap->port.membase + UART011_IMSC);
>> - ? ? ? writew(0xffff, uap->port.membase + UART011_ICR);
>> -
>> ? ? ? ?uap->vendor = vendor;
>> ? ? ? ?uap->lcrh_rx = vendor->lcrh_rx;
>> ? ? ? ?uap->lcrh_tx = vendor->lcrh_tx;
>> @@ -1951,6 +1947,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>> ? ? ? ?uap->port.line = i;
>> ? ? ? ?pl011_dma_probe(uap);
>>
>> + ? ? ? /* Ensure interrupts from this UART are masked and cleared */
>> + ? ? ? writew(0, uap->port.membase + UART011_IMSC);
>> + ? ? ? writew(0xffff, uap->port.membase + UART011_ICR);
>> +
>
> Is it correct to move the interrupt clearing below the
> pl011_dma_probe() call? ?I've tested the fix with the interrupt
> clearing both above and below the pl011_dma_probe() call and versatile
> qemu boots in both cases.

pl011_dma_probe() basically just make logical setup so we do the
clear-out as the last step of setup.

Yours,
Linus Walleij
