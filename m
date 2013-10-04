From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 04 Oct 2013 08:15:08 +0100
Subject: Detect presence of LPAE when not running an LPAE kernel?
In-Reply-To: <20131003200712.GG12758@n2100.arm.linux.org.uk>
References: <1380829403.3804.56.camel@hastur.hellion.org.uk>
 <20131003200712.GG12758@n2100.arm.linux.org.uk>
Message-ID: <1380870908.27765.24.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-10-03 at 21:07 +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 03, 2013 at 08:43:23PM +0100, Ian Campbell wrote:
> > Is this possible?
> > 
> > The Features field of /proc/cpuinfo only appears to reflect the presence
> > of LPAE if CONFIG_LPAE is actually on in the running kernel.
> > 
> > The reason I care is so that distro installers can ship a generic kernel
> > but select LPAE for the running system when appropriate.
> > 
> > On x86 for example I would check /proc/cpuinfo:flags which contains the
> > CPU features, regardless of whether they are currently enabled.
> > 
> > Is there any equivalent on ARM?
> 
> Perversely, LPAE in there has nothing to do with LPAE being used by the
> kernel.  It's more to do with the presence of the double-word load/store
> exclusive.

Ah, and I'm running 3.10 whereas this was added to 3.11-rc1.

> It went through lots of discussions about what to call this, whether it
> was "ATOMICD" (which is very perverse and vague) or LPAE (which is what
> it was keyed off of).
> 
> Now, this LPAE flag is present whether or not the kernel has been built
> with CONFIG_LPAE enabled or not.  That's because its not about LPAE
> really, it's about those load/store exclusive instructions.

So would it be sensible for userspace to use the presence of this lpae
flag from 3.11 onwards to indicate the possibility of running lpae? It
sounds like it might be theoretically a bit dodgy but in actual fact
fine in reality?

Should/do we expose the actual CPU LPAE capability somewhere?

> Now, this isn't applied to all flags: we hide certain CPU facilities
> when the kernel support is missing, because the instructions can't be
> used without kernel support being present.  For instance, if the VFP
> support code is not present, support for VFP instructions will be
> hidden (and the instructions disabled) because there's nothing to
> context-switch the VFP state and stop one thread interfering with
> another.

That's completely reasonable.

Ian.
