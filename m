From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 19 Feb 2014 10:50:49 -0600
Subject: [PATCH] rtc: mv: reset date if after year 2038
In-Reply-To: <20140219001416.45a79767@skate>
References: <1392729966-25394-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218191111.GH31116@joshc.qualcomm.com>
 <20140219001416.45a79767@skate>
Message-ID: <20140219165049.GB31820@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 12:14:16AM +0100, Thomas Petazzoni wrote:
> On Tue, 18 Feb 2014 13:11:11 -0600, Josh Cartwright wrote:
> > On Tue, Feb 18, 2014 at 02:26:06PM +0100, Thomas Petazzoni wrote:
> > > Dates after January, 19th 2038 are badly handled by userspace due to
> > > the time being stored on 32 bits. This causes issues on some Marvell
> > > platform on which the RTC is initialized by default to a date that's
> > > beyond 2038, causing a really weird behavior of the RTC.
> > >
> > > In order to avoid that, reset the date to a sane value if the RTC is
> > > beyond 2038.
>
> > Just so I better understand: is this really a problem that is unique to
> > this particular RTC?  It smells a bit like we're papering over a problem
> > that may exist for other RTCs as well, and if so, is better solved in
> > the core.
>
> I'd say it depends on how the RTC internally encodes the date. Some RTC
> may have an internal date representation that allows to represent dates
> past 2^32 seconds after Epoch, while maybe some RTC do not.
>
> However, it is true that a fairly large number of RTC drivers seem to
> use the bcd2bin() function, which indicates the RTC internally uses a
> BCD representation, which allows to represent dates past 2^32 seconds
> after Epoch.
>
> That being said, I don't think the RTC core has any knowledge of what
> the internal RTC representation of time is, so I don't know how the
> core could fix things up without this information.

Yeah, I agree that with the current state of affairs, the RTC core
doesn't have enough information to be managing this in a central way.
I'm wondering if the RTC core should provide a richer interface for a
driver to provide bounds information, and let the core figure out these
problems.  But that's a question for Alessandro :).

Anyway, could you clarify where the 32-bit assumption is currently being
made?  From my cursory glance at the ioctl/sysfs interfaces, the use of
struct rtc_time looks safe.  Is the real problem in usermode?  What is
"weird behavior" in this case?

Thanks,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
