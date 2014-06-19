From: tj@kernel.org (Tejun Heo)
Date: Thu, 19 Jun 2014 10:33:51 -0400
Subject: [PATCH v3 2/2] ata: Fix the dma state machine lockup for the
 IDENTIFY DEVICE PIO mode command.
In-Reply-To: <CAOHikRAaMaMc1zHU3B_Qqg8fRndCqHQTDR7wpCoaS_kafkgzdw@mail.gmail.com>
References: <1403160654-31612-1-git-send-email-stripathi@apm.com>
 <20140619141047.GA26904@htj.dyndns.org>
 <CAOHikRAX1NfeCRWVJtv_FTHHheYxU5uKVk_hytdEmb_j-5_wnA@mail.gmail.com>
 <20140619142148.GD26904@htj.dyndns.org>
 <CAOHikRAaMaMc1zHU3B_Qqg8fRndCqHQTDR7wpCoaS_kafkgzdw@mail.gmail.com>
Message-ID: <20140619143351.GE26904@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jun 19, 2014 at 07:57:33PM +0530, Suman Tripathi wrote:
> [suman] : Are you ok if I make ahci_qc_issue in the ahci.h as not static
> and make it as EXPORT_SYMBOL_GPL ? Currenty ahci_qc_issue is static.
> If you take the current case , I only had to make  ahci_sw_activity as non
> static and use it. So both the intention is same.

Yeah, sure.  We end up having to export a function anyway.  Better to
avoid duplicating the function body.

> So, it's just ATA_CMD_ID_ATA and ATA_CMD_ID_ATAPI is okay?  That's
> kinda weird.
> 
> [suman] : Not tested for ATA_CMD_ID_ATAPI. It's just for ATA_CMD_ID_ATA for
> now.

Can you give it a test?  The two commands are really similar, so it'd
be surprising if the controller only chokes on one of them.  Another
thing worthwhile testing is "libata.force=noncq,pio0" so that you can
be sure other pio commands are okay.

Thanks.

-- 
tejun
