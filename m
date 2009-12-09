From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Wed, 09 Dec 2009 13:44:50 +0100
Subject: [PATCH] mx31moboard: fix typo
In-Reply-To: <20091204174623.GW14091@buzzloop.caiaq.de>
References: <20091203193034.GD22533@pengutronix.de>
	<20091203193321.GE22533@pengutronix.de>
	<Pine.LNX.4.64.0912041013380.3981@axis700.grange>
	<4B19473D.7010801@epfl.ch>
	<20091204174623.GW14091@buzzloop.caiaq.de>
Message-ID: <4B1F9BC2.6010205@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack wrote:
> On Fri, Dec 04, 2009 at 06:30:37PM +0100, Valentin Longchamp wrote:
>> Guennadi Liakhovetski wrote:
>>> ...to second that, yesterday's next also locks up hard on boot on
>>> pcm037. .config available on request.
>>>
>> Same problem here. As a matter of fact, it comes from the mxc-master
>> branch. I have bisected out the culprit:
>>
>> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=52939c03e53b151848da9e83fd839bddfda29e78
>>
>> It seems conform with the lock syndrom: very early at boot right
>> after Uncompessing Linux and before any other message.
>>
>> The proc stalls on this read:
>> srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);
>>
>> Maybe Guennadi and I have silicon revisions that do not work well
>> with this patch (because I assume it worked well for Daniel).
> 
> Grmpf. Yes, it does work right on my LiteKit board, and the reference
> manual reads like the register is there for a very long time (as it has
> possible values for very old silicon revisions).

Well, there are not a lot of information about the IIM in the reference 
manual (only Tables 13-1 for the different fuses and 13-2 for the 
silicon revisions). I wanted to check for the registers to find maybe a 
problem, but found nothing more

> 
> Could you double check whether the clock is running? The only thing I can
> think of is differences in the bootloaders. I still have the proprietary
> 'losh' running here, which I have no sources for.
> 

The clock is running (well, at least the parent ipg_clk and the gating 
is configured for the clock running, thanks to clk_enable(&iim_clk);

About the bootloader, on our boards we have redboot, adapted from the 
release Freescale did for the ADS. So it may be a bootloader issue. What 
could be missing in my bootloader that makes this read fail ?

I would say that maybe someting the EMI or SPBA configuration is missing 
so that I can access the addresses in this range. Any ideas ?

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
