From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Jul 2018 15:47:31 +0200
Subject: [PATCH v3 6/8] serial: Add Tegra Combined UART driver
In-Reply-To: <50c4702b-3d59-e443-5075-c888f83a2615@kapsi.fi>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-7-mperttunen@nvidia.com>
 <20180702131851.GH13096@ulmo>
 <50c4702b-3d59-e443-5075-c888f83a2615@kapsi.fi>
Message-ID: <20180702134731.GI13096@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 04:30:07PM +0300, Mikko Perttunen wrote:
> On 02.07.2018 16:18, Thierry Reding wrote:
> > On Mon, Jul 02, 2018 at 02:40:31PM +0300, Mikko Perttunen wrote:
> > > The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> > > multiplexing multiple "virtual UARTs" into a single hardware serial
> > > port. The TCU is the primary serial port on Tegra194 devices.
> > > 
> > > Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> > > are part of Tegra HSP blocks that are already controlled by the Tegra
> > > HSP mailbox driver.
> > > 
> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > > 
> > > Notes:
> > >      v2:
> > >      - Removed (void) casts for unused variables.
> > >      - Changed the uart_set_options() call to be on one line, even if its
> > >        over 80 characters.
> > >      - Added defines for magic numbers.
> > >      - Style fixes.
> > >      - Changed Kconfig entry to depend on the Tegra HSP driver instead of
> > >        just the mailbox framework.
> > >      v3:
> > >      - Removed FLUSH bit, as it's unnecessary and slows down printing
> > >      - Removed call to uart_set_options
> > >      - Added mbox_free_channel calls to remove()
> > > 
> > >   drivers/tty/serial/Kconfig       |   9 ++
> > >   drivers/tty/serial/Makefile      |   1 +
> > >   drivers/tty/serial/tegra-tcu.c   | 291 +++++++++++++++++++++++++++++++++++++++
> > >   include/uapi/linux/serial_core.h |   3 +
> > >   4 files changed, 304 insertions(+)
> > >   create mode 100644 drivers/tty/serial/tegra-tcu.c
> > 
> > The driver looks good to me. But for my own understanding, is there some
> > way we can make use of the multiplexing? That is, could we add a
> > mechanism to have the driver filter out only a specific stream? Could we
> > also specify which stream to send data back to? What happens by default?
> > Which stream is data sent to?
> 
> There is no multiplexing on the producer/device side (i.e. what this driver
> does). The mailbox specified in device tree specifies the stream we send
> stuff to. The mailboxes are per-CPU (we use the CCPLEX mailbox here), so it
> cannot really be changed.

Oh, I see, so there is one stream per pair of mailboxes? That is, the
mailboxes we specify in the DT define which stream we receive from and
send to?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/2c680b43/attachment-0001.sig>
