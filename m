From: jliang@xilinx.com (Jiaying Liang)
Date: Mon, 29 Oct 2018 18:01:06 +0000
Subject: [PATCH v4 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <CAA07jV_FWxMRq=4hmTdCXJG6e3=-8AejfpKxmh9KUi9KQDH7yQ@mail.gmail.com>
References: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
 <1539155912-29760-3-git-send-email-wendy.liang@xilinx.com>
 <20181010095741.GA14472@e107155-lin>
 <CAA07jV_FWxMRq=4hmTdCXJG6e3=-8AejfpKxmh9KUi9KQDH7yQ@mail.gmail.com>
Message-ID: <DM5PR02MB2233AC6A0276887869AF72C9B0F30@DM5PR02MB2233.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Wendy Liang [mailto:sunnyliangjy at gmail.com]
> Sent: Wednesday, October 10, 2018 3:54 PM
> To: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Jiaying Liang <jliang@xilinx.com>; Jassi Brar <jassisinghbrar@gmail.com>;
> Michal Simek <michals@xilinx.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Devicetree List
> <devicetree@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel at vger.kernel.org>; linux-arm-kernel <linux-arm-
> kernel at lists.infradead.org>
> Subject: Re: [PATCH v4 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
> 
> On Wed, Oct 10, 2018 at 2:59 AM Sudeep Holla <sudeep.holla@arm.com>
> wrote:
> >
> > On Wed, Oct 10, 2018 at 12:18:32AM -0700, Wendy Liang wrote:
> > > Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block in
> > > ZynqMP SoC used for the communication between various processor
> > > systems.
> > >
> > > Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> >
> > [...]
> >
> > > +Optional properties:
> > > +--------------------
> > > +- method:              The method of accessing the IPI agent registers.
> > > +                       Permitted values are: "smc" and "hvc". Default is
> > > +                       "smc".
> >
> > You are mixing the hardware messaging based mailbox and the software
> > "smc/hvc" based mailbox together here. Please keep them separated.
> > IIUC smc/hvc based mailcox is used for "tx" or too keep it simple in
> > one direction and hardware based is used for "rx" or the other
> > direction for communication.
> >
> Hi Sudeep,
> 
> Thanks for your comments.
> 
> The IPI hardware block has both buffers and registers. The hardware block
> has dedicated buffers for each mailboxes, and thus, in the implementation,
> we directly access the buffers from IPI driver. However, the controller
> registers are shared between mailboxes in the hardware, as the ATF will also
> access the registers, we need to use SMC/HVC to access the registers (control
> or ISR). And the SMC/HVC here is for the register access.
> 
> I am not clear on smc/hvc based mailbox is used for tx, and hardware based
> is used for  "rx". As for both TX and RX, we need to write/read the registers
> (through SMC) and write/read the buffers provided by the IPI hardware block
> directly.
[Wendy] Hi Sudeep,

The SMC/HVC is for hardware registers access as but not sending messages.
Do you have further comments or are you fine with the explanation?

Thanks,
Wendy

> 
> Thanks,
> Wendy
> 
> > You *should not* mix them as single unit. Also lots of other vendor
> > need SMC/HVC based mailbox. So make it generic and keep it separate.
> >
> > --
> > Regards,
> > Sudeep
