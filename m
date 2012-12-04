From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 4 Dec 2012 15:01:39 +0800
Subject: [PATCH 1/4] rtc: sa1100: enable/disable rtc when probe/remove the
 device
In-Reply-To: <CADApbegRJO+CJJYotP9vL4-kp5qmf4OZEzmqFAR6xu5yhRReFA@mail.gmail.com>
References: <1354155670-6267-1-git-send-email-chao.xie@marvell.com>
 <20121129102519.GG19440@n2100.arm.linux.org.uk>
 <CAN1soZxUA2PPy4694ByX1FTyWiJkha8QpKFK5Jc3Wf3zT0huOA@mail.gmail.com>
 <CADApbejZXach=YaiL5rEWA5+uc+mO8PzQzUKN+k90HfxEsqgtA@mail.gmail.com>
 <CADApbegrJDe5SiO255WdKYai1U7WjBYfMHuCm-hTNfx5p6Wz-Q@mail.gmail.com>
 <20121203094828.GA14363@n2100.arm.linux.org.uk>
 <CADApbegRJO+CJJYotP9vL4-kp5qmf4OZEzmqFAR6xu5yhRReFA@mail.gmail.com>
Message-ID: <CAN1soZzP5nH31teq3bZ2sXgnPimjvDZ8rEO6J01XbigowUQHvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 4, 2012, Chao Xie wrote:
>
> On Mon, Dec 3, 2012 at 5:48 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Dec 03, 2012 at 10:53:07AM +0800, Chao Xie wrote:
> >> I want to correct what i said. For the irq register/unregister i think
> >> can be done at open/release. But for clock enable/disable, i do not
> >> think so. If clock is disabled, as i think RTC will not work. User API
> >> still use open->get_time->close for "date" command. It means that RTC
> >> will not return correct date to user.
> >
> > "I think" is not good enough for patches like this.  Please test it.
> >
> > On SA11x0 and PXA platforms, the clock for the sa1100-rtc is a dummy
> > clock; it has no effect.  For MMP, I don't have access to the TRMs so
> > that's something you're going to have to find out.
>
> I tested at pxa910 which uses rtc-sa1100 as driver.
> the test procedure is simple
> open->ioctl(RTC_RD_TIME)->close
> With the original code, the rtc will not update, i always get the same value
>
> remove clock disable/enable in release/open, and enable/disable clock
> at probe/remove.
> the rtc can update, and i can read the correct rtc value.

Yes, clock shouldn't be controlled in open/close. Otherwise, RTC can't
work since
clock is already gated. I didn't find the issue since there're two RTC
enabled in my
board. The default one impacts the test.

I think that you need send the patch that only move clock operation
into probe().
