From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 14 Sep 2016 13:26:07 +0100
Subject: [PATCH] coresight: tmc: fix for trace collection bug in sysFS mode
In-Reply-To: <CAGhh56GQmKnk5UaYYW-X1YpsPdb7SwCy1b5ANd3tmdAXBTBbZA@mail.gmail.com>
References: <1473769245-18159-1-git-send-email-venkatesh.vivekanandan@broadcom.com>
 <CANLsYkzNqMuwcmYJtoORXrON54Wt1oj5uyp2NQpKYM2AN4F26g@mail.gmail.com>
 <a8232b7a-3d38-efb1-4c71-8dcb12f89dad@arm.com>
 <CAGhh56GQmKnk5UaYYW-X1YpsPdb7SwCy1b5ANd3tmdAXBTBbZA@mail.gmail.com>
Message-ID: <c866fcbf-afac-4f7b-acb5-e4a0c054a392@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/16 12:30, Venkatesh Vivekanandan wrote:
>
>
> On Wed, Sep 14, 2016 at 3:26 PM, Suzuki K Poulose <Suzuki.Poulose at arm.com <mailto:Suzuki.Poulose@arm.com>> wrote:
>
>     On 13/09/16 16:41, Mathieu Poirier wrote:
>
>         On 13 September 2016 at 06:20, Venkatesh Vivekanandan
>         <venkatesh.vivekanandan at broadcom.com <mailto:venkatesh.vivekanandan@broadcom.com>> wrote:
>
>             tmc_etb_dump_hw is never called in sysFS mode to collect trace from
>             hardware, because drvdata->mode is set to CS_MODE_DISABLED at
>             tmc_disable_etf/etr_sink
>
>             static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>             {
>                     .
>                     .
>                     if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
>                             tmc_etb_dump_hw(drvdata);
>                     .
>                     .
>             }
>
>             static void tmc_disable_etf_sink(struct coresight_device *csdev)
>             {
>                    .
>                    .
>                     val = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
>                     /* Disable the TMC only if it needs to */
>                     if (val != CS_MODE_DISABLED)
>                             tmc_etb_disable_hw(drvdata);
>
>
>         You are correct.
>
>                    .
>                    .
>             }
>
  
>     I think we should :
>
>     1) First switch the drvdata->mode to a normal type from local_t. Using an
>     atomic type for mode is completely unnecessary and comes with the overhead
>     of barriers/synchronisation instructions, while all accesses, including read/write
>     are performed under the drvdata->spinlock. I have a patch already for this, which
>     I plan to send it soon.
>
>     and
>
>     2) Do something like :
>
>     void  tmc_disable_etX_sink()
>     {
>             if (drvdata->mode != CS_MODE_DISABLED) {
>                     tmc_etX_disable_hw(drvdata);
>                     drvdata->mode = CS_MODE_DISABLED;
>             }
>     }
>
> You will fix this along with above changes?

Yes.

nit: Please fix your mail client. Do not use HTML formatted emails on mailing list

Cheers
Suzuki
