From: nigel@nigelcunningham.com.au (Nigel Cunningham)
Date: Mon, 17 Aug 2015 16:48:49 +1000
Subject: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <CY1PR0301MB1562103588FB0C6BEFDDBF3C83790@CY1PR0301MB1562.namprd03.prod.outlook.com>
References: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>	<CADRPPNQJi_x+mdQV=DEVuhCL_p6VOWcPiV3jzioeRdWgSW2w3g@mail.gmail.com>	<CY1PR0301MB15628DD5CFCE2B65BF4FECB2837C0@CY1PR0301MB1562.namprd03.prod.outlook.com>
 <CADRPPNS_wzX+mwT0L-H=ZP9w8gH9W4O9KUqnGYiAc39S5v4qLA@mail.gmail.com>
 <CY1PR0301MB1562103588FB0C6BEFDDBF3C83790@CY1PR0301MB1562.namprd03.prod.outlook.com>
Message-ID: <55D183D1.9020401@nigelcunningham.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yao.

On 17/08/15 13:59, Yao Yuan wrote:
> On Sat, Aug 15, 2015 at 7:48 AM, pku.leo < pku.leo@gmail.com > wrote:
>> On Fri, Aug 14, 2015 at 1:24 AM, Yao Yuan <yao.yuan@freescale.com> wrote:
>>> Hi Leo,
>>>
>>> Thanks for your review.
>>> About those two methods for DMA suspend that you have mentioned. We
>> have a lot of the discussions in other DMA driver like DMA for Freescale
>> PowerPC.
>>> Finally, we think the device which used the DMA transmission service should
>> cancel the transmission service in its suspend.
>>> So DMA in suspend should be idle.
>> If that's the case you should clearly state this in the commit message and in
>> code, although I don't know if it is safe to make such assumption.  There could
>> be user of the DMA that doesn't track the completion of transfers.
> I think it should be safe. In my opinion, even some client(the user of the DMA) forget to cancel its DMA transmission,
> It will just lead to PM failed but no other system and data risk.
> Although we should first fix the behavior of the client.
> Once you are no need the DMA transmission, why not stop it?
>
> Is it right?
Think of it from the end user perspective. Would you like your laptop (or whatever) to refuse to suspend because of this condition? The user may well expect that closing the lid on their laptop will reliably lead to it suspending to ram. Returning a failure here could result in a loss of data if the condition is not detected and the machine subsequently runs out of power.

I do agree that whatever is submitting DMA should be stopped first; ideally this driver would always be idle because whatever producers of work exist would already have been quiesced and output flushed.

Regards,

Nigel
