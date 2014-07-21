From: balbi@ti.com (Felipe Balbi)
Date: Mon, 21 Jul 2014 10:58:53 -0500
Subject: [PATCH 0/9] usb: musb: several bugfixes for the musb driver
In-Reply-To: <20140721155352.GA20226@arch.cereza>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <20140718161636.GA18460@arch.cereza>
 <20140718165044.GA30821@saruman.home>
 <20140721093430.3f528cc7@ipc1.ka-ro>
 <20140721151140.GG6852@saruman.home>
 <20140721155352.GA20226@arch.cereza>
Message-ID: <20140721155853.GK6852@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 12:53:52PM -0300, Ezequiel Garcia wrote:
> On 21 Jul 10:11 AM, Felipe Balbi wrote:
> > On Mon, Jul 21, 2014 at 09:34:30AM +0200, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > Felipe Balbi wrote:
> > > > Hi,
> > > > 
> > > > On Fri, Jul 18, 2014 at 01:16:36PM -0300, Ezequiel Garcia wrote:
> > > > > Hi Lothar,
> > > > > 
> > > > > On 18 Jul 11:31 AM, Lothar Wa?mann wrote:
> > > > > > The first three patches do some source code cleanup in the files that
> > > > > > are modified in the subsequent patches.
> > > > > > 
> > > > > 
> > > > > I've applied patches 4 and 9 on a recent -next, after fixing a conflict
> > > > > due to patch 3 ("usb: musb_am335x: source cleanup"):
> > > > > 
> > > > > > Patch 4 carries the proper fix reported in commit:
> > > > > >         7adb5c876e9c ("usb: musb: Fix panic upon musb_am335x module removal")
> > > > > > 
> > > > > > Patch 9 reinstates module unloading support for the musb_am335x driver
> > > > > >         which was disabled due to a false failure analysis
> > > > > > 
> > > > > 
> > > > > For these two patches, Tested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > > > 
> > > > > Tested on a beaglebone with a mass storage USB device, module load/unload
> > > > > works without issues. The module_get/put in the phy is now preventing the
> > > > > musb_am335x driver unload, which seems to be the real cause of the issue
> > > > > I reported. Thanks for providing a proper fix!
> > > > 
> > > > I don't that's a good fix. The problem is that even after am335x
> > > > removing all its child, someone else tried to release the PHY. That
> > > > ordering is the one that needs to be fixed. Doing a module_get on the
> > > > parent device looks like a hack to me.
> > > > 
> > > No. It guarantees that the module cannot be unloaded when its resources
> > > are still in use!
> > 
> > it's still a hack. You have a child incrementing the usage count on its
> > parent just because a sibbling isn't doing the right thing.
> > 
> 
> How about having the musb_am335x (glue driver) call request_module and
> module_get on the phy-am335x? Wouldn't this be a cleaner approach?
> 
> I haven't checked if this possible, though.

at most, you would have the phy layer do that so that all PHYs get usage
counter incremented when they're in use. We can't have this 'fixed' for
MUSB only.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/4de6e2bb/attachment-0001.sig>
