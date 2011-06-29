From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 29 Jun 2011 18:04:37 +0300
Subject: [RFC 2/8] remoteproc: add omap implementation
In-Reply-To: <20110627210007.GC20865@ponder.secretlab.ca>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-3-git-send-email-ohad@wizery.com>
	<20110627210007.GC20865@ponder.secretlab.ca>
Message-ID: <BANLkTi=4Pp1UYWFsBywRvLL1n=ggCZgAeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 12:00 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Very little for me to comment on here. ?However, something I just
> noticed. ?Why is it necessary to pass in THIS_MODULE to the
> rproc_register function? ?Having a reference to the pdev gives you the
> pointer to the driver, which has the THIS_MODULE value in it. ?That
> should be sufficient.

Nice one, thanks !

> /me also isn't sure if incrementing the refcount on the module is the
> best way to prevent the rproc from going away, but I haven't dug into
> the details in the driver code to find out. ?Drivers can get unbound
> from devices without the driver being unloaded, so I imagine there is
> an in-use count on the device itself that would prevent driver
> unbinding.

Yes, increasing the module refcount is necessary to prevent the user
from removing the driver when the rproc is used.

If the underlying device goes away while rproc is used, then
rproc_unregister should return -EBUSY, which would fail the underlying
driver's ->remove() handler (gpiolib is doing something very similar).
I have forgotten to add this check, and will add it now.

Thanks !
