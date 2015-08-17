From: yao.yuan@freescale.com (Yao Yuan)
Date: Mon, 17 Aug 2015 03:59:41 +0000
Subject: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <CADRPPNS_wzX+mwT0L-H=ZP9w8gH9W4O9KUqnGYiAc39S5v4qLA@mail.gmail.com>
References: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>
 <CADRPPNQJi_x+mdQV=DEVuhCL_p6VOWcPiV3jzioeRdWgSW2w3g@mail.gmail.com>
 <CY1PR0301MB15628DD5CFCE2B65BF4FECB2837C0@CY1PR0301MB1562.namprd03.prod.outlook.com>
 <CADRPPNS_wzX+mwT0L-H=ZP9w8gH9W4O9KUqnGYiAc39S5v4qLA@mail.gmail.com>
Message-ID: <CY1PR0301MB1562103588FB0C6BEFDDBF3C83790@CY1PR0301MB1562.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 15, 2015 at 7:48 AM, pku.leo < pku.leo@gmail.com > wrote:
> On Fri, Aug 14, 2015 at 1:24 AM, Yao Yuan <yao.yuan@freescale.com> wrote:
> > Hi Leo,
> >
> > Thanks for your review.
> > About those two methods for DMA suspend that you have mentioned. We
> have a lot of the discussions in other DMA driver like DMA for Freescale
> PowerPC.
> >
> > Finally, we think the device which used the DMA transmission service should
> cancel the transmission service in its suspend.
> > So DMA in suspend should be idle.
> 
> If that's the case you should clearly state this in the commit message and in
> code, although I don't know if it is safe to make such assumption.  There could
> be user of the DMA that doesn't track the completion of transfers.

I think it should be safe. In my opinion, even some client(the user of the DMA) forget to cancel its DMA transmission,
It will just lead to PM failed but no other system and data risk.
Although we should first fix the behavior of the client.
Once you are no need the DMA transmission, why not stop it?

Is it right?

> >
> > Once the DMA in late_suspend is not be idle, we think some driver haven't
> canceled the DMA transmission. So maybe something is error when other
> driver in suspend.
> >
> > In the case, we should return failed to stop PM. DMA should not make a
> choice for other drivers(which used DMA) to force stop DMA transmission.
> 
> The suspend entrance should be terminated by wakeup events and only critical
> issues.  I don't think we should just terminate the suspend entrance just
> because having on-going I/O without even try to stop it.

The graceful behavior would be to for client to PAUSE or terminate and then suspend
followed by DMA suspend.
We need to rely on client doing the right thing here. 
The DMA should not make a decision instead of client.
If the DMA is not idle in DMA suspend, it should be the client's issue.
We don't know what the client really want to do, so just return the non-success value.

I'm not sure my description is clear.  So we may refer the discussion about the DMA PM support before.
Such as "DMA: Freescale: add suspend resume functions for DMA driver"

Like:https://lkml.org/lkml/2014/5/21/1

> >
> > Thanks.
> >
> > Best Regards,
> > Yuan Yao
> >
> >> -----Original Message-----
> >> From: pku.leo at gmail.com [mailto:pku.leo at gmail.com] On Behalf Of Li
> >> Yang
> >> Sent: Friday, August 14, 2015 4:58 AM
> >> To: Yuan Yao-B46683
> >> Cc: Vinod Koul; stefan at agner.ch; Arnd Bergmann; Dan Williams;
> >> dmaengine at vger.kernel.org; lkml;
> >> linux-arm-kernel at lists.infradead.org; linux- pm at vger.kernel.org
> >> Subject: Re: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume
> >> support
> >>
> >> On Tue, Jul 21, 2015 at 3:56 AM, Yuan Yao <yao.yuan@freescale.com> wrote:
> >> > This add power management suspend/resume support for the fsl-edma
> >> > driver.
> >> >
> >> > eDMA acted as a basic function used by others. What it needs to do
> >> > is the two steps below to support power management.
> >> >
> >> > In fsl_edma_suspend_late:
> >> > Check whether the DMA chan is idle and if it is not idle, stop PM
> >> > operation.
> >>
> >> You should try to quiesce the device on suspend instead of depending
> >> on itself to be happen in idle and failing if it is not.
> >>
> >> Regards,
> >> Leo
> 
> 
> 
> --
> - Leo
