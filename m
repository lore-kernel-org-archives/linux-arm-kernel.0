From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 27 Jun 2014 13:14:50 +0100
Subject: [PATCH] ARM: integrator: fix OF-related regression
In-Reply-To: <CAL_Jsq+wdJu-toWixA9xq124jizj-mW3KE-osETnFj0g4vn=Yg@mail.gmail.com>
References: <1403611687-23512-1-git-send-email-linus.walleij@linaro.org>
 <CAL_Jsq+Us51c-6+kP5Y+aML-HPV-=9SooPepD6u13xyrvDfcKw@mail.gmail.com>
 <CACRpkdZr6T65zOmxy9mQdeapMfu=nwfcXRtufb5DU5NO+vwU7A@mail.gmail.com>
 <20140626193938.GA16226@debian>
 <CAL_Jsq+wdJu-toWixA9xq124jizj-mW3KE-osETnFj0g4vn=Yg@mail.gmail.com>
Message-ID: <20140627121450.D7D32C41060@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Jun 2014 16:31:28 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Jun 26, 2014 at 2:39 PM, Rabin Vincent <rabin@rab.in> wrote:
> > On Thu, Jun 26, 2014 at 02:15:42PM +0200, Linus Walleij wrote:
> >> On Wed, Jun 25, 2014 at 3:06 PM, Rob Herring <robherring2@gmail.com> wrote:
> >> > On Tue, Jun 24, 2014 at 7:08 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >> >> Commit 07e461cd7e73a84f0e3757932b93cc80976fd749
> >> >> "of: Ensure unique names without sacrificing determinism"
> >> >> caused a boot failure regression on the Integrator machines.
> >> >>
> >> >> The problem is probably caused by fiddling too much with
> >> >> the device tree population in the OF init function, such
> >> >> as passing the SoC bus device as parent when populating
> >> >> the device tree.
> >> >>
> >> >> This patch fixes the problem by:
> >> >>
> >> >> - Avoiding to explicitly look up the tree root
> >> >> - Look up devices needed before device population from
> >> >>   the match only, passing NULL as root
> >> >> - Passing NULL as root and parent when calling
> >> >>   of_platform_populate()
> >> >
> >> > Just curious, I don't see how this fixes booting for Integrator. Where
> >> > exactly does boot fail?
> >>
> >> It fails by failing to populate the devicetree somehow. I don't
> >> have the proper debugging needs, I just trial-and-horror-fixed
> >> it by making the board init similar to other platforms :-/
> >
> > earlyprintk doesn't work on Integrator hardware?  It does on QEMU's
> > integratorcp so it's trivial to debug there.
> 
> I got as far as building a kernel to do that before getting distracted...
> 
> > The problem is that integrator_init_sysfs() adds a device attribute
> > called "fpga" to the soc0 bus, and the soc0 bus device is also used as
> > the root of the device tree, and the device tree has a node called "fpga".
> >
> > Before 07e461cd7e73a84f0e3757932b93cc80976fd749 this node directory and
> > attribute file had unique paths:
> >
> >         sysfs: creating file '/devices/soc0/fpga'
> >         sysfs: creating dir '/devices/soc0/fpga.0'
> >
> > 07e461cd7e73a84f0e3757932b93cc80976fd749 removed the .0 from the fpga node's
> > directory, leading to that node (and its subnodes) failing to register due to a
> > filename conflict with the fpga attribute's file:
> 
> Thanks for debugging. Now this makes sense as to why this is specific
> to Integrator. I think this is the right direction and we should not
> put devices under soc0/. That way the structure is consistent across
> SOCs and regardless of whether you decide to create an soc_device or
> not.

Agreed.

g.
