From: tj@kernel.org (Tejun Heo)
Date: Thu, 19 Jun 2014 10:21:48 -0400
Subject: [PATCH v3 2/2] ata: Fix the dma state machine lockup for the
 IDENTIFY DEVICE PIO mode command.
In-Reply-To: <CAOHikRAX1NfeCRWVJtv_FTHHheYxU5uKVk_hytdEmb_j-5_wnA@mail.gmail.com>
References: <1403160654-31612-1-git-send-email-stripathi@apm.com>
 <20140619141047.GA26904@htj.dyndns.org>
 <CAOHikRAX1NfeCRWVJtv_FTHHheYxU5uKVk_hytdEmb_j-5_wnA@mail.gmail.com>
Message-ID: <20140619142148.GD26904@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 07:44:28PM +0530, Suman Tripathi wrote:
> Hi Tejun,
> 
> On Thu, Jun 19, 2014 at 12:20:54PM +0530, Suman Tripathi wrote:
> > +     /*
> > +      * Restart the dma engine if the last cmd issued
> > +      * is IDENTIFY DEVICE command
> > +      */
> > +     if (unlikely(ctx->last_cmd[ap->port_no] == ATA_CMD_ID_ATA))
> > +             ahci_restart_engine(ap);
> 
> Is it really only for IDENTIFY?  Are other PIO commands okay?
> [Suman] : We root cause it , It is the IDENTIFY DEVICE command . Other are
> ok
> Theprevious version applied it to all PIO commands, right?
> [suman] : The v2 contains only the IDENTIFY DEVICE. The v1 is contains for
> all PIO commands and that didn't work because the ERRATA mentions that it
> happens for the IDENTIFY DEVICE command.

So, it's just ATA_CMD_ID_ATA and ATA_CMD_ID_ATAPI is okay?  That's
kinda weird.

-- 
tejun
