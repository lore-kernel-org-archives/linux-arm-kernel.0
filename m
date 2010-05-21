From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 21 May 2010 14:32:01 +0200
Subject: [PATCH 2/5] mxc_nand: fix PM
In-Reply-To: <19446.29016.956006.230105@ipc1.ka-ro>
References: <1274440363-435-1-git-send-email-eric@eukrea.com>	<1274440363-435-2-git-send-email-eric@eukrea.com>
	<19446.29016.956006.230105@ipc1.ka-ro>
Message-ID: <4BF67D41.1020204@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

Le 21/05/2010 13:41, Lothar Wa?mann a ?crit :
>> -	if (mtd) {
>> -		/* Enable the NFC clock */
>> +	if (!host->clk_act) {
>>   		clk_enable(host->clk);
>> -		mtd->resume(mtd);
>> +		host->clk_act = 1;
>>   	}
>>
> Since you are clearing host->clk_act during suspend, this will
> unconditionally enable the clock no matter what state it had before
> suspend (in case that's intended, the check for !host->clk_act is
> useless, since it will always yield true).

Yes, you're right.
In fact, the clock is turned on & off by mxc_nand_select_chip so when 
clk_enable & clk_disable are called in suspend & resume without checking 
it the clock is already active, I had log complaining for the clock 
already being off as mxc_nand_select_chip hard already turned it off, so 
I put the checks in both functions.

 > I think it's more sensible to leave host->clk_act alone, and reenable
 > the clock only if host->clk_act is set, so that the clock is left in
 > the same state after resume in which it was before suspend.
 >
OK I'll try this. In fact, I think the clock is always off when we reach 
suspend & resume as nand_base has already deselected the chip and thus 
the NFC's clock is turned off.

While we're at this : is there a good reason to select/deselect the chip 
at every access and turn on/off the clock at the same time ?

Eric
