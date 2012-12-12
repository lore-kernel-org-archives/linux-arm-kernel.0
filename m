From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Dec 2012 00:51:54 +0000
Subject: Errata on multiplatform kernels
In-Reply-To: <50C7D2AE.7050301@jonmasters.org>
References: <1355203223.16750.2.camel@gitbox>
 <CAOesGMjJ=y4J70CaYYaEem0ni7Vb48KuEZKxaVYuCCCoMYwjPw@mail.gmail.com>
 <20121211180138.GB4989@atomide.com> <50C7D2AE.7050301@jonmasters.org>
Message-ID: <20121212005154.GY14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 07:41:18PM -0500, Jon Masters wrote:
> On 12/11/2012 01:01 PM, Tony Lindgren wrote:
> > * Olof Johansson <olof@lixom.net> [121210 21:38]:
> >> Hi,
> >>
> >> On Mon, Dec 10, 2012 at 9:20 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> >>> How are errata handled on multiplatform kernels?
> >>>
> >>> There don't appear to be any errata selected by default in any of the
> >>> current multiplatform options, but presumably it will happen eventually.
> >>>
> >>> Does that mean the errata will be applied to all machines that boot with
> >>> the errata selected, even if not required?
> >>
> >> Yes. To date I believe most errata we have are just performance hits
> >> on platforms that don't need it.
> >>
> >> Other architectures have in some cases added runtime patching (out) of
> >> workarounds that aren't needed on the current platform for the ones
> >> that have significant performance impact. I'm guessing we'll end up
> >> with something similar eventually but until then we'll try to just go
> >> with the superset of needed errata.
> > 
> > We can't enable any of the errata if there's a chance that it will behave
> > in a different way for secure mode devices compared to non-secure devices.
> > 
> > The discussion is in the thread "[PATCH] ARM: Fix errata 751472 handling
> > on Cortex-A9 r1p*".
> > 
> > The conclusion was that we cannot enable any errata for multiplatform,
> > and must assume the errata is handled by the bootloader. Multiplatform
> > image is already broken for at least omap4 as 751472 is selected.
> 
> On some platforms with a PL310 we have errata 588369 and 727915
> (especially enabled on OMAP4 targets) which will cause an external abort
> when enabled and then booted on highbank systems. This has taken the
> last couple of days on and off to track down. So I guess we need to
> basically disable these in our (Fedora) multiplatform kernel and then
> assume that e.g. PandaBoard will implement some U-Boot fix if it needs
> to have one? Not sure exactly what that fix is going to look like :)

Neither 588369 nor 727915 are something a boot loader can do - they have
to be done in the kernel.  If they're causing highbank systems to fail
that needs to be debugged.

My guess is that highbank is another non-secure system, and the L2x0
code is trying to use pl310_set_debug() which will fail on non-secure
systems as the 'set_debug' hook is not being overriden.

If there was a way to tell that we're running on a non-secure system,
we could automatically point set_debug() to a nop function, but it
would be far more preferable for highbank to provide the hook.  (That
could be itself a no-op if it doesn't require the work-around.)
