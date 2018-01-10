From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 10 Jan 2018 10:12:49 +0530
Subject: [PATCH v3 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <BY1PR0201MB0885F2BCD9FE353171B54888B0110@BY1PR0201MB0885.namprd02.prod.outlook.com>
References: <1515109891-17133-1-git-send-email-jliang@xilinx.com>
 <1515109891-17133-3-git-send-email-jliang@xilinx.com>
 <CABb+yY00n6fLiQXftj-TMhT6q=KopZMkLYr6DpYE8CvxH-gz8Q@mail.gmail.com>
 <BY1PR0201MB0885F2BCD9FE353171B54888B0110@BY1PR0201MB0885.namprd02.prod.outlook.com>
Message-ID: <CABb+yY1VxNCskPK4LJ=JnxyKPBid2SEEgRLK3M1Csbu2xMRn8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 6:52 AM, Jiaying Liang <jliang@xilinx.com> wrote:
>> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]

>> > +
>> > +Controller Device Node:
>> > +===========================
>> > +Required properties:
>> > +--------------------
>> > +- compatible:          Shall be: "xlnx,zynqmp-ipi-mailbox"
>> > +- reg:                 IPI buffers address ranges
>> > +- reg-names:           Names of the reg resources. It should have:
>> > +                       * local_request_region
>> > +                         - IPI request msg buffer written by local and read
>> > +                           by remote
>> > +                       * local_response_region
>> > +                         - IPI response msg buffer written by local and read
>> > +                           by remote
>> > +                       * remote_request_region
>> > +                         - IPI request msg buffer written by remote and read
>> > +                           by local
>> > +                       * remote_response_region
>> > +                         - IPI response msg buffer written by remote and read
>> > +                           by local
>> >
>> shmem is option and external to the controller. It should be passed via
>> client's binding.
>> Please have a look at Sudeep's proposed patch
>> https://www.spinics.net/lists/arm-kernel/msg626120.html
> [Wendy] thanks for the link, but those 'buffers" are registers in the hardware
> but not memory.
>
No, that is for memory, not registers.
Please have a more careful look at the patch.

>>
>> > +- #mbox-cells:         Shall be 1. It contains:
>> > +                       * tx(0) or rx(1) channel
>> > +- xlnx,ipi-ids:                Xilinx IPI agent IDs of the two peers of the
>> > +                       Xilinx IPI communication channel.
>> > +- interrupt-parent:    Phandle for the interrupt controller
>> > +- interrupts:          Interrupt information corresponding to the
>> > +                       interrupt-names property.
>> > +
>> > +Optional properties:
>> > +--------------------
>> > +- method:              The method of accessing the IPI agent registers.
>> > +                       Permitted values are: "smc" and "hvc". Default is
>> > +                       "smc".
>> > +
>> Andre almost implemented the generic driver. Can you please have a look at
>> https://www.spinics.net/lists/arm-kernel/msg595416.html
>> and see if you can just finish it off?
> [Wendy] This mailbox controller is about to use Xilinx IPI hardware as mailbox.
>
I couldn't find anything specific to Xilinx h/w
zynqmp_ipi_fw_call() is same as arm_smc_send_data() in Andre's driver
(though it needs to pass on [R2,R7] as I suggested in reply to him).

> We use it to send notification/short request to firmware (usually running on
> another core on SoC),
>
So does Andre's driver. Which is precise and generic, so I much prefer that.

> and also to receive notification/short request from firmware.
> Interrupt is used in the receiving direction. It looks different to the usage of
> mailbox driver from the link.
>
Yes, there is some difference. But nothing related to your h/w.
Andre's driver assume synchronous transmits where the response is
filled in the regs upon return.
What kind of calls do you make to your remote firmware? I would expect
them to be 'fast'.

> Is there a plan to extend the ARM SMC mailbox driver
> to both trigger firmware actions and receive request from firmware?
>
Sure if we have a genuine requirement we can support RX path as well.

Thanks.
