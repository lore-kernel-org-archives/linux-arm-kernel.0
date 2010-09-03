From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Fri, 3 Sep 2010 13:49:00 +0200
Subject: [PATCH 2/3] plat-nomadik: Added suspend/resume support for MTU
	timer.
In-Reply-To: <AANLkTikTuuVGnOstk+YGq3R9pwrMT-qwkbo7CXMJ4NB6@mail.gmail.com>
References: <AANLkTikTuuVGnOstk+YGq3R9pwrMT-qwkbo7CXMJ4NB6@mail.gmail.com>
	<1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>
	<1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
	<20100902160443.GR26319@n2100.arm.linux.org.uk>
Message-ID: <20100903114900.GA3495@morgana.i.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus about the prescaler on the Nomadik MTU:
> That comes from Alessandros oneshot mode a while back actually,
> Jonas is only factoring it around.

Yes. 8815 has 2.5MHz and the U8500 had 110MHz according to this line:

>>> -      * Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:

Now changed to:

>>> +      * Tick rate is 2.4MHz for Nomadik and 100 or 133MHz for ux5

So I chose to add a prescaler if the frequency is too high. A
non-prescaled 110MHz overflows in 39 seconds.  But the threshold is
subjective.  I think I choise ~16MHz to have no more than 1usec per
tick, for timeevent precision.

Russell:
>> n << 20 doesn't give you MHz, so this code doesn't match the comments.
>> Do you mean 16MHz or 16.777216MHz ?

Well, it's not really important which one. But the comment is wrong,
my fault.

> Alessandro why do we kick in a prescaler if rate > (16 << 20)?
> Seems weird to me too when I look at it, more like it'd be
> if rate (1 << 20) which makes sense, if the counter will flip
> around 20 bits in 1 second we prescale it by 16.

Your "makes sense" is as subjective as mine. But on 8815, with 2.4MHz
we overflow in around 1790 seconds. I feel it reasonable. If you
prescale we get at 150kHz, which is 6.6 usec per tick: I don't like
that figure too much.

/alessandro
