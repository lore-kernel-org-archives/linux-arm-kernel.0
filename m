From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 May 2016 17:18:22 +0200
Subject: [PATCH v3 4/4] soc: Add SoC driver for Freescale Vybrid platform
In-Reply-To: <CAL_JsqKCwy=aXveTfnaQuZ5b3Ld9nzABgPfdPm1JX3CBuvzG+Q@mail.gmail.com>
References: <cover.1463737502.git.maitysanchayan@gmail.com>
 <20160524041447.GA2884@Sanchayan-Arch.localdomain>
 <CAL_JsqKCwy=aXveTfnaQuZ5b3Ld9nzABgPfdPm1JX3CBuvzG+Q@mail.gmail.com>
Message-ID: <5922111.afqro67xTI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 24, 2016 12:09:41 PM CEST Rob Herring wrote:
> On Mon, May 23, 2016 at 11:14 PM,  <maitysanchayan@gmail.com> wrote:
> > Hello Rob,
> >
> > On 16-05-23 16:18:13, Rob Herring wrote:
> >> On Fri, May 20, 2016 at 03:32:05PM +0530, Sanchayan Maity wrote:
> >> > This adds a SoC driver to be used by Freescale Vybrid SoC's.
> >> > Driver utilises syscon and nvmem consumer API's to get the
> >> > various register values needed and expose the SoC specific
> >> > properties via sysfs.
> >> >
> >> > A sample output from Colibri Vybrid VF61 is below:
> >> >
> >> > root at colibri-vf:~# cd /sys/bus/soc/devices/soc0
> >> > root at colibri-vf:/sys/bus/soc/devices/soc0# ls
> >> > family     machine    power      revision   soc_id     subsystem  uevent
> >> > root at colibri-vf:/sys/bus/soc/devices/soc0# cat family
> >> > Freescale Vybrid VF610
> >> > root at colibri-vf:/sys/bus/soc/devices/soc0# cat machine
> >> > Freescale Vybrid
> >> > root at colibri-vf:/sys/bus/soc/devices/soc0# cat revision
> >> > 00000013
> >> > root at colibri-vf:/sys/bus/soc/devices/soc0# cat soc_id
> >> > df6472a6130f29d4
> >> >
> >> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> >> > ---
> >> >  .../bindings/arm/freescale/fsl,vf610-soc.txt       |  20 +++
> >> >  drivers/soc/Kconfig                                |   1 +
> >> >  drivers/soc/fsl/Kconfig                            |  10 ++
> >> >  drivers/soc/fsl/Makefile                           |   1 +
> >> >  drivers/soc/fsl/soc-vf610.c                        | 198 +++++++++++++++++++++
> >> >  5 files changed, 230 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
> >> >  create mode 100644 drivers/soc/fsl/Kconfig
> >> >  create mode 100644 drivers/soc/fsl/soc-vf610.c
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
> >> > new file mode 100644
> >> > index 0000000..338905d
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
> >> > @@ -0,0 +1,20 @@
> >> > +Vybrid System-on-Chip
> >> > +---------------------
> >> > +
> >> > +Required properties:
> >> > +
> >> > +- compatible: "fsl,vf610-soc"
> >> > +- rom-revision: phandle to the on-chip ROM node
> >> > +- mscm: phandle to the MSCM CPU configuration node
> >> > +- nvmem-cells: phandles to two OCOTP child nodes ocotp_cfg0 and ocotp_cfg1
> >> > +- nvmem-cell-names: should contain string names "cfg0" and "cfg1"
> >>
> >> I still have similar concerns as the discussion on the last version.
> >> This version only proves that you aren't describing h/w, but rather just
> >> a collection of data that some driver wants.
> >>
> >> A driver can just as easily look-up all the nodes directly that these
> >> phandles point to.
> >
> > Agreed, that we can look up all the nodes directly that these phandles
> > refer to but I would still need a DT entry to bind to. While I could
> > bind to existing nodes like mscm cpucfg but that doesn't seem right.
> >
> > The very first approach that we had taken was to integrate this functionality
> > in mach-vf610.c code under mach-imx
> > http://www.spinics.net/lists/devicetree/msg80654.html
> 
> Yes, everyone wants to move all platform devices in the kernel to a
> corresponding DT node. The result is often making up nodes to do this.
> It's the same thing with cpufreq.
> 
> > and then it was recommended to migrate this to drivers/soc where we did use
> > phandles or direct look up via compatible strings
> 
> The location in the tree is an orthogonal issue. You could move it and
> use of_machine_is_compatible without any DT change.
> 
> The primary issue I have here is how do we bind soc_bus to DT in a
> consistent way. Sorry, but vybrid specific patches alone are never
> going to solve that issue.

On a lot of chips, there is actually one device that holds the soc
identification registers, and that can easily be used for this purpose.

Originally, the soc_device was meant to be the parent device for all
other on-chip devices and be bound to the DT node that holds that
bus (unlike things like external clocks that are not part of the SoC).

However, that model has never really caught on, and we have stopped
doing this for new chips. Instead, the soc_device now somewhat
stands for itself.

> > http://www.spinics.net/lists/arm-kernel/msg420847.html
> >
> > and
> >
> > http://lkml.iu.edu/hypermail/linux/kernel/1506.0/03787.html
> >
> > There hasn't been a consensus since v1.
> 
> I actually prefer your previous version binding soc_bus to the root
> bus node to this version. I think that is closer to the right
> direction. After all, pretty much everything is an SOC and every SOC
> has an SOC bus. Pretty much every SOC and board have revisions and may
> need to expose that revision info as well. We have to do this
> consistently which means having a default implementation for
> simple-bus that is not opt-in.
> 
> Alternatively, we should just deprecate soc_bus and come up a
> different solution. Either way, I think we have a half implemented
> solution currently.

We have had several drivers in the past that needed to figure out
whether they were running on a particular version of a SoC, and that
could not get this information from the DT. My suggested solution
for this is to provide an API from soc_bus that compares a
glob string to the available soc_device instance(s) in order to
figure out whether we are running on a particular kind of system.

	Arnd
