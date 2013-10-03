From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Oct 2013 21:07:12 +0100
Subject: Detect presence of LPAE when not running an LPAE kernel?
In-Reply-To: <1380829403.3804.56.camel@hastur.hellion.org.uk>
References: <1380829403.3804.56.camel@hastur.hellion.org.uk>
Message-ID: <20131003200712.GG12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 08:43:23PM +0100, Ian Campbell wrote:
> Is this possible?
> 
> The Features field of /proc/cpuinfo only appears to reflect the presence
> of LPAE if CONFIG_LPAE is actually on in the running kernel.
> 
> The reason I care is so that distro installers can ship a generic kernel
> but select LPAE for the running system when appropriate.
> 
> On x86 for example I would check /proc/cpuinfo:flags which contains the
> CPU features, regardless of whether they are currently enabled.
> 
> Is there any equivalent on ARM?

Perversely, LPAE in there has nothing to do with LPAE being used by the
kernel.  It's more to do with the presence of the double-word load/store
exclusive.

It went through lots of discussions about what to call this, whether it
was "ATOMICD" (which is very perverse and vague) or LPAE (which is what
it was keyed off of).

Now, this LPAE flag is present whether or not the kernel has been built
with CONFIG_LPAE enabled or not.  That's because its not about LPAE
really, it's about those load/store exclusive instructions.

Now, this isn't applied to all flags: we hide certain CPU facilities
when the kernel support is missing, because the instructions can't be
used without kernel support being present.  For instance, if the VFP
support code is not present, support for VFP instructions will be
hidden (and the instructions disabled) because there's nothing to
context-switch the VFP state and stop one thread interfering with
another.
