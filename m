From: mr.nuke.me@gmail.com (Alexandru Gagniuc)
Date: Wed, 19 Mar 2014 15:41:09 -0500
Subject: [PATCH v2 0/1] ARM: sun4i: spi: Allow transfers larger than FIFO size
In-Reply-To: <1395261670-19386-1-git-send-email-mr.nuke.me@gmail.com>
References: <1395261670-19386-1-git-send-email-mr.nuke.me@gmail.com>
Message-ID: <1395261670-19386-3-git-send-email-mr.nuke.me@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second iteration of the patches sent yesterday. Per
Maxime's request, I have squashed them into one single patch, and
applied most of the suggestion he made.

As far as only clearing the interrupt _after_ draining the FIFO, I
found that we usually get one extra Rx interrupt per burst if we do
this, so I left the comment in.

>>       /* Enable the interrupts */
>> -     sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
>> -                                              SUN4I_INT_CTL_RF_F34);
>> +     reg = SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34;
>> +     /* Only enable Tx FIFO interrupt if we really need it */
>> +     if (tx_len > SUN4I_FIFO_DEPTH)
>> +             reg |= SUN4I_INT_CTL_TF_E34;
>> +     sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
>
> I'd be much dumber than that. Why don't you just enable both
> interrupts all the time if we need larger transfers ?

As I've pointed out previously, this interrupt is PITA, as it triggers
an IRQ storm if enabled without much thought. I found that
(tx_len > SUN4I_FIFO_DEPTH) is the best check for when it's safe to
enable this interrupt.

Alexandru Gagniuc (1):
  ARM: sun4i: spi: Allow transfers larger than FIFO size

 drivers/spi/spi-sun4i.c | 68 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 5 deletions(-)

--
1.8.5.3
