From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 21 Sep 2017 17:20:40 -0600
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170921224541.GC20805@n2100.armlinux.org.uk>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
 <20170921075907.GR20805@n2100.armlinux.org.uk>
 <20170921093218.GS20805@n2100.armlinux.org.uk>
 <20170921220510.GA11395@obsidianresearch.com>
 <20170921224541.GC20805@n2100.armlinux.org.uk>
Message-ID: <20170921232040.GA15130@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 11:45:41PM +0100, Russell King - ARM Linux wrote:
> > I've combined several of your messages together into this reply...
> 
> Sorry about that, I'm currently ill and sleep deprived, so it's been
> a struggle to pick up on everything together.

No worries, your replys were easy to follow, thanks

> > So with v2 of this patch, the driver would specify positive 1s, and
> > then the set will be called when tv_nsec == 0, but the tv_sec will
> > be +1.
> > 
> > Similarly the existing case of 0.5s offset will work more like
> > before, where it will be called with tv_nsec == .5s and the tv_sec
> > will be +1 - before I think this happened reliably 'by accident' due
> > to the rounding.
> 
> It seems to mean (from reading the code) that I'd need to specify
> -470ms for the PCF8523, if I'm understand what you're saying and
> the code correctly.

Okay.. but I guessed a negative number is probably not what most RTCs would
want, eg a positive number would compensate for delays executing an
I2C command, assuming the RTC zeros its divider when it sets the time.

> I should point out, however, that I'm running a modified version
> of your previous patch with 470ms specified - I added a debug
> printk() for the failure cases, and I seem to be getting quite a
> number:
> 
> [  416.966909] rtc_tv_nsec_ok: fail: ts=1506001533.510194975

> then that means we only waited 329s before we next tried to set the
> RTC, not the 11 minutes that we should have.  Not sure yet what's
> going on there, but it seems to suggest that we're struggling to
> set the RTC, taking multiple attempts to achieve it.

Ah..

> Also... don't we want to move the call to rtc_set_ntp_time() from out
> of the "if (abs(now.tv_nsec - (NSEC_PER_SEC / 2)) <= tick_nsec * 5) {"
> check, otherwise how could it be called except at about .5s?

Yes, definitely. If we do not call through to rtc_set_ntp_time then it
does not update target_nsec, and we go back to the 0.5 offset not the
offset you want, which will certainly cause random rtc_tv_nsec_ok
failures.

My bad to not notice that.. But I'm not sure what the revision should
be.. I think this is using tick_nsec similarly to TIME_SET_NSEC_FUZZ,
but I'm not sure where tick_nsec comes from or if we should push it
down in to TIME_SET_NSEC_FUZZ, or something else.

> I'm actually not sure if we are ending up setting the time - my test
> program reports:

Probably not, given the above!

Jason
