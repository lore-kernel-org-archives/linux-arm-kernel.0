From: andy@warmcat.com (Andy Green)
Date: Thu, 25 Mar 2010 10:52:06 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <20100325102232.GC27729@rakim.wolfsonmicro.main>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<4BA9D93E.50705@warmcat.com>
	<20100324113241.GC5831@opensource.wolfsonmicro.com>
	<4BAA017D.70503@warmcat.com>
	<20100324140101.GC26453@rakim.wolfsonmicro.main>
	<4BAA23E7.9010100@warmcat.com>
	<20100325102232.GC27729@rakim.wolfsonmicro.main>
Message-ID: <4BAB4056.4090503@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/10 10:22, Somebody in the thread at some point said:
> On Wed, Mar 24, 2010 at 02:38:31PM +0000, Andy Green wrote:
>> On 03/24/10 14:01, Somebody in the thread at some point said:
>
>>> I really am very sure that nobody has ever reported any issues here -
>
>> There's plenty of out-of-tree code.  I'm not trying to blame you for
>
> I'm really wary of trusting out of tree reports since a high proportion
> of the time they turn out to be due to people not being aware of some
> existing support or things like API misuse.  New issues do crop up, but
> anecdotes about issues that have been diagnosed but not reported need to
> be taken with a grain of salt.

I can see your point of view, but you sound...

> Like I say, the regulator drivers just don't do anything in suspend
> in mainline which means that ordering issues from them seem a bit
> suspicious.

The I2C bus goes down at some point in suspend, then you can't talk to 
the PMU or other I2C device any more.

If there are other drivers that are trying to do something themselves 
their power when they go down, or indeed ask for anything else from 
another driver who is on a separate bus and they don't have any formal 
relationship with it hierarchy-wise, then it's racing with the other 
driver or the bus going down.

In that case, those drivers who want to ask for things in suspend or 
resume, or who trigger indirectly those requests at that time, need to 
mark themselves as being dependencies of the thing they're reliant on 
talking to.  Then everything is taken care of.

GTA02 had a bunch of these kind of relationships... it's possible they 
were all evil and could be eliminated but actually framebuffer vs LCM 
controller vs PMU vs backlight driver race I dunno what else you're 
meant to do except make the relationship explicit and everything is 
cool.  Backlight really is dependent on PMU being there if it wants to 
change state while it goes down (eg, fade down itself), correct thing 
really does seem to be make the dependency explicit via the device 
parent stuff.

If you have a better way, I am standing by ready to learn something.

-Andy
