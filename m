From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Aug 2011 11:17:11 +0100
Subject: PB1176 broken in -rc1
In-Reply-To: <20110816100906.GA16159@n2100.arm.linux.org.uk>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
	<20110816092615.GC28656@e102144-lin.cambridge.arm.com>
	<CACRpkdbSG=Mnu7QrACn3y3GP-2H4_qT0kR_4C8umCmWc2YCqXQ@mail.gmail.com>
	<20110816095936.GE28656@e102144-lin.cambridge.arm.com>
	<20110816100906.GA16159@n2100.arm.linux.org.uk>
Message-ID: <20110816101711.GF28656@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Aug 16, 2011 at 11:09:06AM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 16, 2011 at 10:59:36AM +0100, Will Deacon wrote:
> > The problem is with earlyprintk because your picking up multiple definitions
> > of DEBUG_LL_UART_OFFSET as a result of basing your config on the defconfig.
> > 
> > Take a look at arch/arm/mach-realview/include/mach/debug-macro.S. I don't
> > think there's an easy way to fix this because it's used so early, even DT
> > can't save us.
> 
> As I keep saying to people, only use the LL debug during _early_ platform
> bring-up.  That's what it's there for.
> 
> Tying earlyprintk into the LL debug stuff has made the LL debug easier to
> use, and therefore easier for people to fall into this trap.  That's not
> the problem of the LL debug stuff, but the problem of its greater exposure.
> 
> So, as the LL debug stuff has this rule, so does earlyprintk.  Only use it
> for early platform bring up and *once* you have a kernel booting through
> to the proper console, disable it *immediately*.
> 
> Anything else will lead you into these pitfalls.

Yup, I agree about the usage of earlyprintk. It would be good if the user
could select the platform on which LL debug will work at config time and
then not have to worry about multiple conflicting definitions of
DEBUG_LL_UART_OFFSET. That way, you know on which platform earlyprintk
will work and don't try to use it on any others.

Will
