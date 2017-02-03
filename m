From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 3 Feb 2017 16:30:03 +0530
Subject: [PATCH 3/6] async_tx: Handle DMA devices having support for fewer
 PQ coefficients
In-Reply-To: <CAPcyv4gBFu7skx_8cvsaL0sL5=44DMcWY_EjWSCfaNd8oh=Svw@mail.gmail.com>
References: <1486010836-25228-1-git-send-email-anup.patel@broadcom.com>
 <1486010836-25228-4-git-send-email-anup.patel@broadcom.com>
 <CAPcyv4gBFu7skx_8cvsaL0sL5=44DMcWY_EjWSCfaNd8oh=Svw@mail.gmail.com>
Message-ID: <CAALAos_9uuOVG8zVY4KLY+AeuOCv+rTsF6uM-WLFxf6TM8GRPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2017 at 11:31 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Feb 1, 2017 at 8:47 PM, Anup Patel <anup.patel@broadcom.com> wrote:
> > The DMAENGINE framework assumes that if PQ offload is supported by a
> > DMA device then all 256 PQ coefficients are supported. This assumption
> > does not hold anymore because we now have BCM-SBA-RAID offload engine
> > which supports PQ offload with limited number of PQ coefficients.
> >
> > This patch extends async_tx APIs to handle DMA devices with support
> > for fewer PQ coefficients.
> >
> > Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > ---
> >  crypto/async_tx/async_pq.c          |  3 +++
> >  crypto/async_tx/async_raid6_recov.c | 12 ++++++++++--
> >  include/linux/dmaengine.h           | 19 +++++++++++++++++++
> >  include/linux/raid/pq.h             |  3 +++
> >  4 files changed, 35 insertions(+), 2 deletions(-)
>
> So, I hate the way async_tx does these checks on each operation, and
> it's ok for me to say that because it's my fault. Really it's md that
> should be validating engine offload capabilities once at the beginning
> of time. I'd rather we move in that direction than continue to pile
> onto a bad design.

Yes, indeed. All async_tx APIs have lot of checks and for high throughput
RAID offload engine these checks can add some overhead.

I think doing checks in Linux md would be certainly better but this would
mean lot of changes in Linux md as well as remove checks in async_tx.

Also, async_tx APIs should not find DMA channel on its own instead it
should rely on Linux md to provide DMA channel pointer as parameter.

It's better to do checks cleanup in async_tx as separate patchset and
keep this patchset simple.

Regards,
Anup
