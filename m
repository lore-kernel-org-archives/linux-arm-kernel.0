From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 11 Oct 2010 13:10:48 +0200
Subject: [PATCHv2] mmci: work with only one irq
In-Reply-To: <20101011094404.GB27153@n2100.arm.linux.org.uk>
References: <1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
	<1286755601-25664-1-git-send-email-rabin.vincent@stericsson.com>
	<20101011094404.GB27153@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=YYqVat9XF2_jhTs4spcBYx+n+7DGFKm47hXkY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/11 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Oct 11, 2010 at 05:36:41AM +0530, Rabin Vincent wrote:
>> @@ -276,6 +292,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>> ? ? ? if (status & MCI_DATAEND) {
>> ? ? ? ? ? ? ? mmci_stop_data(host);
>>
>> + ? ? ? ? ? ? /* MCI_DATABLOCKEND not used with single irq */
>> + ? ? ? ? ? ? if (host->singleirq && !data->error)
>> + ? ? ? ? ? ? ? ? ? ? host->data_xfered = data->blksz * data->blocks;
>> +
>
> I'm uneasy about this. ?If we don't get datablockend interrupts, then
> when there's an error we don't know how much data was transferred, and
> with big requests, we're going to have a very long time spent retrying
> block by block.

This one should probably remain a ux500-specific flag, unlike the single
IRQ flag, this is something else.

AFAICT the DBCKEND signal is simply not routed in the ux500
(probably neither on the Nomadik) variant, so we can't wait for it.

On the U300 on the other hand, it is routed and available, if and
only if you're using PIO mode. (However it can arrive *after* the
DATAEND signal, which the other pending patch takes care of).

During DMA this signal is disfunct also in U300...

Yours,
Linus Walleij
