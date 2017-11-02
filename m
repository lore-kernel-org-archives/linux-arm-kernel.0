From: qiang.zhao@nxp.com (Qiang Zhao)
Date: Thu, 2 Nov 2017 01:40:04 +0000
Subject: [Patch v10] QE: remove PPCisms for QE
In-Reply-To: <b9a491c9-c7f9-3062-8c85-468c1a94ba0d@arm.com>
References: <20171101020133.27966-1-qiang.zhao@nxp.com>
 <b9a491c9-c7f9-3062-8c85-468c1a94ba0d@arm.com>
Message-ID: <AM3PR04MB11855D1C194163038E1E34F8915C0@AM3PR04MB1185.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/17 05:19PM, Julien Thierry <julien.thierry@arm.com> wrote:
> -----Original Message-----
> From: Julien Thierry [mailto:julien.thierry at arm.com]
> Sent: Wednesday, November 01, 2017 5:19 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>; oss at buserror.net
> Cc: linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [Patch v10] QE: remove PPCisms for QE
> 
> Hi Zhao,
> 
> I just noticed a small nit.
> 
> >   	/* wait for the QE_CR_FLG to clear */
> > -	ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG)
> == 0,
> > -			   100, 0);
> > +	ret = -EIO;
> > +	for (i = 0; i < 100; i++) {
> > +		if ((ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0) {
> > +			ret = 0;
> > +			break;
> > +		}
> > +		udelay(1);
> > +	}
> > +
> >   	/* On timeout (e.g. failure), the expression will be false (ret == 0),
> >   	   otherwise it will be true (ret == 1). */
> 
> nit:
> The comment here is no longer valid, on timeout ret == -EIO and on success 0. It
> should probably be removed to avoid confusion.

So thank you for you reminder, I ignored it, and will fix in the next version.
 
BR
-Qiang Zhao
