From: pratikp@codeaurora.org (Pratik Patel)
Date: Thu, 3 Jan 2013 11:32:22 -0800
Subject: CoreSight framework and drivers
In-Reply-To: <50E491D5.3080106@ti.com>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
 <20121219112314.GA26329@mudshark.cambridge.arm.com>
 <50D1F37E.6000804@ti.com>
 <20121219212431.GC23594@pratikp-linux.qualcomm.com>
 <50D34EE5.8090407@ti.com>
 <20121220195127.GA14877@pratikp-linux.qualcomm.com>
 <50D3972E.4030607@ti.com>
 <20121221221828.GA2658@pratikp-linux.qualcomm.com>
 <50E491D5.3080106@ti.com>
Message-ID: <20130103193222.GC30277@pratikp-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 02, 2013 at 02:00:21PM -0600, Jon Hunter wrote:
> 
> The code is largely based upon the existing cti helpers, which just had
> a cti_map_trigger() function. The use-case you described is not
> supported by the current helpers and so also not supported in my initial
> implementation (although we should add this). Hence, it would be
> probably best to split the cti_map_trigger() into two functions say,
> cti_map_triggerin() and cti_map_triggerout(), to map a trigger
> input/output to a channel.
> 

Yes, splitting the map function will provide more flexibility.
One possibility is to cue the enable and disable functions from
the mapping reference count for the CTI so that enable and
disable are internal only functions.

In this case the flow would look something like:

cti_get(cti1)
cti_map_triggerin(cti1) -> enable cti1
cti_get(cti2)
cti_map_triggerin(cti2) -> enable cti2
cti_map_triggerout(cti1) -> increment cti1 refcount

cti_unmap_triggerin(cti2) -> disable cti2
cti_put(cti2)
cti_unmap_triggerout(cti1) -> decrement cti1 refcount
cti_unmap_triggerin(cti1) -> disable cti1
cti_put(cti1)

With this, it is possible to push clock management inside enable
and disable as opposed to get and put though it would imply
enable being done before the actual mapping inside
cti_map_triggerin/out and disable after unmapping in
cti_unmap_triggerin/out. It might also mean cti_map_triggerin/out
and cti_unmap_triggerin/out having a non-atomic context call
semantics.

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
