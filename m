From: eric@eukrea.com (Eric Benard)
Date: Fri, 25 Feb 2011 22:29:16 +0100
Subject: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
	and	card detection
In-Reply-To: <874o7r29oa.fsf@lebrac.rtp-net.org>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>	<87k4gp3bl1.fsf@lebrac.rtp-net.org>
	<4D66AAE4.4000308@eukrea.com> <874o7r29oa.fsf@lebrac.rtp-net.org>
Message-ID: <4D681F2C.20307@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/02/2011 20:31, Arnaud Patard (Rtp) wrote:
> Eric Benard<eric@eukrea.com>  writes:
>> may you please test the attached patch. It may give someone with a
>> better knowledge of sdhci than me an idea of what is wrong.
>
> I've tested this patch on my efikamx and this patch does solve the
> issue. I didn't test on the efika smartbook but I guess it'll be fine
> here too. Thanks.
>
good. Now we have to find can how this code be integrated properly in the 
sdhci driver.
>>
>> Here are the workaround this patch add :
>> - we can't let enable or disable irq enabled when the card is
>> present/not present, else the irq triger again which explains why you
>> get the freeze ->  so we must rely on the card presence bit to enable
>> the right interrupt,
>
> so, we're getting an interrupt storm, right ? can't it be fixed by
> setting a different irq type ?
>
no this seems to be the way the SDHCI works, at least the i.MX51 ref manual says :
- When the CRM bit is cleared, if no card is inserted it is immediately set 
again: this can be prevented by clearing the card removal status enable bit in 
interrupt status enable register.
- When the CIN bit is cleared, if a card is inserted it is immediately set 
again: this can be prevented by clearing the card inserted status enable bit 
in interrupt status enable register.

As, unless I'm mistaken, sdhci host actually consider card detect as broken by 
default, I think this code in not actually used so it may not be really tested.

>> - we can't turn the clock off if we want the card detect to work when
>> the card is removed ->  as a quick workaround this patch prevents
>> sdhci_set_clock from turning off the clocks when the
>> SDHCI_INT_CARD_INSERT interrupt is enabled.
>>
>> Also, I had to change the MX51_PAD_GPIO1_0__SD1_CD pad setting as
>> follows to enable the internal pull up :
>> 	_MX51_PAD_GPIO1_0__SD1_CD | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
>> 			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
>> 			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
>
> It worked without changing this.
>
this could mean you have an external pull up resistor on the board which was 
not the case on the prototype I was working on which is partially mounted ;-)

Eric
