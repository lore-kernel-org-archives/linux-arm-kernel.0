From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 5 Jan 2011 17:02:56 +0100
Subject: mmci: U300 "sync with blockend" broken for multi-block?
In-Reply-To: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
Message-ID: <AANLkTi=y3J6oa4a7KYB_i+jFG_AdnyvQY==Ha1RAL+gr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/1 Rabin Vincent <rabin@rab.in>:

> In MMCI, there is some code to sync between the MCI_DATABLOCKEND and the
> MCI_DATAEND for U300 variants, which ensures that the transfer
> terminates only when both MCI_DATABLOCKEND and MCI_DATAEND occurs:
>
> ? ? ? ? * In the U300, the IRQs can arrive out-of-order,
> ? ? ? ? * e.g. MCI_DATABLOCKEND sometimes arrives after MCI_DATAEND,
> ? ? ? ? * so for this case we use the flags "blockend" and
> ? ? ? ? * "dataend" to make sure both IRQs have arrived before
> ? ? ? ? * concluding the transaction.
>
> It seems to me that this code won't work correctly for multi-block
> transfers, because there MCI_DATABLOCKEND will hit for the earlier
> blocks and the blockend flag will be set, and if on the last block the
> MCI_DATABLOCKEND hits after the MCI_DATAEND, this synching code won't do
> what it's trying to do and will instead just terminate the transfer
> after MCI_DATAEND.

Yes Ulf Hansson has spotted this problem...

Actually, there is this patch in the public ST-Ericsson git:
http://git.linaro.org/gitweb?p=bsp/st-ericsson/linux-2.6.35-ux500.git;a=commitdiff;h=2f0534d9527540a0a28e124f4e827f146f3bc128

The intention is to send out patches ASAP right now the
vacations have been holding things back a bit. (Else I
would have done it myself.)

Ulf would you like to submit this patch to the maillist?
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
for what's in the public git.

Yours,
Linus Walleij
