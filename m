From: olof@lixom.net (Olof Johansson)
Date: Sat, 22 Sep 2012 14:36:42 -0700
Subject: [GIT PULL V5 0/7] ARM: kirkwood/dove/mvebu changes for v3.7
In-Reply-To: <20120922171554.GE5469@titan.lakedaemon.net>
References: <20120922171554.GE5469@titan.lakedaemon.net>
Message-ID: <20120922213642.GA10355@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 01:15:54PM -0400, Jason Cooper wrote:
> Arnd, Olof,
> 
> Changes from V3/V4 (only one pullrq reached V4).
>  - split kirkwood/dt into /dt and /drivers.
>  - /drivers now holds pinctrl and gpio
>  - dropped ehci-orion dt bindings until next window
>  - reworked dependency matrix
> 
> Dep tree:
> 
>         /--kirkwood/addr_decode--kirkwood/drivers
>         |
>         |--kirkwood/dt--kirkwood/cleanup--kirkwood/platform_data
>         |                                /
>         /                 /-------------/
> v3.6-rc5--kirkwood/boards-|
>                           \--kirkwood/defconfig

Thanks for reorganizing the branches so quickly!

If there's one thing I would request next time is to try to get
the cleanup branch closer to the base, and for example including the
annotation cleanups from the addr_decode branch in it. But it's not a big
deal this time around since I ended up doing things a little different
at our end.

So, I've done something that we normally try to avoid, and merged all
of these branches into one branch in arm-soc as late/kirkwood, that is
based on next/cleanup and next/multiplatform.

The main reason for this is that there's a bunch of minor conflicts
with the sweeping changes that went across the tree, and sorting them
all out in one place is easier than doing it in multiple places. We'll
end up merging kirkwood after the other branches but there shouldn't be
any significant risk of it not making it in since there are no external
dependencies that will hold us up.

This's not something we want to do often, since it defeats the purpose
of how we organize our tree to show common efforts across platforms.

To have avoided this, you should probably have used some of the cleanup
branches from arm-soc as starting points of your branches. For example the
cleanup pieces of addr_decode branch conflicts with the cleanup/io-pci
in arm-soc, so using the cleanup/io-pci branch as base would have
allowed you to resolve the conflicts when applying the patches.

Also, if you want to get a feel for what we will have to do at our end to
resolve merge conflicts in your branches when you send us pull requests,
feel free to do trial-merges of your branches into our for-next branch. Some
other maintainers do this as a heads up and gives us their preference of
conflict resolution.

Does that makes sense? Apologies for going back and forth a bit on this, we've
had a bit more across-all-platforms sweeping changes than usual this release
cycle so things have been a bit more complex than in a while.



I have done basic build testing of the Marvell configs to make sure that things
pass cleanly, and did one small fixup patch at the top of late/kirkwood to fix
one problem.

The one area where I'd like you to double-check my work and make sure that
things aren't broken is on the PCI stuff: There were changes in the pci
cleanup branch of how the IO is mapped, and some of the memory layouts
were modified and required fixups between that and the annotation cleanup
in the addr_decode branch.


-Olof
