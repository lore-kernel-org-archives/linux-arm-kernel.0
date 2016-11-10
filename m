From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 Nov 2016 17:29:25 +0100
Subject: PM regression with LED changes in next-20161109
In-Reply-To: <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
Message-ID: <20161110162925.GA28832@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>>Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
> >>>the sysfs brightness attr for changes.") breaks runtime PM for me.
> >>>
> >>>On my omap dm3730 based test system, idle power consumption is over 70
> >>>times higher now with this patch! It goes from about 6mW for the core
> >>>system to over 440mW during idle meaning there's some busy timer now
> >>>active.
> >>>
> >>>Reverting this patch fixes the issue. Any ideas?

Are you using any LED that toggles with high frequency? Like perhaps
LED that is lit when CPU is active?

> >So a user can do "echo 128 > brightness && cat brightness" and
> >get out 0, or 128, depending purely on timing.
...
> >                Reading from this file while a trigger is active returns
> >the
> >                top brightness trigger is going to use.

Yes, that sounds sane.

> It seems that we should get back to your initial approach. i.e. only
> brightness changes caused by hardware should be reported.

I don't think enabling poll() here is good idea. Some hardware won't
be able to tell you that it changed the state. Returning maximum
brightness trigger is going to use seems easier/better.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161110/4ee8fe9c/attachment.sig>
