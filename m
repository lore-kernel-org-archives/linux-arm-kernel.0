From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 May 2015 22:56:15 +0100
Subject: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
In-Reply-To: <CAHrpEqSngMgOj5Bjp0XWpw9CJCjoiU63iRuAX3Zw_aEO+-5RHg@mail.gmail.com>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
 <20150520015851.GB1071@dragon>
 <20150520182540.GQ2067@n2100.arm.linux.org.uk>
 <20150520183050.GR2067@n2100.arm.linux.org.uk>
 <CAHrpEqSngMgOj5Bjp0XWpw9CJCjoiU63iRuAX3Zw_aEO+-5RHg@mail.gmail.com>
Message-ID: <20150520215615.GZ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 01:44:58PM -0500, Zhi Li wrote:
> On Wed, May 20, 2015 at 1:30 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Looking at the RTC code, it would be pretty trivial to do.
> >
> > Rather than passing around struct regmap, pass around the private data
> > structure.
> >
> > Rename the regmap_* function calls to be private accessors.  Implement
> > a set of new accessors - if the private data has the regmap, use the
> > regmap API.  Otherwise, use the old method, and print a warning that an
> > old DT is being used.
> 
> This method work.  But code will become ugly and complex. I seach
> whole dts tree.
> Only imx6 use this driver.
> 
> Does it really valuable to keep compatiblity with cost of complex driver code?

Let me put this a different way.

Would you be upset if you installed a new kernel, rebooted and found that
the system then fscked your filesystem, stamping a date of 1 Jan 1970
on it.  Then you use a later dtb, and you have to go through another
fsck of your filesystem because it's apparently been more than "31 days"
or so since it was last fscked, and all this caused by the RTC vanishing
because we couldn't be bothered with backward compatibility?

There are real products out there which use iMX6 today.  In production,
being sold.

Do not break existing DTBs unless there really is no other choice.

And I don't think it makes the code ugly, though it does make it _slightly_
more complex.  That's a price worth paying for keeping stuff working.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
