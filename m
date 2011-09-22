From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 22 Sep 2011 15:19:01 -0600
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110922212909.49966cf4@lxorguk.ukuu.org.uk>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110922212909.49966cf4@lxorguk.ukuu.org.uk>
Message-ID: <CACxGe6vAQ+_SKc-zH434bdd3akM5S1jB0N7+AFEjgZfX1uNrZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 2:29 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Definitely what is needed for some of the x86 SoC stuff and would let us
> rip out some of the special case magic for the SCU discovery.
>
> First thing that strikes me is driver_bound kicks the processing queue
> again. That seems odd - surely this isn't needed because any driver that
> does initialise this time and may allow something else to get going will
> queue the kick itself. Thus this seems to just add overhead.
>
> It all looks a bit O(N?) if we don't expect the drivers that might
> trigger something else binding to just say 'hey I'm one of the
> troublemakers'

The way I read it, absolute worst case is when every device but one
depends on another device.  In that case I believe it will be
O(Nlog(N)).  (Every device gets probed on the first pass, but only the
last one gets probed.  Then it goes through N-1 devices to the result
of only 1 more device getting probed, then N-2, etc.).  Actual usage
won't be anywhere near that complexity because there tends to be a
small number of devices on these SoCs that a lot of other devices
depend on, so I expect that there will be somewhere on the order of
3-4 passes for the typical embedded SoCs that I've seen.

driver_bound is used to kick off the process because anytime a new
device becomes active (bound to a driver), there is a high likelyhood
that one of the devices in the pending list can now be probed.
However, the re-probing is performed in a workqueue to make sure that
it is somewhat serialized to prevent the *entire* pending list to be
processed for every driver_bound() call.  Instead, by kicking a
workqueue, it guarantees that all the pending items are retried, but
kicking the workqueue 6 times doesn't mean that the list is going to
be processed 6 times.

In other words, driver_bound will kick off the process, but it doesn't
actually do the re-probing work.

g.
