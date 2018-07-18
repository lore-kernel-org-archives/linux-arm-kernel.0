From: dave.taht@gmail.com (Dave Taht)
Date: Wed, 18 Jul 2018 13:55:50 -0700
Subject: [PATCH net-next v2 3/7] net: mvneta: increase number of buffers
 in RX and TX queue
In-Reply-To: <87tvow8sho.fsf@bootlin.com>
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
 <20180713161841.11202-4-gregory.clement@bootlin.com>
 <20180713191720.GA17271@n2100.armlinux.org.uk>
 <87tvow8sho.fsf@bootlin.com>
Message-ID: <CAA93jw4ygBN9dLVL_rRr23+ZEFabEHiHBpDExQLj9V4E2LtekA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 8:39 AM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Hi Russell King,
>
>  On ven., juil. 13 2018, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>
> > On Fri, Jul 13, 2018 at 06:18:37PM +0200, Gregory CLEMENT wrote:
> >> From: Yelena Krivosheev <yelena@marvell.com>
> >>
> >> The initial values were too small leading to poor performance when using
> >> the software buffer management.
> >
> > What does this do to latency when a large transfer is also ongoing
> > (iow, the classic bufferbloat issue) ?
>
> IXIA latency test had been done without seeing any differences for long
> traffic (routing).

IXIA's tests in the latency under load area are pure rubbish. try
irtt, netperf, + flent (which wraps those)

https://github.com/heistp/irtt - with good one way delay measurements,
has been coming along nicely of late.

> These new values offer better performance for the main usage of this SoC
> (NAS applications), however both Rx and TX queues size can be change by
> ethtool.

BQL was added to this driver as of commit
a29b6235560a1ed10c8e1a73bfc616a66b802b90, with typical latencies below
2ms range. Is that not still the case? at a gbit, 1500 byte packets,
non-gso, that's a ring buffer size of ~155. So I can imagine that your
proposed larger ring buffer size for smaller packets might help, (was
your test using smaller packets?) and the usage of BQL should obscure
any change of latency seen by increasing the limit.

(in other words, assuming bql is working, go right ahead, increase tx
descriptors)

bqlmon can be used to monitor the state of bql.

as for rx, are you seeing drops under load due to overflowing it? When
I last looked at this
driver (in the pre-bql era), it did a lot of bulky processing in rx.

>
> Gregory
>
> >
> >>
> >> Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
> >> [gregory: extract from a larger patch]
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >> ---
> >>  drivers/net/ethernet/marvell/mvneta.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> >> index f4e3943a745d..c22df28b07c8 100644
> >> --- a/drivers/net/ethernet/marvell/mvneta.c
> >> +++ b/drivers/net/ethernet/marvell/mvneta.c
> >> @@ -295,10 +295,10 @@
> >>  #define MVNETA_RSS_LU_TABLE_SIZE    1
> >>
> >>  /* Max number of Rx descriptors */
> >> -#define MVNETA_MAX_RXD 128
> >> +#define MVNETA_MAX_RXD 512
> >>
> >>  /* Max number of Tx descriptors */
> >> -#define MVNETA_MAX_TXD 532
> >> +#define MVNETA_MAX_TXD 1024
> >>
> >>  /* Max number of allowed TCP segments for software TSO */
> >>  #define MVNETA_MAX_TSO_SEGS 100
> >> --
> >> 2.18.0
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> > --
> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
> > According to speedtest.net: 13Mbps down 490kbps up
>
> --
> Gregory Clement, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com



-- 

Dave T?ht
CEO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-669-226-2619
