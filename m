From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 12 Jul 2011 18:15:22 +0530
Subject: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
	configuration
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94030259DBBE@dbde02.ent.ti.com>
References: <1310310203-12288-1-git-send-email-sundaram@ti.com>
	<CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
	<CACRpkdbLg0+_2kpi4NizFj0fDWb6QPtkcKirKgoH+83vGD0O0A@mail.gmail.com>
	<CABb+yY1RqHJ6jsMB2RqPNnBLff-bzhwaXG1U-hCD8CpME+a3aA@mail.gmail.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94030259DBBE@dbde02.ent.ti.com>
Message-ID: <CABb+yY1_vuM7NGxV4o103YmYfte09XKpaXnYARcn3jjnChiBsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 5:01 PM, Raju, Sundaram <sundaram@ti.com> wrote:
>> -----Original Message-----
>> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
>> Sent: Tuesday, July 12, 2011 4:51 PM
>> To: Linus Walleij
>> Cc: Raju, Sundaram; linux-arm-kernel at lists.infradead.org; linux-
>> kernel at vger.kernel.org; davinci-linux-open-source at linux.davincidsp.com;
>> linux at arm.linux.org.uk; dan.j.williams at intel.com; linux-omap at vger.kernel.org
>> Subject: Re: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
>> configuration
>>
>> On Tue, Jul 12, 2011 at 3:33 PM, Linus Walleij <linus.walleij@linaro.org>
>> wrote:
>> > On Tue, Jul 12, 2011 at 6:17 AM, Jassi Brar <jassisinghbrar@gmail.com>
>> wrote:
>> >
>> >> 1) Striding, in one form or other, is supported by other DMACs as well.
>> >> ? The number will only increase in future.
>> >> ? Are we to add ?<VENDOR>_DMA_STRIDE_CONFIG for each case ?
>> >
>> > If we are sure about this and striding will work in a similar way on all
>> > then let's have the enum named DMA_STRIDE_CONFIG and move the
>> > passed-in struct to <linux/dmaengine.h) then?
>> >
>> > Would that be:
>> >
>> > struct dma_stride_config {
>> > ? ?u32 read_bytes;
>> > ? ?u32 skip_bytes;
>> > };
>> >
>> > Or something more complex?
>> Well, I am not sure if striding needs any special treatment at all.
>> Why not have client drivers prepare and submit sg-list.
>> Let the DMAC drivers interpret/parse the sg-list and program it
>> as strides if the h/w supports it.
>> If anything, we should make preparation and submission of sg-list
>> as efficient as possible.
> Jassi,
>
> sg_lists describe only a bunch of disjoint buffers. But what if the
> DMAC can skip and read the bytes within each of the buffers in
> the sg_list? (like TI EDMAC and TI SDMAC)
> How can that information be passed to the offload
> engine driver from the client?
>
OK, I overlooked.
We do need something new to handle these ultra-fine-grained sg-lists.
But still we shouldn't add SoC specific API to the common sub-systems.

Maybe a new api to pass fixed-format variable-length encoded message
to the DMAC drivers?
Which could be interpreted by DMAC drivers to extract all the needed xfer
parameters from the 'header' section and instructions to program the xfers
in the DMAC from the variable length body of the 'message' buffer.
It might sound complicated but we can have helpers to make the job easy.
Btw, the regular single/sg-list xfers could also be expressed by this method.
