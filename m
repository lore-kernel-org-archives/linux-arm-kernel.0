From: ijc@debian.org (Ian Campbell)
Date: Tue, 03 Jul 2018 16:47:51 +0100
Subject: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
In-Reply-To: <CAKv+Gu8VYZ1dCggPjakcvqOxfUCeCAABEADmF2Bm-q3=y3J4ng@mail.gmail.com>
References: <20180628100656.10692-1-james.morse@arm.com>
 <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
 <1530607466.9841.124.camel@debian.org>
 <CAKv+Gu8VYZ1dCggPjakcvqOxfUCeCAABEADmF2Bm-q3=y3J4ng@mail.gmail.com>
Message-ID: <1530632871.9841.139.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-03 at 17:17 +0200, Ard Biesheuvel wrote:
> On 3 July 2018 at 10:44, Ian Campbell <ijc@debian.org> wrote:
> > On Thu, 2018-06-28 at 12:25 +0200, Ard Biesheuvel wrote:
> > > I understand the desire to keep running these M400s as long as they
> > > have some life left in them, but the reality is that they are end of
> > > life already, and not many were manufactured to begin with.
> > 
> > Linux has a long history of supporting such devices so long as there is
> > someone around willing to keep them running (witness for example how
> > long x86/voyager lived with just 1 in existence in a motivated
> > developer's basement, probably some number of entire architectures and
> > I bet a not insubstantial chunk of the platform support in arch/arm).
> > 
> 
> I wonder how many such quirks fall into the 'user cannot be bothered
> to add a kernel command line option' category.

I don't know the overall picture, but the very first one I happened to
look at in arch/x86/kernel/acpi/boot.c (picked by grepping for quirk
and looking for acpi) just now was half a dozen quirks setting
acpi_skip_timer_override which is also settable on the command line.
There's also a bunch in there which just disable ACPI completely which
is also possible on the command line.

My gut feeling is that these are the rule not the exception.

> > So, I think DMI quirks are probably, in reality, inevitable unless
> > you
> > think firmware authors are going to be infaliable or the
> > testing/certification suites never has any gaps in it.
> > 
> 
> Oh, obviously. But this is exactly my point about flood gates: we know
> we need implement support for them, but that fact alone does not
> justify adding quirks for dead platforms for issues that can be
> trivially worked around.

Is m400 really dead? There certainly seem to be people around who care
about keeping it running and have access to them.

> On a related note: what we *could* do to accommodate platforms such as
> m400 that are affected by quirks that can be worked around by a
> command line parameter: we could teach the stub to look at the
> contents of the 'LinuxExtraArgs' EFI environment variable and append
> it to the kernel command line. This is trivial to implement, given
> that we already manipulate and parse the command line in the stub, and
> would allow for a 'fix and forget' tweak to be applied to such
> platforms., without having to accumulate quirks for broken platforms
> that are difficult to remove later.

Ideally the quirk would be a single entry in a table, which is
unobtrusive enough not to worry about removing.

Ian.
