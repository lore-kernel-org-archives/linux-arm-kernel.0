From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Dec 2016 12:29:45 +0000
Subject: [PATCH 2/2] ARM: soft-reboot into same mode that we entered the
 kernel
In-Reply-To: <20161214121747.GH17982@leverpostej>
References: <20161213113044.GC19985@leverpostej>
 <E1cH751-0003kk-Ts@rmk-PC.armlinux.org.uk>
 <20161214115648.GG17982@leverpostej>
 <20161214120541.GD14217@n2100.armlinux.org.uk>
 <20161214121747.GH17982@leverpostej>
Message-ID: <20161214122945.GE14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 12:17:47PM +0000, Mark Rutland wrote:
> On Wed, Dec 14, 2016 at 12:05:41PM +0000, Russell King - ARM Linux wrote:
> > The issue here is that a panic can happen at any time from any context
> > with any hyp stub in place, so there _needs_ to be a uniform way to do
> > this.  It's very bad that we've got this far without this point having
> > been considered - all we can do right now is to try and fix the issues
> > as they come up.
> > 
> > Right now, let's fix this so we get some kind of improvement, and later
> > try to sort out some kind of uniform interface for this task.
> 
> Sure, that's a bigger task, and this is definitely a step in the right
> direction.
> 
> We need to avoid the kdump regression somehow though; can we somehow
> detect if KVM is active and avoid issuing the HVC_SOFT_RESTART?

That's a question for KVM people.

However, there's a bigger question, which is: what do we want to happen
in the case of kdump - do we want to be entering the kdump kernel in
HYP or SVC mode?  As the kdump kernel exists to be able to save the
state of a crashing system, the kdump kernel should do that and then
restart the system in a clean way (iow, not via yet another kexec.)

So maybe the right answer is that kdump should always invoke the kernel
in SVC mode.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
