From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 12:25:20 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <4D46A44C.3030609@ru.mvista.com>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<4D46A44C.3030609@ru.mvista.com>
Message-ID: <20110131122520.GA11694@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 03:00:12PM +0300, Sergei Shtylyov wrote:
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index b6fd6dc..175a623 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -319,7 +319,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>   	if (status&  MCI_DATABLOCKEND)
>>   		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
>>
>> -	if (status & MCI_DATAEND) {
>> +	if (status & MCI_DATAEND
>
>    Shouldn't 'status & MCI_DATAEND' be enclosed in parens?

No.  Only people who don't want to know operator precedence enclose
everything in parens.  Here's the grammar:

logical-OR-expression:
               logical-AND-expression
               logical-OR-expression || logical-AND-expression
logical-AND-expression:
               inclusive-OR-expression
               logical-AND-expression && inclusive-OR-expression
inclusive-OR-expression:
               exclusive-OR-expression
               inclusive-OR-expression | exclusive-OR-expression
exclusive-OR-expression:
               AND-expression
               exclusive-OR-expression ^ AND-expression
AND-expression:
               equality-expression
               AND-expression & equality-expression

So, a & b || c gives:

logical-OR-expression := a & b || c
+-logical-OR-expression := a & b
| `-logical-AND-expression := a & b
|   `-inclusive-OR-expression := a & b
|     `-exclusive-OR-expression := a & b
|       `-AND-expression := a & b
|         +-AND-expression := a
|         | `-equality-expression := a
|         `-equality-expression := b
+-logical-AND-expression := c
  `-inclusive-OR-expression := c
    `-exclusive-OR-expression := c
      `-AND-expression := c
       `-equality-expression := c

So, a & b || c is evaluated as ((a) & (b)) || (c), which is exactly what
we want it to be.

If it were && and ||, then there is reason to use parens as people often
get the relative precedence of && and || mixed up.

If you insist on putting parens around a & b there, then for the sake of
consistency, you should be putting parens around every sub-expression
involving || and && - as if you think that a & b || c could be incorrectly
evaluated, a < b || c falls into exactly the same category, as does
a < b || c < d.
