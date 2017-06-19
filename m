From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 23:04:45 -0700
Subject: [GIT PULL 1/4] soc/tegra: Changes for v4.13-rc1
In-Reply-To: <7de8de14-b0ad-883c-58ec-847789be118b@kapsi.fi>
References: <20170616081306.11505-1-thierry.reding@gmail.com>
 <20170619040045.GD30022@localhost>
 <7de8de14-b0ad-883c-58ec-847789be118b@kapsi.fi>
Message-ID: <20170619060445.GC13137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 19, 2017 at 08:59:11AM +0300, Mikko Perttunen wrote:
> On 06/19/2017 07:00 AM, Olof Johansson wrote:
> >Hi,
> >
> >On Fri, Jun 16, 2017 at 10:13:03AM +0200, Thierry Reding wrote:
> >>Hi ARM SoC maintainers,
> >>
> >>The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> >>
> >>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> >>
> >>are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.13-soc
> >>
> >>for you to fetch changes up to da1dbec1be2b54c16649e33e479708a55156e311:
> >>
> >>   soc/tegra: flowctrl: Fix error handling (2017-06-13 16:47:44 +0200)
> >>
> >>Thanks,
> >>Thierry
> >>
> >>----------------------------------------------------------------
> >>soc/tegra: Changes for v4.13-rc1
> >>
> >>This contains an implementation of generic PM domains for Tegra186,
> >>based on the BPMP powergate request.
> >>
> >>----------------------------------------------------------------
> >>Christophe Jaillet (1):
> >>       soc/tegra: flowctrl: Fix error handling
> >>
> >>Thierry Reding (3):
> >>       PM / Domains: Allow overriding the ->xlate() callback
> >>       soc/tegra: bpmp: Update ABI header
> >>       soc/tegra: bpmp: Implement generic PM domains
> >>
> >>  drivers/base/power/domain.c        |   8 +-
> >>  drivers/firmware/tegra/bpmp.c      |   4 +
> >>  drivers/soc/tegra/Kconfig          |   5 +
> >>  drivers/soc/tegra/Makefile         |   1 +
> >>  drivers/soc/tegra/flowctrl.c       |   2 +-
> >>  drivers/soc/tegra/powergate-bpmp.c | 359 +++++++++++++++++++++++++++++++
> >>  include/linux/pm_domain.h          |   4 +
> >>  include/soc/tegra/bpmp-abi.h       | 418 ++++++++++++++++++++++++++++++++++++-
> >>  include/soc/tegra/bpmp.h           |  12 ++
> >
> >Merged, but does the bpmp-abi.h really belong in include/soc? Seems like most
> >of it is internal ABI for whatever abstraction communicates with bpmp, in this
> >case powergate. Locating it as a headerfile under drivers/soc/tegra/ seems to
> >make more sense. Care to move it?
> 
> The header is used by all drivers that communicate with the BPMP, and they
> are scattered around the tree in their corresponding modules - e.g.
> drivers/clk/tegra/clk-bpmp.c, or the upcoming
> drivers/thermal/tegra/bpmp-thermal.c.

Having to expose the command format to all drivers seems a bit odd, compared to
providing helpers from drivers/soc to perform the commands/actions.

I guess most users aren't in-tree yet (tried grepping around for some of the
struct names and found no users), so I guess we'll see over time how it
develops. It could always be refactored later, if needed.


-Olof
