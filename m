From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 30 Jul 2015 11:34:49 +0200
Subject: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend
 to ram/disk
In-Reply-To: <CY1PR0301MB0843EC6EA393B4E5BC15FB9C838B0@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1438203535-38028-1-git-send-email-shenwei.wang@freescale.com>
 <CAOMZO5Aj5PASPKRq47vmenDBSPMPHdLgSbJZXkhZu3MNYprqXA@mail.gmail.com>
 <CY1PR0301MB0843BEF6A40A0A28018E0D5D838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <CAOMZO5DaZ+1Ud0RAX2RELz5c0zyZUo_X1y50gY2XwM5o0BeVmg@mail.gmail.com>
 <CY1PR0301MB08437D6E977C99821622976A838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <CAOMZO5Drw9SAnocz2pBY2RhuQE7HbFrvdXhSWEqjiwxgvq2pgQ@mail.gmail.com>
 <CY1PR0301MB0843EC6EA393B4E5BC15FB9C838B0@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <20150730113449.6c4743f2@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > -----Original Message-----
> > From: Fabio Estevam [mailto:festevam at gmail.com]
> > Sent: 2015?7?29? 17:11
> > To: Wang Shenwei-B38339
> > Cc: Greg Kroah-Hartman; linux-arm-kernel at lists.infradead.org;
> > linux-serial at vger.kernel.org
> > Subject: Re: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend to
> > ram/disk
> > 
> > On Wed, Jul 29, 2015 at 6:54 PM, Shenwei Wang <Shenwei.Wang@freescale.com>
> > wrote:
> > 
> > > I am very interesting to know if you could provide an example
> > > condition that may cause clk_enable failed in this callback function?
> > 
> > Let's check clk_enable definition:
> > 
> > int clk_enable(struct clk *clk)
> > {
> >     unsigned long flags;
> >     int ret;
> > 
> >     if (!clk)
> >         return 0;
> > 
> >     flags = clk_enable_lock();
> >     ret = clk_core_enable(clk->core);
> >     clk_enable_unlock(flags);
> > 
> >     return ret;
> > }
> > 
> > So if I see it right it returns 'int' not 'void' ;-)
> 
> Actually, the function shows even if it is in error status like the parameter "clk" is null the return value is zero. 
> Inside the function "clk_core_enable", if everything goes smooth, it still returns zero. 
> 
A NULL clk is a valid clk per definition.

> Moreover, this patch does not care about the return value of clk_enable, whatever value it returns, the following codes keep 
> the same.
>
Nevertheless it would be good to inform the user of a failure,
since that may affect the system's stability after returning from
suspend.
Even if the current implementation of a function cannot return an error
code in some specific circumstance, that doesn't mean that this will be
always the case. Thus, checking the return code and acting upon it is
always advisable.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
