From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 2 Oct 2009 06:10:15 +0200
Subject: 2.6.32-rc1: spitz boots but suspend/resume is broken
In-Reply-To: <bc64b4640909300509p6c682fa8rb5ce43c77c79f5@mail.gmail.com>
References: <20090930120655.GG1412@ucw.cz>
	<bc64b4640909300509p6c682fa8rb5ce43c77c79f5@mail.gmail.com>
Message-ID: <20091002041015.GB1409@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-09-30 16:09:25, Dmitry Eremin-Solenikov wrote:
> On Wed, Sep 30, 2009 at 4:06 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > matrix keyboard driver needs to be enabled, otherwise it seems ok.
> >
> > Unfortunately, it does not respond to power button in any visible way
> > :-(. Any ideas what might be wrong/how to debug it?
> 
> Enable gpio-keyboard driver, verify (or port power button to it :))
> and check that
> enable_wakeup is enabled.

It seems neccessary tables for gpio-keyboard just are not there :-(.

In the meantime, this allows easy switch to known-good driver. (Can we
get it upstream until problem is fixed properly?)

Unfortunately, that still does not fix suspend/resume. (Does it work
for you?)

> BTW: on tosa initially i had a problem w/ wakeup. The power button wasn't
> able to wake the device up. However there was another gpio that was OR of
>  power button and AC-in gpios that had to be used for wakeup. Please check
> if the same design applies to your device.

Well, it all worked in 2.6.31. How do I check it?

								Pavel
---

Switch back to known-good keyboard driver. The new one does not
support power key, making suspend unusable.

This actually fixes regression from 2.6.31 (power key now works) but
not suspend/resume regression (will have to hunt more).

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff -ur linux-rc/arch/arm.ofic/mach-pxa/spitz.c linux-rc/arch/arm/mach-pxa/spitz.c
--- linux-rc/arch/arm.ofic/mach-pxa/spitz.c	2009-09-28 12:09:26.000000000 +0200
+++ linux-rc/arch/arm/mach-pxa/spitz.c	2009-09-30 22:27:43.000000000 +0200
@@ -367,7 +367,8 @@
 };
 
 static struct platform_device spitzkbd_device = {
-	.name		= "matrix-keypad",
+  //	.name		= "matrix-keypad",
+	.name		= "spitz-keyboard",
 	.id		= -1,
 	.dev		= {
 		.platform_data = &spitzkbd_pdata,


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
