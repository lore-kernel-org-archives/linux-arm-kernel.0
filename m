From: bgriffis@ti.com (Griffis, Brad)
Date: Thu, 20 Nov 2014 14:23:30 +0000
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <546DF2F0.9080405@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws>
 <546DF2F0.9080405@ti.com>
Message-ID: <912A29987EAE174BA6CF187D7CDFA9CE26F69163@DLEE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nori, Sekhar
> Sent: Thursday, November 20, 2014 7:56 AM
>
> I also tested this series on AM335x EVM using the v3.18-rc5 kernel.
> Again, no breakage but no improvement as well.

The primary goal was not necessarily to improve performance of the touchscreen itself.  It was to reduce unnecessary CPU overhead introduced by the 275us udelay in the ISR.  On a related note, that 275us udelay is not something that worked for all boards.  For example, see the following forum thread:

http://e2e.ti.com/support/arm/sitara_arm/f/791/p/217587/775152.aspx#775152

In that thread the user was registering multiple press events for a single press.  By increasing the udelay to 1.5ms they were able to solve the problem.  Of course, having a 1.5ms delay in your ISR is a really bad thing to do...

I have another customer that was experiencing the same issue of registering multiple press events, and sure enough the 1.5ms delay "fixed" their problem too.  The patches allowed them to remove that gigantic delay from the ISR because that software delay has now become a hardware delay via CHARGECONFIG.  That customer is the one that needed 0xB000 which is MUCH larger than the value of 0x400 that was working fine for me on the EVM.
