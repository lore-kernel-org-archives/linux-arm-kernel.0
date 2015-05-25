From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 25 May 2015 21:06:42 +0200
Subject: [PATCH] clockevents: don't suspend/resume if unused
In-Reply-To: <alpine.DEB.2.11.1505252046400.5457@nanos>
References: <1421399151-26800-1-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1505252046400.5457@nanos>
Message-ID: <20150525190641.GA7542@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Mon, May 25, 2015 at 08:48:06PM +0200, Thomas Gleixner wrote:
> On Fri, 16 Jan 2015, Alexandre Belloni wrote:
> 
> > There is no point in calling suspend/resume for unused
> > clockevents as they are already stopped and disabled.
> > 
> > Furthermore, it can take some time to wait for some IPs to stop counting.
> 
> While I agree with the patch itself, I really can't understand that
> last sentence.
> 
> If stuff is stopped and disabled, what takes time to stop counting?

Atmel PIT is a bit weird, writing to AT91_PIT_MR restarts the timer even 
if you just want to stop it and then the only way to stop the timer is 
to wait for a complete timer cycle.

The problem is not when suspending, restarting the timer just before 
suspending is not such a problem because is will eventually stop at 
some point in the future.

However it can takes a very long time if the system switchs to slow 
clock, therefore when resuming the timer is still running and we have to 
wait for the PIT to stop counting because we re-enabled it for one cycle 
when suspending, which is weird, it adds about ~128ms resumt time for 
Atmel SoC.

The previous proposed patch was to do nothing in PIT suspend and resume 
callbacks if PIT is unused[1], which fixed the PIT problem, but we 
decided to put the condition in the upper level because other drivers 
might be interested too.

Sylvain

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311496.html
