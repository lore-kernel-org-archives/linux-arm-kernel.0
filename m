From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 3 May 2015 17:12:03 +0200
Subject: [rtc-linux] [PATCHv2] RTC/i.MX/DryICE: add recovery routines to
 the driver
In-Reply-To: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
References: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
Message-ID: <20150503151203.GY12076@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/04/2015 at 15:59:46 +0200, Juergen Borleis wrote :
> The built-in RTC unit on some i.MX SoCs isn't an RTC only. It is also a tamper
> monitor unit which can keep some (secret) keys. When it does its tamper
> detection job and a security violation is detected, the whole DryICE unit
> including the real-time counter locks completely. In this state the whole unit
> is completely useless. The only way to bring it out of this locked state is a
> power cylce with a POR (most of the case) or additionally a battery power
> cycle which includes the loss of the secret keys.
> At the next boot time some flags signals the security violation and a specific
> register access sequence must be done to finaly bring this unit into life
> again. Until this is done, there is no way to use it again as an RTC.
> 
> But also without any enabled tamper detection sometimes this unit tends to
> lock. And in this case the same steps must be done to bring it into life
> again.
> 
> The current implementation of the DryIce driver isn't able to unlock the
> device successfully in the case it is locked somehow. Only a full power cycle
> including *battery power* can help in this case.
> 
> The attached change set adds the required routines to be able to unlock the
> DryIce unit in the case the driver detects a locked unit. This includes
> unlocking it if it is locked by accident or malfunction and not by a real
> security violation.
> 
> The last patch of this series is for reference only and should not be part
> of the kernel. It just adds some code to force a locked DryIce unit to check
> if the new routines are able to unlock it again. This code was required
> because I had no hardware which really uses the tamper detection features of
> this unit.
> 
> This is the 2nd version of the patch series. Hopefully I addressed all comments
> from Alexandre.
> 
> In this version I added a new patch which replaces all __raw* register functions
> as recommended by Alexandre.
> 
> Comments are welcome.
> 

I've applied 1-5 after fixing a few parenthesis alignments you missed.
I've also reworked the commit subject prefix to the more concise "rtc:
imdi:" and you forgot the commit message in patch 2, you can check it
here:
https://github.com/alexandrebelloni/linux/commit/eff76de33878687dc1877f40ac2cc34794f499e0

Tell me if you have any objection.

BTW, I guess your email address has been recycled as patchwork recognize
it has belonging to Juergen Beisert ;)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
