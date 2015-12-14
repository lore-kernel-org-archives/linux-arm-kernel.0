From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Dec 2015 10:19:40 +0100
Subject: [PATCH 00/10] drivers/pci: avoid module_init in non-modular
 host/pci*
In-Reply-To: <CAFiDJ5-Y8afg5kDRQLK1pain-k1kPQAn3vhWrVkB1ADPRHvx+A@mail.gmail.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <CAMuHMdXr=ErCO3R2LB+wBJh3JSiFkH5q3-FLSTOwdGT87fXz3A@mail.gmail.com>
 <20151214082425.GA3766@ulmo.nvidia.com>
 <CAFiDJ5-Y8afg5kDRQLK1pain-k1kPQAn3vhWrVkB1ADPRHvx+A@mail.gmail.com>
Message-ID: <20151214091940.GA15126@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 04:33:51PM +0800, Ley Foon Tan wrote:
> On Mon, Dec 14, 2015 at 4:24 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Mon, Dec 14, 2015 at 09:19:30AM +0100, Geert Uytterhoeven wrote:
> >> Hi Paul,
> >>
> >> On Sun, Dec 13, 2015 at 2:41 AM, Paul Gortmaker
> >> <paul.gortmaker@windriver.com> wrote:
> >> > This series of commits is a slice of a larger project to ensure
> >> > people don't have dead code for module removal in non-modular
> >> > drivers.  Overall there was roughly 5k lines of dead code in the
> >> > kernel due to this.  So far we've fixed several areas, like tty,
> >> > x86, net, etc. and we continue to work on other areas.
> >> >
> >> > There are several reasons to not use module_init for code that can
> >> > never be built as a module, but the big ones are:
> >> >
> >> >  (1) it is easy to accidentally code up unused module_exit and remove code
> >> >  (2) it can be misleading when reading the source, thinking it can be
> >> >       modular when the Makefile and/or Kconfig prohibit it
> >> >  (3) it requires the include of the module.h header file which in turn
> >> >      includes nearly everything else.
> >> >
> >> > Here we convert some module_init() calls into device_initcall() and delete
> >> > any module_exit and remove code that gets orphaned in the process, for
> >> > an overall net code reduction, which is always welcome.
> >> >
> >> > The use of device_initcall ensures that the init function ordering
> >> > remains unchanged, but one could argue that PCI host code might be more
> >> > appropriate to be handled under subsys_initcall.  Fortunately we can
> >> > revisit making this extra change at a later date if desired; it does
> >> > not need to happen now, and we reduce the risk of introducing
> >> > regressions at this point in time by separating the two changes.
> >> >
> >> > Over half of the drivers changed here already explicitly disallowed any
> >> > unbind operations.  For the rest we make them the same, since there is
> >> > not really any sensible use case to unbind any built-in bus support that
> >> > I can think of.
> >>
> >> Personally, I think all of these should become tristate, so distro kernels
> >> don't have to build in PCI(e) support for all SoCs. multi_v7_defconfig kernels
> >> are becoming too big.
> >>
> >> That does not preclude making these modules un-unloadable, though.
> >
> > Most of these can't be made tristate as-is, because they use symbols
> > that aren't exported. Many of those symbols can easily be exported, so
> > its just a matter of getting the respective patches merged. I disagree
> > with making the modules non-unloadable, though. I have a local branch
> > with changes necessary to unload the host controller driver and it
> > works just fine.
> >
> PCIe host driver that use fixup (DECLARE_PCI_FIXUP_*) can't use tristate.
> Fixup region is in kernel region and this region if not updated when
> loading a module.

Interesting, I hadn't thought about that. I suppose this means that the
module will end up containing an unused section with the fixup code. It
might be useful to add a way for that to trigger a warning at build
time.

Perhaps to fix this a mechanism could be introduced to add a table of
fixups to a host controller driver and that will get applied to all
children of the bridge. It could be problematic to cover all of the
different fixup stages, though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/46147b8a/attachment-0001.sig>
