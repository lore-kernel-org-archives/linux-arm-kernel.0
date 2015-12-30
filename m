From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 30 Dec 2015 16:46:47 +0100
Subject: [GIT PULL 3/5] ARM: tegra: Core SoC changes for v4.5-rc1
In-Reply-To: <20151222195446.GH30172@localhost>
References: <1450356639-7758-1-git-send-email-thierry.reding@gmail.com>
 <1450356639-7758-3-git-send-email-thierry.reding@gmail.com>
 <20151222195446.GH30172@localhost>
Message-ID: <20151230154647.GB7085@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 11:54:46AM -0800, Olof Johansson wrote:
> On Thu, Dec 17, 2015 at 01:50:37PM +0100, Thierry Reding wrote:
> > Hi ARM SoC maintainers,
> > 
> > The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> > 
> >   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.5-soc
> > 
> > for you to fetch changes up to a262e87ff354f12447bb6268bd63edf7ba1c20e0:
> > 
> >   ARM: tegra: select USB_ULPI from EHCI rather than platform (2015-11-24 16:47:26 +0100)
> > 
> > Thanks,
> > Thierry
> > 
> > ----------------------------------------------------------------
> > ARM: tegra: Core SoC changes for v4.5-rc1
> > 
> > The big thing here is Tegra210 support, which is really only the Kconfig
> > symbol. Other than that there's a few miscellaneous fixes.
> 
> Hi,
> 
> We merge arch/arm and arch/arm64 and drivers/bus contents through separate
> branches, so having them come in from you in one combined branch isn't working
> very well.
> 
> If you don't have any downstream users of this I can just cherry-pick them into
> the appropriate branches, but if you do, please send separate requests for
> those three categories.

I don't think that'll work. Or at least, the outcome will be almost the
same because of interdependencies between the branches.

For the patches in this branch:

      soc/tegra: Provide per-SoC Kconfig symbols
      soc/tegra: Add Tegra210 support

These are dependencies for the following:

      ARM: tegra: select USB_ULPI from EHCI rather than platform

Whereas these two:

      ARM: tegra: Ensure entire dcache is flushed on entering LP0/1
      amba: Hide TEGRA_AHB symbol

can be applied in any order. So I could send you a pull request with
only the drivers/bus patch, and another one with the dcache flush fix.

But that's about it. The Kconfig changes are dependent on each other,
hence will need to be brought in via a common ancestor, unless you want
to resolve a rather annoying conflict in arm-soc.

As for the for-4.5/dt branch that has a dependency on both the
for-4.5/clk branch for a DT include file and on the for-4.5/soc branch
for the new ARCH_TEGRA_210_SOC Kconfig symbol. I suppose it wouldn't be
strictly necessary to pull in the branch because it is a ("soft") make
dependency and the Tegra210 DTBs will simply be ignored unless the
for-4.5/soc branch is also merged. That's slightly confusing because
then there's a branch with DTS files that can't be built.

Anyway, let me know what you prefer and I'm sure I can work something
out that will suite you.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151230/feb5ae7b/attachment.sig>
