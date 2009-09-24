From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 24 Sep 2009 11:54:56 +0300
Subject: Problem with s3c24xx pwm driver
In-Reply-To: <f17812d70909231525t594704c5u781e2221481676a0@mail.gmail.com>
References: <200909231824.11671.anarsoul@gmail.com>
	<200909232223.35835.anarsoul@gmail.com>
	<f17812d70909231525t594704c5u781e2221481676a0@mail.gmail.com>
Message-ID: <200909241155.01206.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 24 ???????? 2009 01:25:46 ????? Eric Miao ???????:

> No, it doesn't.
> 
> So my suggestion at the moment is that you may:
> 
> 1. try dump the registers after pwm_enable() and see if all are setup
> correctly,
> 
> 2. and make sure those registers are write-able at that time (some
> SoC doesn't allow register writing when the controller is disabled).
> 

Here's a trace with my comments, but I can't see anything wrong in this trace:

/* Configuring backlight level */
pwm_config:271: TCMPB, wrote: 0000010a, read: 0000010a <- Configure duty
pwm_config:274: TCNTB, wrote: 0000012a, read: 0000012a <- Configure period
pwm_config:281: TCON, wrote: 0051990f, read: 0051990f <- Set manual update 
flag
pwm_config:286: TCON, wrote: 0051990d, read: 0051990d <- Clear manual update 
flag
pwm_enable:149: TCON, wrote: 0051990d, read: 0051990d <- Enable called each 
time if backlight level != 0
/* Configuring backlight level */
pwm_config:271: TCMPB, wrote: 000000a3, read: 000000a3
pwm_config:274: TCNTB, wrote: 0000012a, read: 0000012a
pwm_config:281: TCON, wrote: 0051990f, read: 0051990f
pwm_config:286: TCON, wrote: 0051990d, read: 0051990d
pwm_enable:149: TCON, wrote: 0051990d, read: 0051990d
/* Configuring backlight level */
pwm_config:271: TCMPB, wrote: 00000112, read: 00000112
pwm_config:274: TCNTB, wrote: 0000012a, read: 0000012a
pwm_config:281: TCON, wrote: 0051990f, read: 0051990f
pwm_config:286: TCON, wrote: 0051990d, read: 0051990d
pwm_enable:149: TCON, wrote: 0051990d, read: 0051990d
/* Works fine until next sequence */
/* Disabling backlight */
pwm_config:271: TCMPB, wrote: 00000129, read: 00000129
pwm_config:274: TCNTB, wrote: 0000012a, read: 0000012a
pwm_config:281: TCON, wrote: 0051990f, read: 0051990f
pwm_config:286: TCON, wrote: 0051990d, read: 0051990d
pwm_disable:170: TCON, wrote: 0051990c, read: 0051990c <- Clear start flag

/* Enabling backlight back, but it doesn't work :( */
pwm_config:271: TCMPB, wrote: 00000124, read: 00000124 <- Configure duty
pwm_config:274: TCNTB, wrote: 0000012a, read: 0000012a <- Configure period
pwm_config:281: TCON, wrote: 0051990e, read: 0051990e <- Set manual update 
flag
pwm_config:286: TCON, wrote: 0051990c, read: 0051990c <- Clear manual update 
flag
pwm_enable:149: TCON, wrote: 0051990d, read: 0051990d <- Set start flag
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090924/cd49e4b9/attachment.sig>
