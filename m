From: jm@lentin.co.uk (Jamie Lentin)
Date: Mon, 29 Oct 2012 22:47:57 +0000 (GMT)
Subject: [PATCH] ARM: kirkwood: Increase NAND chip-delay for DNS-320
In-Reply-To: <20121029064632.GJ15143@lunn.ch>
References: <1351457262-11506-1-git-send-email-jm@lentin.co.uk>
 <20121028205956.GH15143@lunn.ch>
 <alpine.DEB.2.00.1210282123250.10589@marmot.wormnet.eu>
 <20121029064632.GJ15143@lunn.ch>
Message-ID: <alpine.DEB.2.00.1210292156240.10589@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Oct 2012, Andrew Lunn wrote:

>> The chip markings are: SAMSUNG 146 K9F1G08U0D SCB0 (FKJ554PWN)
>>
>> Unfortunately the other NAS is too far away to get at, but D-link
>> haven't stuck to exactly the same chip. This DNS-320 review shows a
>> different Samsung part:
>>
>> http://diit.cz/data/images/thumb/67491_2b9e5e4fbd.jpg?1307884464
>>
>> The datasheet for the K9F1G08U0D says max 35usecs "Data Transfer
>> from Cell to Register", whereas K9F1G08U0C (what the DNS-320 review
>> shows) says 25usecs. If this is the value in the datasheet to check,
>> then this would explain the problems.
>
> Seems sensible.
>
> I'm currently downloading the GPL sources from dlink. If the kernel
> sources are included, we can see how dlink sets this. If its also 35,
> then there is no argument.

Rummaging myself, my best guess is:

linux-2.6.22.18/arch/arm/mach-feroceon-kw/nand.c
173:    this->chip_delay = 30;

u-boot-1.1.4/board/mv_feroceon/USP/mv_nand.c
68: nand->chip_delay = 30;

However, this is too fast for my NAS when using a mainline kernel. 31usecs 
seems to work though. It's probably worth noting that the original 
firmware wasn't without it's problems on this particular board---I 
couldn't get it to reflash the NAND with a new firmware image. It could 
certainly read the NAND though.

This chip_delay value seems to be there in both the DNS320 and DNS325 GPL 
source. Maybe increasing chip_delay for both would be safest.

> The only thing you could think about is probing the nand device, and
> if it is not K9F1G08U0D put the delay back to 25.

That would be good, although the challenge will be a neat place to hang 
the code.

>
>   Andrew
>

-- 
Jamie Lentin
