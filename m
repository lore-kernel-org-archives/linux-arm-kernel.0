From: michal.morawiec@tieto.com (Michal Morawiec)
Date: Sat, 21 Nov 2015 03:04:14 +0100
Subject: [PATCH 1/1] soc: ti: knav_qmss_queue: Fix linking RAM setup for
 queue managers
In-Reply-To: <564FB11A.3020906@oracle.com>
References: <1448062781-6708-1-git-send-email-michal.1.morawiec.ext@nokia.com>
 <564FB11A.3020906@oracle.com>
Message-ID: <20151121020414.GB5701@michal-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 03:47:38PM -0800, santosh shilimkar wrote:
> On 11/20/2015 3:39 PM, Michal Morawiec wrote:
> >Configure linking RAM for both queue managers also in case
> >when only linking RAM 0 is specified in device tree.
> >
> why ?
If both queue managers are used then both must be configured
with valid linking RAM configuration independent of the number
of linking RAMs used. If the configuration for the QM2 is
missing there will be a crash when it tries push/pop descriptors
from its queues. That's what I encountered once I removed
linking RAM 1 from the device tree since it was not needed.
 
> >Signed-off-by: Michal Morawiec <michal.1.morawiec.ext@nokia.com>
> >---
> >  drivers/soc/ti/knav_qmss_queue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> >index 6d8646d..a809c30 100644
> >--- a/drivers/soc/ti/knav_qmss_queue.c
> >+++ b/drivers/soc/ti/knav_qmss_queue.c
> >@@ -1173,7 +1173,7 @@ static int knav_queue_setup_link_ram(struct knav_device *kdev)
> >
> >  		block++;
> >  		if (!block->size)
> >-			return 0;
> >+			continue;
> >
> You have to expand this a bit for me. Because you really don't
> want kernel code to run the configuration on hardware which doesn't
> exist. I mean device tree suppose to specify the linking RAM for both
> QMs unless and until there is a reason not too.
If I understand the current handling in the driver correctly
the linking RAM(s) is/are used cooperatively by QMs (shared mode).
So every linking RAM specified in the device tree must be
configured exactly the same for both QMs (base addres and size).
If there is only one linking RAM specified then only this one
must be configured for both QMs.
For proper operation only one linking RAM is required and in most
cases this can be internal one as long as it is able to handle 
the number of descriptors used in the system.
That was the case for me so I moved all regions so that they all
fit into one internal linking RAM and removed entry for external
linking RAM. Current driver code however skips configuration of
second queue manager if second linking RAM is not specified.

Referring to the configuration of the missing hardware you
mentioned I don't think there is anything missing. It's just
one resource less used by the HW (QMs).

I hope this explains the intention of my patch.

wbr,
Michal
