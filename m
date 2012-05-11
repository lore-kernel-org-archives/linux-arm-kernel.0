From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 11 May 2012 11:03:09 +0300
Subject: [RFC 1/1] Driver Core: don't oops with unregistered driver in
 driver_find_device()
In-Reply-To: <4FAC4280.4000100@wwwdotorg.org>
References: <1336635302-29260-1-git-send-email-hdoyu@nvidia.com>
 <20120510141130.GA20373@kroah.com> <4FABE5D3.9040706@wwwdotorg.org>
 <20120510181611.GA16908@kroah.com> <4FAC1E70.8030907@wwwdotorg.org>
 <20120510222830.GA23084@kroah.com> <4FAC4280.4000100@wwwdotorg.org>
Message-ID: <20120511110309.10beedca497a1af966f94cd8@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Stephen for explaining the background of this patch.

On Fri, 11 May 2012 00:34:40 +0200
Stephen Warren <swarren@wwwdotorg.org> wrote:

> On 05/10/2012 04:28 PM, Greg Kroah-Hartman wrote:
> > On Thu, May 10, 2012 at 02:00:48PM -0600, Stephen Warren wrote:
> >> On 05/10/2012 12:16 PM, Greg Kroah-Hartman wrote:
> >>> On Thu, May 10, 2012 at 09:59:15AM -0600, Stephen Warren wrote:
> >>>> On 05/10/2012 08:11 AM, Greg Kroah-Hartman wrote:
> >>>>> On Thu, May 10, 2012 at 10:35:02AM +0300, Hiroshi DOYU wrote:
> >>>>>> driver_find_device() can be called with an unregistered driver.
...
> > Can someone resend this to me, with the information above in the
> > changelog comment, and I'll be glad to apply it?  Again, I need to know
> > if this is needed for 3.4 or it can wait for 3.5?
> 
> I'll let Hiroshi do that.

Greg, here's the update patch with the above explanation. Please take
this one if the following explanation makes sense.

>From d7cf9b53d3bbcce75ae55a9eed03c7e091529e3d Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <hdoyu@nvidia.com>
Date: Wed, 9 May 2012 14:21:03 +0300
Subject: [PATCH 1/1] Driver Core: don't oops with unregistered driver in
 driver_find_device()

driver_find_device() can be called with an unregistered driver. Need
to check driver_private to see if it's populated or not, especially
under deferrable probe.

In the case that there are 2 drivers, one depends on the other. With
-EPROBE_DEFER, two drivers can use deferred probe to ensure that their
relative probe order doesn't matter. If dependee driver is probed
first, then the dependant's driver_find_device('dependee')
succeeds. If the dependant is probed first, then the dependant's
driver_find_device('dependee') should return NULL, and the dependant
should get -EPROBE_DEFER. driver_find_device() needs to return NULL if
it's not populated.

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
In [PATCHv5 2/3] ARM: tegra: Add SMMU enabler in AHB:
  http://article.gmane.org/gmane.linux.ports.tegra/4658

"tegra_ahb_driver" may not be populated when it's called.

For more SMMU/AHB specific discussion, refer to the following thread:
  https://lkml.org/lkml/2012/5/10/21
---
 drivers/base/driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 3ec3896..207c27d 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -80,7 +80,7 @@ struct device *driver_find_device(struct device_driver *drv,
 	struct klist_iter i;
 	struct device *dev;
 
-	if (!drv)
+	if (!drv || !drv->p)
 		return NULL;
 
 	klist_iter_init_node(&drv->p->klist_devices, &i,
-- 
1.7.5.4
