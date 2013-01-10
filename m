From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Jan 2013 14:22:45 +0000
Subject: [PATCH] hardlockup: detect hard lockups without NMIs using
 secondary cpus
In-Reply-To: <20130110140215.GP88797@redhat.com>
References: <1357783059-13923-1-git-send-email-ccross@android.com>
 <20130110140215.GP88797@redhat.com>
Message-ID: <20130110142245.GE19944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 09:02:15AM -0500, Don Zickus wrote:
> On Wed, Jan 09, 2013 at 05:57:39PM -0800, Colin Cross wrote:
> > Emulate NMIs on systems where they are not available by using timer
> > interrupts on other cpus.  Each cpu will use its softlockup hrtimer
> > to check that the next cpu is processing hrtimer interrupts by
> > verifying that a counter is increasing.
> > 
> > This patch is useful on systems where the hardlockup detector is not
> > available due to a lack of NMIs, for example most ARM SoCs.
> 
> I have seen other cpus, like Sparc I think, create a 'virtual NMI' by
> reserving an IRQ line as 'special' (can not be masked).  Not sure if that
> is something worth looking at here (or even possible).

No it isn't, because that assumes that things like spin_lock_irqsave()
won't mask that interrupt.  We don't have the facility to do that.
