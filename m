From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Oct 2011 21:05:48 +0100
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111029135653.GA25057@mudshark.cambridge.arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
Message-ID: <20111029200548.GC19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2011 at 02:56:53PM +0100, Will Deacon wrote:
> Hi Russell,
> 
> On Sat, Oct 29, 2011 at 11:21:08AM +0100, Russell King - ARM Linux wrote:
> > I think this is slightly the wrong approach.  We already have:
> > 
> > void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
> > EXPORT_SYMBOL_GPL(arm_pm_restart);
> > 
> > so why do we need a new function pointer?  We could convert the bulk of
> > arm_machine_restart() to a library function (setup_restart()), moving
> > the failure to reboot into machine_restart().
> 
> Funny you should mention this approach. I've been toying with something
> similar for the kexec reset path but I hadn't managed to join the dots
> between that and the arch_reset code.
> 
> I initially observed this in the idle code, where it looks to me like all
> the pm_idle overrides could actually be done in the arch_idle hook (the only
> slightly fiddly one is OMAP). Maybe Nicolas could use the same sort of
> approach for that?

Beware about changing the semantics of pm_idle - it's a cross-arch thing,
and we really shouldn't change those semantics without changing the other
architectures as well.

> I'll give this a go for v2, thanks. Once this is sorted out I'll do a second
> pass to clean up the reboot modes since I've already got some patches for
> that.

Great.
