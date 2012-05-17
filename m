From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 May 2012 16:12:52 -0700
Subject: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
In-Reply-To: <87y5oqtpnw.fsf@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
 <1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
 <87y5oqtpnw.fsf@ti.com>
Message-ID: <20120517231251.GH17852@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120517 15:29]:
> 
> I just noticed that this patch has caused some strange problems, notably
> with the GPIO IRQ used by smsc911x NIC (Overo, Zoom3, 2430SDP, etc. etc.)
> 
> The patch itself is OK, but it has exposed a bug in other parts of the
> context restore path that was previously hidden.
> 
> We seem to have been finding lots of GPIO bugs by just testing the
> network chips with GPIO IRQs.  Can I suggest that a platform with a GPIO
> IRQ NIC be added to the test platforms you're using? 

Yes considering the breakage it's pretty obvious the original series was
never properly tested on omaps.

Regarding this fix, using gpio/next + this patch fixes nfsroot for 2430sdp,
and gets zoom3 nfsroot booting going a bit better.

However, at least on zoom3 nfsroot now takes several _minutes_ to get to
login: with gpio/next + this patch. The system is totally unusable.

It seems that the GPIO interrupt wake-up events are not properly working
now?

Reverting the "gpio/omap: fix missing check in *_runtime_suspend()"
patch seems to fix the issue.

> Subject: [PATCH] gpio/omap: fix broken context restore for non-OFF mode
>  transitions
> 
> The fix in commit 1b12870 (gpio/omap: fix missing check in
> *_runtime_suspend()) exposed another bug in the context restore path.

Kevin, looks like commit 1b12870 does not exist in gpio/next?

Regards,

Tony
