From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 Nov 2013 10:43:06 +0100
Subject: [PATCH v3 1/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <CAOQ7t2b4WpH2fpSMC9DbczVSZMSQ=WNyQzoKiJi=r1JD9os-7Q@mail.gmail.com>
References: <1383172738-8206-1-git-send-email-carlo.caione@gmail.com>
 <20131106141357.GQ26440@lukather>
 <CAOQ7t2b4WpH2fpSMC9DbczVSZMSQ=WNyQzoKiJi=r1JD9os-7Q@mail.gmail.com>
Message-ID: <20131108094306.GC26440@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:07:36PM +0100, Carlo Caione wrote:
> > So this means that whenever the time actually has a number of seconds
> > = 0, you just loop over, adding a 500ms delay? That seems pretty
> > inefficient to me.
> 
> I agree. Any suggestion is welcome.
> 
> > Also, what happens if you get two times in a row a number of seconds
> > equals to 0?
> 
> in that case I think that using t <= 2 in the for cycle will solve
> the problem.

I don't see how it actually solves the issue. It just makes it less
likely to happen.

> > This kind of construct seems really really odd, and doesn't the issue
> > you were trying to address.
> >
> > However, this looks like a common issue. Have you looked at the other
> > drivers to see how they are handling it? Maybe Alessandro will have
> > some suggestions as well.
> 
> This portion of the code is taken from the original RTC driver leaked
> from Allwinner.
> Otherwise a better solution could be something like in
> http://lxr.linux.no/linux+v3.12/drivers/rtc/rtc-at91rm9200.c#L114

That sounds much more robust yes.

> > So, that means that the A10 RTC starts a year 1900, and the A20 at
> > year 2010? Why not just put those in your year_offset field directly?
> 
> Agree
> 
> > Why not just busy-wait ? (with a timeout if you really want to).
> 
> because if it fails after 150ms you are almost certainly screwed and
> something is wrong

Hmmm, I'm not sure anymore about the code I was commenting about here
(please try to at least keep the relevant code portions in your
mails), but you can be delayed by 150ms even if nothing went wrong.

And you can always have a timeout while busy-waiting if you want, with
something like
http://lxr.free-electrons.com/source/drivers/spi/spi-mxs.c#L166

> > Isn't the write operation supposed to be done already?
> 
> In theory yes, in practice you cannot be sure. This is also a legacy
> of the old AW's code. I'll investigate more to check if this is really
> useful.

Again, I'm not sure about which part of the code we were talking
about, but I think I recall that there was two similar access in your
drivers, once that was doing what I was commenting about, and the
other didn't. I'm fine with it being required, but if it is, it should
always be required.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131108/99894fbe/attachment.sig>
