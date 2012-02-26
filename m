From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Feb 2012 15:26:27 +0000
Subject: [PATCH 2/3] ARM: PXA27x: save/restore PWER on suspend/resume
In-Reply-To: <CA+E=qVfyr9FXtwL6kzrDjOoLW7vQTXJPoDrLobnk9NmdTpy25w@mail.gmail.com>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <1330264062-5750-2-git-send-email-anarsoul@gmail.com>
 <20120226142703.GN22562@n2100.arm.linux.org.uk>
 <CA+E=qVfyr9FXtwL6kzrDjOoLW7vQTXJPoDrLobnk9NmdTpy25w@mail.gmail.com>
Message-ID: <20120226152627.GO22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 05:55:09PM +0300, Vasily Khoruzhick wrote:
> 2012/2/26 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Sun, Feb 26, 2012 at 04:47:41PM +0300, Vasily Khoruzhick wrote:
> >> Bootloader can clobber PWER value, so save it state on suspend.
> >
> > What boot loader is this, and why is it being so idiotic? ?Why can't it
> > be fixed?
> 
> I'm using u-boot on this machine...
> Hmm, I've looked throuhg its sources and did not find where it can clobber it.
> But PWER register value is not preserved across suspend for some reason
> (at least bit 0). Maybe it's some conflict with gpiolib? But
> gpio_set_wake() doesn't work
> for me on PXA.

It sounds like some more debugging is required.

I assume that you've done some basic things, such as:

(1) checking the return value of gpio_set_wake()
(2) checking what's going on internally in gpio_set_wake()

Most users of gpio_set_wake() do not seem to check its return value, so
if it fails you'll never know about it except by seeing incorrect values
in PWER.
