From: andy@warmcat.com (Andy Green)
Date: Wed, 02 Dec 2009 21:13:05 +0000
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <37367b3a0912021225l67455ca2q2c7d0464279f446e@mail.gmail.com>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>	
	<37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>	
	<4B16C185.80905@warmcat.com>
	<37367b3a0912021225l67455ca2q2c7d0464279f446e@mail.gmail.com>
Message-ID: <4B16D861.6090307@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/09 20:25, Somebody in the thread at some point said:

Hi Alan -

>> What did you do with your chip select line on the ULPI PHY?
>
> I turn this line (CS_N) low before initializing ISP1504.

It's more a question about what that input on the PHY chip sees during 
powerup / reset... it needs to be nicely and definitely high the whole 
time so it will ignore what happens then.  Is it pulled up, or just 
connected to the iMX GPIO?  iMX GPIO alone may not be enough.  They 
mostly default to 100K pullup but even that may not be enabled early in 
the powerup action.

A 10K to your IO voltage rail on CS_N solved it for the LiteKIT and on 
the boards we have made.

>> The first iMX LiteKIT board I had was an old revision where they had
>> tied the PHY chip select pin asserted.  The ULPI PHY acted braindamaged
>> because glitchy junk from during poweron / reset was taken as real data
>> and it never recovered during the session.
>>
>> Later versions of the LiteKIT changed this to be pulled deasserted and a
>> GPIO can drive it asserted after reset is all done.  After I got a later
>> revision with that mod, and drove the GPIO, suddenly all was well.
>
> I was thinking it could be some hw issues, but this is not, because
> using old kernel everything works fine.

OK.

But on the old LiteKIT where it was tied low, it was erratic: worked 
sometimes and not others depending on the random details of what went 
where in what order during powerup each time.  If you didn't see it work 
on this older kernel over a bunch of powercycles keep the idea in a back 
pocket :-)

-Andy
