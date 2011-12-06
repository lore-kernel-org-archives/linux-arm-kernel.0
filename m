From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 6 Dec 2011 14:44:44 +0100
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c: don't
 munge MAC address from platform data
In-Reply-To: <20111206124857.GB14048@sapphire.tkos.co.il>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <55b78c1766da5b0d0d679f5eae3fb9fc74a6ceef.1323163127.git.LW@KARO-electronics.de>
 <20111206124857.GB14048@sapphire.tkos.co.il>
Message-ID: <20190.7244.156557.313315@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Baruch Siach writes:
> Hi Lothar,
> 
> On Tue, Dec 06, 2011 at 11:27:13AM +0100, Lothar Wa?mann wrote:
> > When the MAC address is supplied via platform_data it should be OK as
> > it is and should not be modified in case of a dual FEC setup.
> > Also copying the MAC from platform_data to the single 'macaddr'
> > variable will overwrite the MAC for the first interface in case of a
> > dual FEC setup.
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  drivers/net/ethernet/freescale/fec.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> > index e2b5ce6..11534b9 100644
> > --- a/drivers/net/ethernet/freescale/fec.c
> > +++ b/drivers/net/ethernet/freescale/fec.c
> > @@ -818,7 +818,7 @@ static void __inline__ fec_get_mac(struct net_device *ndev)
> >  			iap = (unsigned char *)FEC_FLASHMAC;
> >  #else
> >  		if (pdata)
> > -			memcpy(iap, pdata->mac, ETH_ALEN);
> > +			iap = (unsigned char *)&pdata->mac;
> 
> Since pdata might point to __initdata struct, you must hold a copy of its 
> content.
> 
No. platform_data must be present during the life time of a driver
using it and thus must never be __initdata!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
