From: oliver@neukum.org (Oliver Neukum)
Date: Mon, 24 Jun 2013 15:06:01 +0200
Subject: [PATCH v2 4/4] USB: EHCI: support running URB giveback in tasklet
 context
In-Reply-To: <CACVXFVPwLwA6Ajfjs6w51G1HC23net7HNsxZPs4WFyrSNL2Xxg@mail.gmail.com>
References: <1372066925-23579-1-git-send-email-ming.lei@canonical.com>
 <2282821.gNu4BgBT5E@linux-5eaq.site>
 <CACVXFVPwLwA6Ajfjs6w51G1HC23net7HNsxZPs4WFyrSNL2Xxg@mail.gmail.com>
Message-ID: <2577893.kkNxLWkCK6@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013 20:58:26 Ming Lei wrote:
> On Mon, Jun 24, 2013 at 6:24 PM, Oliver Neukum <oliver@neukum.org> wrote:
> > On Monday 24 June 2013 17:42:05 Ming Lei wrote:
> >> All 4 transfer types can work well on EHCI HCD after switching to run
> >> URB giveback in tasklet context, so mark all HCD drivers to support
> >> it.
> >>
> >> At the same time, don't release ehci->lock during URB giveback,
> >> and remove the check on HCD_BH in ehci_disable_event().
> >>
> >> From below test results on 3 machines(2 ARM and one x86), time
> >> consumed by EHCI interrupt handler droped much without performance
> >> loss.
> >>
> >> 1 test description
> >> 1.1 mass storage performance test:
> >> - run below command 10 times and compute the average performance
> >>
> >>     dd if=/dev/sdN iflag=direct of=/dev/null bs=200M count=1
> >
> > It would be nice to get worst case numbers. How bad does it get
> > if you reduce the sg size in usb-storage from 120K to 4K?
> 
> A quick test on one arm A15 box shows that the average speed over
> 10 times 'dd' becomes 8.0MB/sec from 8.160MB/sec when 'bs'
> parameter of 'dd' changes to 4K, so there is ~1.9% performance
> loss with the patch under the worst case.
> 
> Same test on my T410(x86), the speed difference is only 40K.
> 
> I will collect the worst case numbers and include it in the commit
> log of V3.

Sorry,

I was referring to scsiglue.c

struct scsi_host_template usb_stor_host_template = {
        /* basic userland interface stuff */
        .name =                         "usb-storage",
        .proc_name =                    "usb-storage",
        .proc_info =                    proc_info,
        .info =                         host_info,

        /* command interface -- queued only */
        .queuecommand =                 queuecommand,

        /* error and abort handlers */
        .eh_abort_handler =             command_abort,
        .eh_device_reset_handler =      device_reset,
        .eh_bus_reset_handler =         bus_reset,

        /* queue commands only, only one command per LUN */
        .can_queue =                    1,
        .cmd_per_lun =                  1,

        /* unknown initiator id */
        .this_id =                      -1,

        .slave_alloc =                  slave_alloc,
        .slave_configure =              slave_configure,

        /* lots of sg segments can be handled */
        .sg_tablesize =                 SCSI_MAX_SG_CHAIN_SEGMENTS,

        /* limit the total size of a transfer to 120 KB */
        .max_sectors =                  240,

If you go to 8 sectors here, you should get the absolute worst case.

	Regards
		Oliver
