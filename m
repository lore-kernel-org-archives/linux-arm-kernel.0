From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Nov 2014 01:03:20 +0100
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32 bit
 DMA
In-Reply-To: <54590DDE.2040102@redhat.com>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <7145110.be3vG56Rvi@wuerfel> <54590DDE.2040102@redhat.com>
Message-ID: <2654320.Z9Ne8NF4kv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 November 2014 10:33:18 Al Stone wrote:
> On 11/03/2014 10:14 AM, Arnd Bergmann wrote:
> > On Monday 03 November 2014 09:15:51 Mark Salter wrote:
> >> On Thu, 2014-10-30 at 22:05 +0100, Arnd Bergmann wrote:
> >>> Note that the discussions about merging ACPI support on ARM64
> >>> are based on the assumption that we'd only ever support SBSA-like
> >>> platforms, not something like X-Gene that looks more like an
> >>> embedded SoC. Your XHCI patches still obviously make sense for
> >>> other platforms, so that's not a show-stopper.
> >>
> >> But for some misconfiguration, the arm64 kernels in fedora arm
> >> koji would boot using ACPI on Mustang, the Foundation model,
> >> and AMD Seattle platforms. All very much a work in progress,
> >> but the tree from which the fedora patches are taken is the
> >> devel branch of:
> >>
> >>   git.fedorahosted.org/git/kernel-arm64.git
> >>
> >> The configuration will be fixed this week and then you can
> >> just grab an arm64 fedora kernel and boot with acpi=force.
> 
> Please note that I work directly with Mark Salter and that I have
> personally handed out this particular URL many times at either Linaro
> Connect and/or to individuals directly.  It is not now nor has it ever
> been secret, at any time.

What I meant was that the patches haven't been circulated on the
usual mailing lists when this is exactly the work that needs to
be discussed before the base patches that are being sent out can
be merged.

I was also under the impression (based on the URL) that this
was the official Fedora kernel for ARM64. Apparently that is not
true, and I probably overreacted based on that. I certainly don't
want to see this kind of patches being put into Fedora before
there is basic consensus about whether or not they can eventaully
get merged upstream.

> > It's not as bad as I had feared, but it still does a lot of
> > the things that in previous discussions were said that ACPI
> > would avoid doing, and that were used as arguments against
> > just using DT on all arm64 servers:
> > 
> > - The use of the device properties API that was introduced for
> >   Intel's embedded devices for on-chip components directly
> >   contradicts the "standardized firmware interfaces" argument
> >   that certain people keep making. This certainly explains how
> >   you plan to use the networking side, but I suspect it's not
> >   what the ACPI proponents were looking for, or what the base
> >   patch set is being advertised as.
> 
> I do not understand this statement at all.  One of the things
> that was added to the ACPI 5.1 specification was the _DSD method
> -- Device Specific Properties -- specifically so that device
> properties could be standardized.  The API mentioned relies on the
> existence of _DSD for ACPI.  Further, there are people from Linaro
> (who happen to work in the kernel and ACPI), the Linux community,
> as well as from Intel, ARM and even Microsoft working together to
> figure out ways to standardize the device properties being used in
> the ACPI Spec Working Group (ASWG) of the UEFI Forum; several of us
> are of course paying attention to, participating in, and incorporating
> the discussions on this kernel list and others.
> 
> So what is not being standardized?  From where I sit, as part of ASWG,
> Linaro, Red Hat, and some-time contributor to the Linux kernel, this
> whole device properties API was driven by the desire to have a
> standardized firmware interface.  It even seems to be going a step
> further and trying to standardize how the kernel interacts with any
> firmware.

The point of _DSD is to allow a more generalized format for describing
devices that are not standardized. We need this for (x86) embedded
systems, because the standardization process is not scalable for
coming up with an official description for every single device, so
_DSD with the DT properties extension is a great workaround.

In particular, this allows us to have a common stable binding for
devices between ACPI and DT, which is also great because we already
have DT bindings for hundreds or thousands of peripherals that are
used on embedded systems. Grant has also started conversations with
a number of parties about creating an official standard for the
subsystem specific DT bindings that are not part of IEEE1275 or
ePAPR, but the individual device bindings are not standardized in
the sense of having a standardization body oversee the addition
of every single device property in the form that the UEFI forum
oversees the things that go into the ACPI specification.

We still need to discuss about what this means for ARM servers, and
when we raised this topic during the kernel summit, it was far from
clear whether we would apply the _DSD device properties to ARM64
servers or not. I think there are good reasons on both sides of
the argument.

> > - Using custom drivers for hardware that is required by SBSA
> >   (ahci, pci, ...) means you are contradicting the 
> >   Documentation/arm64/arm-acpi.txt document that is merged as
> >   one of your early patches and that keeps getting posted as
> >   the base of discussion for the inclusion of the base ACPI
> >   support. I don't think you can have it both ways, saying that
> >   SBSA is required and supporting hardware that doesn't do any
> >   of it won't work.
> 
> This is where I start the serious whinging....
> 
> On the one hand, I'm told "show the patches."  Fine.  Someone other
> than me happens to show patches for work in progress.  Or, perhaps I
> show patches that work but are still proof of concept.  It doesn't
> seem to matter which.  The response then looks to me like I'm being
> told, "don't show patches that are not the absolute, final, irrefutable
> and irrevocable version."  So which is it?
> 
> The git tree mentioned is a work in progress.  No one has ever claimed
> it was otherwise.  This is exactly the same case as with the Linaro
> ACPI and kernel development trees.

I definitely want to see work-in-progress patches. It's very important
that we figure out what kind of platforms we can and cannot support
upstream. Your patches can do exactly that: If we find that the issues
are fundamental based on hardware problems that you can only discover
by trying things out and we can't ever merge them, then you should
find out as early as possible so you can stop wasting your time on
them. If on the other hand you can show that all remaining problems
are shallow and that you have a plan to fix them in software in an
acceptable way, then you can start announcing that it works and that
we will be able to support that hardware with ACPI upstream in the
future, as well as merge the base patches in a reasonable time frame.

> What I find incredibly frustrating is that I feel I am being told to
> submit the final form of patches for ACPI drivers, but those can ONLY
> be a work a progress until the ACPI core patches that we have been
> trying to get into the kernel are accepted.

That is bullshit, who is saying that?

You should definitely submit driver patches for review, it is the
absence of these patches that has made the core ACPI support impossible
to review properly, because we just don't know what is coming.

Submitting for inclusion is a bit different: I don't want to clutter
the kernel with support for an interface that we probably won't
ever support. The PCI support for X-Gene shows exactly that, it isn't
compliant with either ACPI-5.x or SBSA, and supporting it with ACPI
requires extremely ugly hacks. If we know we can't support X-Gene PCIe,
what good does it do to put any of the other X-Gene patches in?

>  Until those core patches
> are in the kernel, all I can really do is experiment with drivers and
> show work in progress; there's no foundation to rely on.
> 
> I get further frustrated when I fold in basic, practical considerations.
> Regardless of whether one thinks the APM or AMD hardware is an actual
> arm64 server or not, it is what we have.  I cannot change that.  Some
> of the hardware is not server-like; some of it just does strange and
> goofy things.  These are first generation boxes; I always expect such
> things to be weird.  It's just in their nature.

Sure, and we will have even stranger servers, and more broken ones,
as soon as we get more of the embedded SoCs using ARM64 cores and
people start putting them into server boxes. We can support them all
with DT, and we likely will, but there are limits to what we can and
should do with ACPI, and we have 

> So, I write (or ask someone else to write, or bodge something borrowed
> from someone else) a driver to experiment with, that tries to get odd
> hardware working.  Or, in the case of the SBSA UART, what's available
> doesn't actually work on some hardware.  Or, in some cases, the driver
> based on DT is not right.  Or, the firmware (DT *or* ACPI) is not yet
> complete.  My goal is just to see if I can get *something* working so
> I can see what's really going on with the hardware.  Then, the patches
> that work, even if ugly, are shared as work in progress.  The result
> of that sharing seems to be more "go away until absolute final perfect
> versions are ready."

Not at all, we never require code to be final or perfect before it
can get merged. The requirement is that we can reasonably assume that
we don't have to make incompatible interface changes (user space or
firmware interfaces, not in-kernel), and that we can see how bad it
would get to complete the work.

> If what I am really being told is that ACPI for arm64 will never be
> accepted in the Linux kernel, then just say so.  I have other things
> to do with my life than go in circles like this.
> 
> If instead there is some constructive criticism that helps improve
> either the ACPI core patches or the driver patches, or better yet
> allows us to make forward progress, that would be wonderful.  As far
> as I know, everyone is doing the best they can with the resources
> available, and making as much progress as they can without everything
> being settled.

I can keep saying what I have said many times before: the core patches
are not a big issue, stop trying to polish them more and focus on
the important parts:

- Show what a reasonably complete platform would look like. A link
  to a git tree in the description of the base patches would be
  a good start, but it should also mention the things that are
  still missing.

- write a patch series introduction that explains why you think
  we should merge it rather than what it is that the patches do.
  The v5 "Introduce ACPI for ARM64 based on ACPI 5.1" series still
  completely fails to do this, I would never dream of sending this
  upstream to Linus Torvalds without a really good justification.
  
- Limit the scope of ACPI support to the smallest useful subset
  of machines that are required to achieve the goals of ACPI
  support. Insisting on including X-Gene in the mix is just making
  this very painful and slow, and I can't imagine any technical
  reason for doing this.

> > - Adding a generalized method to support arbitrary PCI host
> >   controllers indicates that you expect this practice to not
> >   just be a special exception for APM but that others would
> >   require the same hack to work around firmware or hardware that
> >   is not compliant with ACPI. At the same time you introduce a
> >   significant of driver code in arch/arm64/kernel/pci.c. Some
> >   of that code is probably just an oversight and can be moved into
> >   the PCI core later, but it doesn't even seem you tried that
> >   hard.
> 
> APM *is* a special case because of what they do in their hardware;
> perhaps that should have been stated explicitly.  By the same token,
> writing kernel code that is flexible in the face of unknown future
> hardware seemed reasonable at face value, but perhaps we should not
> do that.

Correct: Don't write kernel code more generic than you need to.
Make it as simple as you can to cover the cases you know about,
and refactor it when you have to. In general, adding lots of
generic infrastructure to handle one special case is not worth
it, it will just make your entire code look unnecessarily complex,
which is a problem for merging.

>  But again, this is a work in progress.  The fact that we
> are having to fix x86-specific code and refactor it so that it works
> on multiple architectures is quite blindingly obvious and is indeed
> something that is already being worked on; perhaps that should also
> have been said explicitly.  But again, we chose to share code that we
> know is an early version instead of waiting until a final refactored
> version is available, or instead of keeping it "secret."  Assuming we
> haven't even tried or are completely unaware of the problem without
> even asking I find kind of insulting.

Sorry for the bad wording here, I didn't mean to be insulting.
 
> From where I sit, I feel I'm being told that I'm doing all the work in
> secret and getting dinged for that.  So, work in progress is shared,
> even though it's early and we explicitly says it's work in progress,
> and now I'm getting dinged for that.

Some patches very clearly talk about work in progress in the changelog,
and I wasn't in any way referring to those. Some other patches
like "arm64/acpi/pci: add support for parsing MCFG table" are written
like you expect them to get merged, so it seems I was confused by
the somewhat lacking changelog if this really just meant as a prototype.

> </diversion>
> 
> So, back to the original topic: are these USB patches ack'd or not?
> I can verify that they behave on Mustang; they have been tested with
> both DT and ACPI.

The USB patches are fine in the latest version, they are not X-Gene
specific and are needed anyway.

	Arnd
