From: eric@eukrea.com (Eric Benard)
Date: Thu, 24 Feb 2011 20:00:52 +0100
Subject: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
	and	card detection
In-Reply-To: <87k4gp3bl1.fsf@lebrac.rtp-net.org>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
	<87k4gp3bl1.fsf@lebrac.rtp-net.org>
Message-ID: <4D66AAE4.4000308@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On 24/02/2011 12:40, Arnaud Patard (Rtp) wrote:
> Wolfram Sang<w.sang@pengutronix.de>  writes:
>
> Hi,
>
>> Take #3, changes:
>>
>> * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
>> * remove unconditional BROKEN_CARD_DETECTION (leftover)
>> * improved kernel-doc about unused GPIO
>> * added tags from Eric
>>
>> Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
>> chance to retest on mx51? What about the FSL guys? :)
>
> I'm getting a hard freeze on my efika sb and mx once I remove the
> unconditional BROKEN_CARD_DETECTION flag. I'm still investigating the
> issue. I'll keep you informed if I find something.
>
may you please test the attached patch. It may give someone with a better 
knowledge of sdhci than me an idea of what is wrong.

Here are the workaround this patch add :
- we can't let enable or disable irq enabled when the card is present/not 
present, else the irq triger again which explains why you get the freeze -> so 
we must rely on the card presence bit to enable the right interrupt,
- we can't turn the clock off if we want the card detect to work when the card 
is removed -> as a quick workaround this patch prevents sdhci_set_clock from 
turning off the clocks when the SDHCI_INT_CARD_INSERT interrupt is enabled.

Also, I had to change the MX51_PAD_GPIO1_0__SD1_CD pad setting as follows to 
enable the internal pull up :
	_MX51_PAD_GPIO1_0__SD1_CD | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),

Eric
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mx51_sdhci_cd_fix.patch
Type: text/x-patch
Size: 2488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110224/e118ff7a/attachment-0001.bin>
