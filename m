From: zonque@gmail.com (Daniel Mack)
Date: Tue, 20 Aug 2013 09:44:00 +0200
Subject: [PATCH v4 1/4] dma: mmp_pdma: only complete one transaction from
 dma_do_tasklet()
In-Reply-To: <5212D419.5030504@marvell.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-2-git-send-email-zonque@gmail.com>
 <5212D419.5030504@marvell.com>
Message-ID: <52131E40.5040304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xiang,

On 20.08.2013 04:27, Xiang Wang wrote:
> I think we would not run into the situation that there is a descriptor 
> with ENDIRQEN set in the middle of the running chain.
> 
> in mmp_pdma.c:
> mmp_pdma_tx_submit() -> append_pending_queue() ->
> tail->desc.dcmd &= ~DCMD_ENDIRQEN;
> 
> So in the pending list (same for running list), only the last descriptor 
> will have ENDIRQEN set.

Right, thanks for noting that.

But is that what we want? I think that clearing of the ENDIRQEN bit
needs to be removed then, because if we really have multiple
transactions running, then we want to get an interrupt whenever _any_ of
it is completed. Also, the way I solved it now, the ENDIRQEN bit is also
looked at when the residue code tries to distinguish the transactions in
the list.

Hence, would you agree that we should remove that "tail->desc.dcmd &=
~DCMD_ENDIRQEN;" modification in order to make the above logic work?


Thanks,
Daniel
