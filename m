From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 2 Dec 2010 21:39:25 +0100
Subject: [PATCH] mmci: corrected calculation of clock div for ux500
In-Reply-To: <20101202174550.GJ29347@n2100.arm.linux.org.uk>
References: <1291308678-15497-1-git-send-email-linus.walleij@stericsson.com>
	<20101202174550.GJ29347@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinFwDzz1HJCkJGjS=yy1g2k0EuHqszwirxySiKv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Dec 02, 2010 at 05:51:18PM +0100, Linus Walleij wrote:
>> From: Ulf Hansson <ulf.hansson@stericsson.com>
>>
>> The Ux500 variant of this block has a different divider.
>> The value used right now is too big and which means a loss
>> in performance. This fix corrects it.
>
> Err.
>
>> + ? ? ? ? ? ? } else if (variant->st_clkdiv) {
>> + ? ? ? ? ? ? ? ? ? ? clk = ((host->mclk + desired - 1) / desired) - 2;
>> + ? ? ? ? ? ? ? ? ? ? if (clk >= 256)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? clk = 255;
>> + ? ? ? ? ? ? ? ? ? ? host->cclk = host->mclk / (clk + 2);
>
> This causes the divider to be selected for the 'nearest' frequency.
> You are not allowed to _exceed_ the desired frequency - you must
> always round down.

I don't get it because what we try to do is round the divider
up so the divided result will be rounded down... Is it the -2
part that confuse things? That is just a constant from the
datasheet. (Some default divider offset.)

I rewrote the patch using DIV_ROUND_UP() and expanded
the maths from the datasheets so I properly understand it
myself, is this better:
