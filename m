From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 04 Dec 2009 18:30:37 +0100
Subject: [PATCH] mx31moboard: fix typo
In-Reply-To: <Pine.LNX.4.64.0912041013380.3981@axis700.grange>
References: <20091203193034.GD22533@pengutronix.de>
	<20091203193321.GE22533@pengutronix.de>
	<Pine.LNX.4.64.0912041013380.3981@axis700.grange>
Message-ID: <4B19473D.7010801@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guennadi Liakhovetski wrote:
> On Thu, 3 Dec 2009, Robert Schwebel wrote:
> 
>> On Thu, Dec 03, 2009 at 08:30:34PM +0100, Robert Schwebel wrote:
>>> Currently, linux-next breaks due to a typo introduced in commit
>>> 33c4d91928bea4444b067e620496befbeb87029c
>>>
>>> This patch fixes it.
>> But something else must be missing, I still get this:
> 
> ...to second that, yesterday's next also locks up hard on boot on pcm037. 
> .config available on request.
> 

Same problem here. As a matter of fact, it comes from the mxc-master 
branch. I have bisected out the culprit:

http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=52939c03e53b151848da9e83fd839bddfda29e78

It seems conform with the lock syndrom: very early at boot right after 
Uncompessing Linux and before any other message.

The proc stalls on this read:
srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);

Maybe Guennadi and I have silicon revisions that do not work well with 
this patch (because I assume it worked well for Daniel).

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
