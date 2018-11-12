From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 12 Nov 2018 16:30:14 +0100
Subject: [PATCH 7/9] serial: Add Tegra Combined UART driver
In-Reply-To: <20181109170526.GB14151@kroah.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-8-thierry.reding@gmail.com>
 <20181109170526.GB14151@kroah.com>
Message-ID: <20181112153014.GA29481@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2018 at 09:05:26AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Oct 26, 2018 at 01:16:36PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> > multiplexing multiple "virtual UARTs" into a single hardware serial
> > port. The TCU is the primary serial port on Tegra194 devices.
> > 
> > Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> > are part of Tegra HSP blocks that are already controlled by the Tegra
> > HSP mailbox driver.
> > 
> > Based on work by  Mikko Perttunen <mperttunen@nvidia.com>.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks. I just sent out v2 addressing Pekka's comments on the series.
But I'm slightly confused now. Are you expecting anyone else to pick
this up? There are technically no build time dependencies between any
of these patches, so it should be fine to pick them all into the
corresponding subsystem trees.

Perhaps the only thing to note is that there is a runtime dependency
from this patch on patches 1 and 2 in the series. Patch 1 is required to
make blocking a mailbox possible in interrupt context, which we need in
the TCU driver because the TTY and console paths do end up calling the
mbox_send_message() from interrupt context. Patch 2 is only required at
runtime if the two mailboxes are provided by different instances of the
HSP block (which they are for TCU on Tegra194).

Would you prefer for Jassi to pick up the TCU patch along with the
mailbox core and driver changes so that we deal with the runtime
dependencies that way?

Alternatively, if Jassi is okay with the mailbox changes, I can pick up
all of the v2 series of the patches into stable branches for v4.21, deal
with the dependencies there and send out pull requests for everyone to
merge into their subsystem trees.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181112/e932ef52/attachment.sig>
