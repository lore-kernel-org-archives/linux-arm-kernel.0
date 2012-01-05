From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 11:26:02 +0000
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <4F058744.4030503@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <20111222193216.GO2577@n2100.arm.linux.org.uk> <4F048EC4.40900@arm.com>
 <20120104214748.GH11810@n2100.arm.linux.org.uk>
 <CACRpkdZPEYc3xNNb1w4st86bLGMW0ePbEA6+V4opHXe6Sk=u2g@mail.gmail.com>
 <4F0584B5.60908@arm.com>
 <CAMQu2gxuBNRWYKyKRdzvv_m49DyLoODVbC=rKDHDAMTnxe+6+A@mail.gmail.com>
 <4F058744.4030503@arm.com>
Message-ID: <20120105112602.GQ11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 11:19:32AM +0000, Marc Zyngier wrote:
> Global timer is still present, configured and enabled. The kernel just
> happens to select TWD as a better timer. Should TWD be turned off,
> gp_timer will be selected again.

And at that point, the core time keeping code will find a local timer
clock event structure and expect it's broadcast method to be implemented
and working, as I described in my initial reply.

> This is also what happens with the current implementation, and my
> patches don't change that.

Yes they do, because they omit the broadcast method.

Look, local timers *are* special.  They're not the same as global timers.
They're treated differently.  Ripping out the local timer setup stuff
from the SMP code is not the right solution, especially when we've
already got a separation of the local timer core from the hardware
implementation.
