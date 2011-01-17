From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 17 Jan 2011 17:02:08 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
Message-ID: <4D346800.3070603@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2011 04:12 PM, Rabin Vincent wrote:
> On Mon, Jan 17, 2011 at 20:07, Linus Walleij
> <linus.walleij@stericsson.com>  wrote:
>    
>> +        * On the U300 and Ux500 a few to many MCI_DATABLOCKEND interrupts
>> +        * are usually missing, so the data counter is not properly increased.
>> +        * This is likely because new block arrive while the IRQ is being
>> +        * processed without the transfers being held back, and ACK:in the
>> +        * interrupt will only clear the very last block and intermediate
>> +        * blockend interrupts get lost. So we simply mask of the blockend
>> +        * interrupt on these and only use the dataend interrupt.
>>      
> Have you observed this to be different on the ARM variants?  I asked a
> related question about this earlier:
>
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/101118:
> | In MMCI, on variants which use the DATABLOCKEND interrupt, if we cross
> | more than one block boundary in the loop inside mmc_pio_read() or
> | mmci_pio_write(), when the DATABLOCKEND irq is handled after interrupts
> | are enabled in mmci_pio_irq(), won't the block count be incorrect
> | because we would consider that only one block has been transferred, when
> | in fact it has been two?  Or can this never happen for some reason?
>    

Yes it is very different, see the log I sent in reply to Russells earlier
mail. It's not just one blockend missing, sometimes it's two (on U300)
and on Ux500 it's something like 5 out of 128 blockends that actually
get fired, the rest are missing.

Now the only variant actually using that interrupt is the original
ARM version found in RealView & Versatile. I have run this code
on the PB1176 but it wasn't missing any blockends. No errors.

I tried to increase the clock speed to see if I could provoke the
error in the RealView, but hit FIFO overflow (since these variants
does not have hardware flow control) before I got to the speed
where I presume the error could occur.

Yours,
Linus Walleij
