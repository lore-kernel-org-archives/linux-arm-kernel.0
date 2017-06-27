From: leoyang.li@nxp.com (Leo Li)
Date: Tue, 27 Jun 2017 16:47:25 +0000
Subject: [PATCH] soc/qman: Sleep instead of stuck hacking jiffies.
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD002B1A5@AcuExch.aculab.com>
References: <1498403622-2878-1-git-send-email-karim.eshapa@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD002B1A5@AcuExch.aculab.com>
Message-ID: <AM4PR0401MB1699119BCAAB631C16D86C2D8FDC0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+leoli=freescale.com at lists.ozlabs.org] On Behalf Of David Laight
> Sent: Monday, June 26, 2017 10:55 AM
> To: 'Karim Eshapa' <karim.eshapa@gmail.com>; oss at buserror.net
> Cc: Roy Pledge <roy.pledge@nxp.com>; linux-kernel at vger.kernel.org;
> Claudiu Manoil <claudiu.manoil@nxp.com>; colin.king at canonical.com;
> linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH] soc/qman: Sleep instead of stuck hacking jiffies.
> 
> From: Karim Eshapa
> > Sent: 25 June 2017 16:14
> > Use msleep() instead of stucking with
> > long delay will be more efficient.
> ...
> > --- a/drivers/soc/fsl/qbman/qman.c
> > +++ b/drivers/soc/fsl/qbman/qman.c
> > @@ -1084,11 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
> >  		 * entries well before the ring has been fully consumed, so
> >  		 * we're being *really* paranoid here.
> >  		 */
> > -		u64 now, then = jiffies;
> > -
> > -		do {
> > -			now = jiffies;
> > -		} while ((then + 10000) > now);
> > +		msleep(1);
> ...
> How is that in any way equivalent?
> If HZ is 1000 the old code loops for 10 seconds.
> If HZ is 250 (common for some distros) it loops for 40 seconds.
> 
> Clearly both are horrid, but it isn't at all clear that a 1ms sleep is performing
> the same job.
> 
> My guess is that this code is never called, and broken if actually called.

It was indeed broken.  The intent was to wait for 10000 cycles but mistakenly coded as 10000 jiffies.  I think we choose 1ms as it is not too long and almost guarantees the 10000 cycles delay.

Regards,
Leo
