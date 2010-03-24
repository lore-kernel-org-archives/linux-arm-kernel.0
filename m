From: andy@warmcat.com (Andy Green)
Date: Wed, 24 Mar 2010 12:29:41 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <20100324121930.GD5831@opensource.wolfsonmicro.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<20100324102144.GA21935@rakim.wolfsonmicro.main>
	<005401cacb41$821d46f0$8657d4d0$%szyprowski@samsung.com>
	<20100324110820.GA5831@opensource.wolfsonmicro.com>
	<4BA9F724.8070901@warmcat.com>
	<20100324121930.GD5831@opensource.wolfsonmicro.com>
Message-ID: <4BAA05B5.9000800@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/10 12:19, Somebody in the thread at some point said:

(snipped what's covered elsewhere)

> For the bus controller itself there's a much more general issue which
> most platforms resolve by either using the _noirq suspend operations,
> not suspending at all (on some platforms there's just not anything to
> do), or suspending as part of the arch suspend work.  I2C tends to be
> used in enough applications that cause sequencing issues that this is
> required anyway and has often been solved before anyone tries to use
> software controlled regulators.

I dunno what that solution looks like but I doubt it's very pretty.  I 
have several times seen "other driver is in suspend" flags that defeat 
the operation if so, then there is unpredictable behaviour (even if some 
deadlock is avoided).

If the devices are explicit children of the PMU then there can never be 
a race about doing i2c-based activity that the PMU relys on.

> Note also that the suspend and resume ordering flow from the ordering
> with which things appear at system startup so solving the problem at
> startup tends to mean you've coped with things well enough.  See the
> thread on allowing us to explicitly specify interdependencies for the
> device graph that occurred during the last release cycle for Linus'
> analysis of this.

Yeah I agree totally, but to enforce the system startup order in a solid 
way it's also needed to have probe callbacks.

>> To do that, you need a post-PMU-probe callback into the machine
>> file, or some even nicer API arrangement you're in a good position
>> to invent :-)
>
> This isn't really regulator specific, it's a generic problem that
> affects other areas too (this sort of multi-chip arrangement is hardly
> unusual in embedded cases, and I understand there are some similar
> issues on PCs) and the regulator API doesn't have the information to
> deal with anyway.  You're really looking for something at the device
> core level here.

That's right, you just reminded me of another non-PMU race where 
framebuffer device raced on LCM controller chip driver suspend, and IIRC 
framebuffer device again raced on backlight which raced on PMU 
availability to set the level.

All of that nightmare dispersed into order once the device hierarchy was 
set properly (which required probe callbacks at init-time).

So I think you have it correct, some kind of generic probe callback 
allowing init staging and parent setting would solve everything.

-Andy
