From: pavel@denx.de (Pavel Machek)
Date: Sat, 26 Apr 2014 22:31:31 +0200
Subject: can problems on socfpga [was Re: [PATCH v2 4/6] ARM: socfpga:
 dts: add can0+1]
In-Reply-To: <20140426093646.GE8730@amd.pavel.ucw.cz>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
 <20140404102815.GA9242@amd.pavel.ucw.cz>
 <20140425195319.GA3677@amd.pavel.ucw.cz>
 <1398457446.26387.0.camel@linux-builds1>
 <1398461518.3587.11.camel@dinh-ubuntu>
 <20140426093646.GE8730@amd.pavel.ucw.cz>
Message-ID: <20140426203131.GA21832@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2014-04-26 11:36:46, Pavel Machek wrote:
> Hi!
> 
> > To get this working well, I had to install a few of the patches that
> > Benedict Spranger submitted ([PATCH 05/16] c_can: use 32 bit access for
> > D_CAN) on 9/9/2013.
> > 
> > I have the patches on our rocketboard branch
> > (rocketboards.org/gitweb/?p=linux-socfpga-git;a=summary)
> > 
> > I planned to upstream these changes but there have been some major
> > changes to CAN recently that may require some refactoring.
> 
> I ported those changes to 3.15-rc2 (but can't test them at the
> moment).

Ok, it seems it is possible to test CAN without actual can hardware
using loopback:

ip link set can0 up type can bitrate 125000 loopback on
ifconfig can0 up
candump can0 &
cansend can0 "123#DEADBEEF"

Moreover, it seems that previous two patches do the trick. Packets are
now echoed as expected. (Ok, small question is "why twice", but I
guess that's just CAN...?)

root at sockit:~# ip link set can0 up type can bitrate 125000 loopback on
c_can_platform ffc00000.d_can can0: setting BTR=1c31 BRPE=0000
root at sockit:~# ifconfig can0 up
root at sockit:~# candump can0 &
root at sockit:~# cansend can0 "123#DEADBEEF"
  can0  123   [4]  DE AD BE EF
  can0  123   [4]  DE AD BE EF
root at sockit:~# 

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
