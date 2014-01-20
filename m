From: sthokal@xilinx.com (Srikanth Thokala)
Date: Mon, 20 Jan 2014 19:05:25 +0530
Subject: [PATCH] dma: Add Xilinx AXI Video Direct Memory Access Engine
 driver support
In-Reply-To: <201401201239.47665.arnd@arndb.de>
References: <1389894803-4147-1-git-send-email-sthokal@xilinx.com>
 <201401171713.08550.arnd@arndb.de>
 <CA+mB=1L0ZSC8f6eMEuO7MEk6nG5SDahE7AH2F_uUr1TgTCD=cw@mail.gmail.com>
 <201401201239.47665.arnd@arndb.de>
Message-ID: <CA+mB=1+mrWAzBCxdMEji2MDRzHajmnxuWtz7iu96ML0DuAB3RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Sorry for the duplication.  Ccing others.

On Mon, Jan 20, 2014 at 5:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 20 January 2014, Srikanth Thokala wrote:
>> On Fri, Jan 17, 2014 at 9:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 16 January 2014, Srikanth Thokala wrote:
>> > I also assume that some of the properties should just go away:
>> >
>> > * xlnx,device-id should be the argument in the handle from the slave device
>>
>> We can have multiple instances of this VDMA IP configured in the FPGA and we
>> need a unique identifier for each VDMA device that is present in the FPGA.
>> This device-id dt parameter forms the filter mask for the slave devices. As an
>> example, this can be used to get a channel of specific VDMA device (assuming
>> multiple instances) using the API dma_request_channel().  Please note this
>> is an example of a slave device that doesnt have dt node.
>
> That is not a valid scenario: You should not try to support legacy
> slave devices (without DT) connected to a dma-engine that is initialized
> using DT. If you still in the progress of converting drivers to DT, you
> can use auxdata to attach additional information that can be used for
> those slave devices, but the code should be kept out of the mainline
> kernel, and I don't want to see it manifest in the bindings.

I see your point.  Thank you for the clarification.  I will fix this in my v2.

>
>> > * data width should be a property of the slave driver that is configured
>> >   through dma_slave_config(), unless you can have dma engines that only
>> >   support certain a width.
>>
>> Yes, this VDMA engine soft IP support only certain widths, which is
>> configurable during IP synthesis.
>
> But what is this property used for in that case? Surely you can't
> connect a slave device to a dmaengine if the bus width doesn't match.
> You probably have a point here, but I don't understand it yet.

There is a Data-Realignment Engine (DRE) in the IP which is only available for
data width setting of 64-bits and less.  So, we use the data-width DT parameter
to verify this condition and we update alignment shift accordingly.

Srikanth

>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
