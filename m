From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 01 Mar 2014 19:12:33 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226222147.GE16149@cbox>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel> <
 20140226200537.GC16149@cbox> <6873065.LH15I057sX@wuerfel> <
 CABGGisxHOVqLcG7hVAuAzdeic41KWSLLBSjQLSJQcjTXLhNCow@mail.gmail.com> <
 20140226222147.GE16149@cbox>
Message-ID: <20140301191233.4A62CC4084F@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014 14:21:47 -0800, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Wed, Feb 26, 2014 at 03:56:02PM -0600, Rob Herring wrote:
> > On Wed, Feb 26, 2014 at 2:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wednesday 26 February 2014 12:05:37 Christoffer Dall wrote:
> > >> On Wed, Feb 26, 2014 at 08:55:58PM +0100, Arnd Bergmann wrote:
> > >> > On Wednesday 26 February 2014 10:34:54 Christoffer Dall wrote:
> > >>
> > >> The most common response I've been getting so far is that people
> > >> generally want their VMs to look close to the real thing, but not sure
> > >> how valid an argument that is.
> > >>
> > >> Some people feel strongly about this and seem to think that ARMv8
> > >> kernels will only work with ACPI in the future...
> > >
> > > That is certainly a misconception that has caused a lot of trouble.
> > > We will certainly keep supporting FDT boot in ARMv8 indefinitely,
> > > and I expect that most systems will not use ACPI at all.
> > 
> > Furthermore, even enterprise distro kernels will boot DT based kernels
> > assuming the h/w support is mainlined despite statements to the
> > contrary. It is a requirement in mainline kernels that DT and ACPI
> > support to coexist. Distros are not going to go out of their way to
> > undo/break that. And since the boot interface is DT, you can't simply
> > turn off DT. :)
> > 
> 
> Personally I'm all for simplicity so I don't want to push any agenda for
> ACPI in VMs.
> 
> Note that the spec does not mandate the use of ACPI, it just tells you
> how to do it if you wish to.
> 
> But, we can change the spec to require full FDT description of the
> system, unless of course some of the ACPI-in-VM supporters manage to
> convince the rest.

Given that we don't even have a reliable view of what ACPI is going to
look like on hardware yet, it probably is appropriate to omit talking
about it entirely for v1.0.

... although let me walk through the implications of how that could be
done:

Option 1: If v1.0 requires VM provide FDT, and v2.0 requires VM provide
          either FDT or ACPI:
- v1.0 VM shall always provide an FDT
- v2.0 VM might provide ACPI without FDT
- v1.0 OS must accept FDT
- v2.0 OS must accept both ACPI and FDT
Implications:
  - a v1.0 OS might not boot on a v2.0 VM (because it cannot handle ACPI)
  - a v2.0 OS will always boot on both v1.0 and v2.0 VMs
  - ACPI-only OS not supported by this spec (Windows; potentially RHEL)
  - FDT-only OS not supported by v2.0 of the spec. If we're only talking
    Linux this isn't a problem, but it does put additional burden on
    anyone doing a domain-specific OS. (for example, a bare-metal
    networking application using virtualized devices)

Option 2: If v1.0 requires FDT, and v2.0 requires either FDT only or FDT+ACPI
- v1.0 and v2.0 VMs shall always provide and FDT
- v2.0 VMs may additionally provide ACPI
- v1.0 and v2.0 OSes must accept FDT
- No requirement for OS to accept ACPI
Impliciations:
  - a v1.0 OS will boot on a v1.0 and v2.0 VM (FDT is always provided)
  - a v2.0 OS will boot on a v1.0 and v2.0 VM
  - ACPI-only OS not supported by this spec for all configurations.
    There would need to be a stronger version of the spec (v2.0-ACPI) to
    specify the configuration usable by ACPI OSes.

Option 3: If v1.0 requires FDT, and v2.0 requires both FDT and ACPI
- v1.0 and v2.0 VMs shall always provide and FDT
- v2.0 VMs shall always provide ACPI
- v1.0 OSes must accept FDT
- v2.0 OS may accept either ACPI or FDT
Impliciations:
  - a v1.0 OS will boot on a v1.0 and v2.0 VM (FDT is always provided)
  - a v2.0 OS will boot on a v1.0 and v2.0 VM
  - Both FDT-only and ACPI-only OSes supported by v2.0 version of spec

Someone is going to be unhappy no matter what is chosen. I think it is
critical to be really clear about who the audience is. Doing the above
also highlights for me the cost adding either/or options to the spec.
Every 'or' option given to VMs adds cost to the OS. ie. if the spec
allows the VM to implement either ACPI or FDT, then a compliant OS must
support both. Alternately, if the spec allows the OS to implement only
ACPI or only FDT, then compliant VMs are forced to implement both. In
both cases it is a non-trivial burden (As far as I know, no ACPI-on-arm
work has been done for *BSD, and it is yet to be done for all the VMs).
The spec will be the most useful if as many options as possible are
eliminated.

Right now I think option 2 above makes the most sense; require FDT and
make ACPI an optional extension. That will support almost all Linux
vendors immediately and possibly even FreeBSD. As others have said,
Windows is a complete unknown and we have no idea if they will be
interested in the spec (nor is this the right forum for that
conversation, but I will bring it up with my contacts).

g.
