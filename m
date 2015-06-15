From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 15 Jun 2015 17:54:41 +0200
Subject: [PATCH 1/2] net: mvneta: introduce tx_csum_limit property
In-Reply-To: <20150615164952.4f2f4dab@free-electrons.com>
References: <1434378443-23029-1-git-send-email-simon.guinot@sequanux.org>
 <1434378443-23029-2-git-send-email-simon.guinot@sequanux.org>
 <20150615164952.4f2f4dab@free-electrons.com>
Message-ID: <20150615155440.GS4853@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 04:49:52PM +0200, Thomas Petazzoni wrote:
> Dear Simon Guinot,
> 
> On Mon, 15 Jun 2015 16:27:22 +0200, Simon Guinot wrote:
> > This patch introduces the tx_csum_limit DT property. This allows to
> > configure the maximum frame size for which the Ethernet controller is
> > able to perform TCP/IP checksumming. If MTU is set to a value greater
> > than tx_csum_limit, then the features NETIF_F_IP_CSUM and NETIF_F_TSO
> > are disabled.
> > 
> > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > Cc: <stable@vger.kernel.org> # v3.8+
> > ---
> >  .../bindings/net/marvell-armada-370-neta.txt       |  3 +++
> >  drivers/net/ethernet/marvell/mvneta.c              | 25 +++++++++++++++++++++-
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> > index 750d577e8083..db48c83ff0f5 100644
> > --- a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> > +++ b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> > @@ -8,6 +8,9 @@ Required properties:
> >  - phy-mode: See ethernet.txt file in the same directory
> >  - clocks: a pointer to the reference clock for this device.
> >  
> > +Optional properties:
> > +- tx_csum_limit: max tx packet size for hardware checksum.
> 
> To be honest, I'd prefer to have a different compatible string to
> identify the two different versions of the hardware block.
> 
> The current armada-370-neta would limit the HW checksumming features to
> packets smaller than 1600 bytes, while a new armada-xp-neta would not
> have this limit.

This was also my first idea. But by doing this, we take the risk of
losing the HW checksumming feature with jumbo frames on some currently
working Armada XP setups. This may happen for example if a user is able
to update the kernel but not the on-board DTB. In order to fix a feature
on a SoC, we are breaking the DTB-kernel compatibility for the very same
feature on an another SoC. I am not sure it is OK.

Are you comfortable with that ?

By adding a new optional property, at least we ensure that the things
will still work the same way with Armada-XP SoCs (for every DTB-Linux
combination).

Please, let me know if you still want to introduce a compatible string
for Armada-XP.

Simon

> 
> Yet another case where we should have used "armada-<soc>-neta",
> "armada-370-neta" in the .dtsi files for each SoC so that such
> modification do not require changing the Device Trees.
> 
> Best regards,
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150615/9b2f02fe/attachment.sig>
