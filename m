From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Fri, 23 Mar 2018 22:34:46 -0400
Subject: [PATCH v7 0/7] netdev: intel: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521849496.15055.16.camel@intel.com>
References: <1521831180-25014-1-git-send-email-okaya@codeaurora.org>
 <CAKgT0UcaxM8Mj9Y9fR0B+aafTm1SzTqh+gHT5ozgvyaoHvrzRQ@mail.gmail.com>
 <1521849496.15055.16.camel@intel.com>
Message-ID: <862cdbeafb9cfd272a426b010943ffc5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-23 19:58, Jeff Kirsher wrote:
> On Fri, 2018-03-23 at 14:53 -0700, Alexander Duyck wrote:
>> On Fri, Mar 23, 2018 at 11:52 AM, Sinan Kaya <okaya@codeaurora.org>
>> wrote:
>> > Code includes wmb() followed by writel() in multiple places. writel()
>> > already has a barrier on some architectures like arm64.
>> >
>> > This ends up CPU observing two barriers back to back before executing
>> > the
>> > register write.
>> >
>> > Since code already has an explicit barrier call, changing writel() to
>> > writel_relaxed().
>> >
>> > I did a regex search for wmb() followed by writel() in each drivers
>> > directory.
>> > I scrubbed the ones I care about in this series.
>> >
>> > I considered "ease of change", "popular usage" and "performance
>> > critical
>> > path" as the determining criteria for my filtering.
>> >
>> > We used relaxed API heavily on ARM for a long time but
>> > it did not exist on other architectures. For this reason, relaxed
>> > architectures have been paying double penalty in order to use the
>> > common
>> > drivers.
>> >
>> > Now that relaxed API is present on all architectures, we can go and
>> > scrub
>> > all drivers to see what needs to change and what can remain.
>> >
>> > We start with mostly used ones and hope to increase the coverage over
>> > time.
>> > It will take a while to cover all drivers.
>> >
>> > Feel free to apply patches individually.
>> 
>> I looked over the set and they seem good.
>> 
>> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Grrr, patch 1 does not apply cleanly to my next-queue tree (dev-queue
> branch).  I will deal with this series in a day or two, after I have 
> dealt
> with my driver pull requests.

Sorry, you will have to replace the ones you took from me.
> 
>> >
>> > Changes since v6:
>> > clean up between 2..6 and then make your Alex's changes on 1 and 7
>> >     The mmiowb shouldn't be needed for Rx. Only one CPU will be running
>> >     NAPI for the queue and we will synchronize this with a full writel
>> >     anyway when we re-enable the interrupts.
>> >
>> > Sinan Kaya (7):
>> >   i40e/i40evf: Eliminate duplicate barriers on weakly-ordered archs
>> >   ixgbe: eliminate duplicate barriers on weakly-ordered archs
>> >   igbvf: eliminate duplicate barriers on weakly-ordered archs
>> >   igb: eliminate duplicate barriers on weakly-ordered archs
>> >   fm10k: Eliminate duplicate barriers on weakly-ordered archs
>> >   ixgbevf: keep writel() closer to wmb()
>> >   ixgbevf: eliminate duplicate barriers on weakly-ordered archs
>> >
>> >  drivers/net/ethernet/intel/fm10k/fm10k_main.c     |  4 ++--
>> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 14 ++++++++++----
>> >  drivers/net/ethernet/intel/i40evf/i40e_txrx.c     |  4 ++--
>> >  drivers/net/ethernet/intel/igb/igb_main.c         |  4 ++--
>> >  drivers/net/ethernet/intel/igbvf/netdev.c         |  4 ++--
>> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  8 ++++----
>> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  5 -----
>> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 11 ++++++++---
>> >  8 files changed, 30 insertions(+), 24 deletions(-)
>> >
>> > --
>> > 2.7.4
>> >
