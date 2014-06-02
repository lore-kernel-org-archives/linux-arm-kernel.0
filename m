From: jwerner@chromium.org (Julius Werner)
Date: Mon, 2 Jun 2014 10:15:36 -0700
Subject: [PATCH 1/2] ARM: dts: Enable USB 3503 hub on exynos5250-snow
In-Reply-To: <CAFp+6iFbDfWconRZzMhSXFG_RbXF-rnYwraJK1P1tQSb6R+Dkw@mail.gmail.com>
References: <1399293056-17143-1-git-send-email-gautam.vivek@samsung.com>
 <536BA9E8.2030306@suse.de> <536BAD05.9070401@samsung.com>
 <CAODwPW8FpsF6vo5Z8_+YXwchwab=7Ltv0nEvP_=907HK232xCg@mail.gmail.com>
 <CAFp+6iFbDfWconRZzMhSXFG_RbXF-rnYwraJK1P1tQSb6R+Dkw@mail.gmail.com>
Message-ID: <CAODwPW9Qkem9OGjVn+EkxvWa5SKWBn=9oG+rvLv9tZVJ=UWx4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Ok, there was already a patch posted by you for this[1], which had
> quite a much discussion
> on it.
> Would you like to give some pointers based on that ?
> One that Olof had suggested was to use gpio-reset driver which is yet
> to make to mainline.
> But i think with that too we need to take care of the timing for
> resetting the hub before PHY
> gets reset.

Oh, right, I remember now. Seems like there wasn't much consensus on
how to solve the problem there, and I think I didn't really have time
to work on it any more either.

I think coupling in another driver to reset the device isn't a bad
idea... this could even be usb3503 if you modified it a little, and it
could also address Tomasz' concerns from that thread that the solution
should be extensible to other HSIC devices that need a different reset
sequence. But you need some mechanism to hook the two drivers together
and make sure phy-samsung-usb2 synchronously calls the reset function
at exactly the right point to ensure the timing works right.
