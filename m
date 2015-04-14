From: jbe@pengutronix.de (Juergen Borleis)
Date: Tue, 14 Apr 2015 11:11:51 +0200
Subject: [PATCH 2nd try] RTC/i.MX/DryICE: add recovery routines to the driver
Message-ID: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2nd try, this time with a cover letter... m(

The built-in RTC unit on some i.MX SoCs isn't an RTC only. It is also a tamper
monitor unit which can keep some keys. When it does its tamper detection job
and a tamper violation is detected, this RTC unit locks completely including
the real-time counter. In this state the unit is completely useless. The only
way to bring it out of this locked state is a power on reset. At the next boot
time some flags signals the tamper violation and a specific register access
sequence must be done to finaly bring this unit into life again. Until this is
done, there is no way to use it again as an RTC.
But also without any enabled tamper detection sometimes this unit tends to
lock. And in this case the same steps must be done to bring it into life
again.
The current implementation of the DryIce driver isn't able to unlock the
device successfully in the case it is locked somehow. Only a full power cycle
including *battery power* can help in this case.

The attached change set adds the required routines to be able to unlock the
DryIce unit in the case the driver detects a locked unit. This includes
unlocking it if it is locked by accident or malfunction and not by a real
tamper violation.

The last patch of this series is for reference only and should not be part
of the kernel. It just adds some code to force a locked DryIce unit to check
if the new routines are able to unlock it again. This code was required
because I had no hardware which really uses the tamper detection features of
this unit.

Comments are welcome.

jbe
