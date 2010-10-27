From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 27 Oct 2010 18:18:12 +0900
Subject: [PATCH 1/6] rtc: rtc-s3c: Fix access unit from byte to word on
	RTCCON
In-Reply-To: <AANLkTimXee842b+cmi7vy+Dj60SKzyg1Q=NorOmvJg3w@mail.gmail.com>
References: <1286494879-2932-1-git-send-email-kgene.kim@samsung.com>
	<1286494879-2932-2-git-send-email-kgene.kim@samsung.com>
	<AANLkTi=+BH7nJFt5Amz_q=6HAn9STfXjKbCS6jSQeW5y@mail.gmail.com>
	<000401cb75ac$b6eab190$24c014b0$%kim@samsung.com>
	<AANLkTimXee842b+cmi7vy+Dj60SKzyg1Q=NorOmvJg3w@mail.gmail.com>
Message-ID: <000801cb75b7$e35a6c10$aa0f4430$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> On Wed, Oct 27, 2010 at 4:58 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > MyungJoo Ham wrote:
> >>
> >> On Fri, Oct 8, 2010 at 8:41 AM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> >> > From: Changhwan Youn <chaos.youn@samsung.com>
> >> >
> >> > S3C2410_RTCCON of TYPE_S3C64XX RTC should be read/written by
> >> > readw and writew, because TYPE_S3C64XX RTC uses bit 8 and 9.
> >> > And TYPE_S3C2410 RTC also can access it by readw and writew.
> >> >
> >> > Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> >> > [atul.dahiya at samsung.com: tested on smdk2416]
> >> > Tested-by: Atul Dahiya <atul.dahiya@samsung.com>
> >> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >> > Cc: Ben Dooks <ben-linux@fluff.org>
> >> > ---
> >> > ?drivers/rtc/rtc-s3c.c | ? 36 ++++++++++++++++++------------------
> >> > ?1 files changed, 18 insertions(+), 18 deletions(-)
> >>
> >> Hello,
> >>
> > Hi,
> >>
> >> Sorry for a late reply...
> >>
> > Yeah, too late :-(
> >
> >> Anyway, I have a small question in this rtc-s3c.c driver.
> >>
> >> Is there any reason to use read/write b/w to access registers of
rtc-s3c?
> >>
> > See the git comment.
> >
> >> Why don't we use readl/writel when accessing registers in this drivers
> >
> > I don't know why we should use readl/writel for all case...
> > even though we can use just word or byte access.
> >
> >> and just forget which registers require at least 8 or 16 or 32 bits?
> >>
> >> In fact, it appears that readw/writew accesses 16bits, not 32bits in
> >
> > Yes...
> >
> >> ARM machines, which may incur problems with TICCNT(S3C2410_TICNT in the
> code)/CURTICCNT
> >> registers.
> >>
> > I can't get your comment...
> 
> It is because TICCNT and CURTICCNT RTC registers of S5PC210 require
> 32bit access according to the manual while this patch still uses 16bit
> accesses for them.
> 
> Besides, ALMYEAR/BCDYEAR(S3C2410_RTCYEAR) requires at least 16bit access.
> 
> 
> This issue was found today while testing suspend-to-mem with s5pc210
> and rtc-wakeup loop. My guess is that saving and restoring only 8 bits
> of TICNT at suspend/resume function incurred the instable
> suspend-to-mem (kernel hangs with about 1/100 probability) Using
> readl/writel for TICNT solved the kernel hang issue.
> 
I got it.
You mean need to fix readb(TICNT) of s3c_rtc_suspend() and
s3c_rtc_resume()...
Ok...but it's different some kind of bug fix with this patch.
And...need to check side effect to all of Samsung SoCs.

Hmm...and first of all, not supported S5PV310/S5PC210 PM in mainline now.

Anyway if any bug, we can fix it during -rc.
I always welcome to bug fix to our codes. :-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
