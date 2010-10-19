From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 19 Oct 2010 14:52:40 +0200
Subject: [PATCHv2] mmci: work with only one irq
In-Reply-To: <20101011094404.GB27153@n2100.arm.linux.org.uk>
References: <1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
	<1286755601-25664-1-git-send-email-rabin.vincent@stericsson.com>
	<20101011094404.GB27153@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikgUGkVw1r1T8D2rDtcdGWOKqDDGYLBWhTdZvqP@mail.gmail.com>
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

I have sent a respin of Rabins patch (he's on vacation, so I got his
permission to fix this up) which removes this offending handling of
MCI_DATABLOCKEND, it's now also in the patch tracker as 6311/2.

On top of this I have updated my patch for out-of-order IRQ arrival
to cover also this case and renamed it
"handle broken MCI_DATABLOCKEND hardware"
it will do away with the confusing U300 #ifdef and adds a comment
block that explains what the problem really is on the Ux hardwares,
basically that under some circumstances in the U300 and under
all circumstances in the Ux500, the MCI_DATABLOCKEND flag
is totally unreliable and "hangs" at 1.

Yours,
Linus Walleij
