From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 31 Aug 2018 23:30:31 +0200
Subject: [rfc] leds: add TI LMU backlight driver
In-Reply-To: <ec7c9624-c1c3-df35-3593-704ac1dc9a4d@ti.com>
References: <20180829212032.GB15786@amd>
 <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com>
 <20180830201825.GA1936@amd>
 <ec7c9624-c1c3-df35-3593-704ac1dc9a4d@ti.com>
Message-ID: <20180831213030.GA23447@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Aha. I did not realize that was for same hardware... I should have
> > cc-ed you, I guess.
> 
> No worries Jacek cc'd me.

Good.

> >> I do not like this driver.
> >> I don't like that it smashes numerous devices into some structure with varying register maps.
> >>
> > 
> > Can you elaborate? The chips are similar enough that single driver
> > makes sense, and we certainly want to maintain one driver, not 6
> > drivers differing only in .. what exactly?
> 
> Well I think it is justified to have independent drivers as each device has different features from
> this basic LED driver.  If we are just looking for basic support then yes this driver is fine.

> But here is where a single driver will start getting messy and support difficult
> 
> LM3533 has ALS and an ADC for an ALS analog sensor
> LM3631 has no ALS functionality
> LM3632 has strobe functionality and no ramp support
> LM3633 has indicator support coupled with the hvled support
> LM3695 does not even appear to be available publicly
> LM3697 is the only device that that this driver could be used for as is.

Ok, so ... yes, I'm really interested in basic support. But drivers
seem to have a lot in common, voltage limits, for example. 

> In addition if I wanted to only support a single device I have to pull in the full data
> file that defines all the other devices.  That is pretty bad to increase the size of the kernel
> image to have support for devices that are not even on the target product.  The ti-lmu data file
> alone is ~15k, the ti-lmu code does not even build with this patch (So this is a nack on the patch as it is.)
> but commenting out the offending code gives me at least ~23k more data on top
> of the ti-lmu MFD framework which is ~33k.  That is ~71k of code just to support 1 LED device
> that is 3x what we have now.  That is not good for IoT devices.

> The LM3697 is 22k without ramp support.

Well, I don't think object file size is huge problem. First,
"distribution" kernel with support for 6 different chips will be ~71k,
while your proposal will result in ~136k. Second, yes, we could put
ifdefs into ti-lmu data file to make it smaller.

Anyway, clean source code and easy maintainance is more important.

> 
> And I will continue. TI LMU really means nothing unless you know what LMU stands for.  But this
> also now implies support for all of TI's lighting products which will confuse the heck out of
> customers and TI support staff.  We have a similar issue in our SoC sound CODECs code that we are
> attempting to clean up.  We have a generic driver that is supposed to support a common set of features
> but when extending support for other features the code gets very complicated and it is almost more
> beneficial to re-write and create a new driver.
> 
> I would be OK with creating a ti-lmu framework that commonizes the functionality and create children that
> register to that framework but even that is over kill.
>

I believe there's quite a lot of code that could be shared. 

> >> Not only that but it appears that you just pulled this driver from a repo and posted it without clean up.
> >>
> > 
> > a) No I did not, feel free to generate a diff.
> > 
> 
> No I looked at this driver before and determined a re-write was a waste of time.
> If you look that the LM3697 driver I submitted it configures the banks via the config file.
> 
> Only the ramp code is missing and the code is much simpler in nature.  We could adopt that
> code to extend out to the other devices as well and base the register map deltas on the 
> device configuration file.  I am already using the fwnode calls and setting up the banks.

Well, you may know that hardware better than I do. But if you generate
a diff...

> > b) Even if I did, why would that be a problem?
> 
> So what you are saying is all I have to do is look for other peoples work pull it in to a branch
> slap a new copyright on it, push to a list and claim support?

...you'll see I did quite some changes.

> I don't think you checked with the original author on pushing it upstream.  Milo has not updated
> his email with a public one unless you sent him a private email and received and ack on pushing
>

Tony Lindgren asked me to get support merged, and that's what I'm
trying to do. I have Milo's sign off, that means he is/was ok with
upstreaming that code; no, I did not have reason to contact him.

> > Well all 6 chips this driver supports seem to be similar enough, so
> > that single driver makes sense.
> 
> See above on device differentiation. So in my opinion a single driver that supports
> basic functionality is good but when adding additional support this driver will get very
> complicated as to only allow different features for different devices.

Well, the devices seem to have quite a lot in common. Yes, single
driver for all of them will be somehow complex; but I believe that's
still better than copy&pasting code.

Anyway, I showed my proposal. I need support for ti,lm3532, but I can
get basic support for many other chips with very little code.

Do you plan basic support for support other chips in near future? Is
TI willing to maintain the LED drivers?

What is your proposal for lm3532 support? Should I just cp lm3697
lm3532, then adjust register map? (Will not that cause rather ugly
code duplication?)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/a34a33d9/attachment.sig>
