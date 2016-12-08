From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 08 Dec 2016 12:21:17 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <CAMuHMdWXVW9BG=MZGptibDTxDd5=7iCbiq1cmbD+qu-CZ0Y_7g@mail.gmail.com>
 (Geert Uytterhoeven's message of "Thu, 8 Dec 2016 13:03:51 +0100")
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com> <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com> <20161208103921.GC6408@localhost>
 <91b0d10c-1bc2-c3e1-4088-f4ad9adcd6c0@free.fr>
 <CAMuHMdUULnPuTqEwRN2Z3gy2nmV37iLwJdNzrEvgpcG-EJS8OQ@mail.gmail.com>
 <yw1x1sxi1w3i.fsf@unicorn.mansr.com>
 <CAMuHMdWXVW9BG=MZGptibDTxDd5=7iCbiq1cmbD+qu-CZ0Y_7g@mail.gmail.com>
Message-ID: <yw1xoa0mzk5e.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi M?ns,
>
> On Thu, Dec 8, 2016 at 12:47 PM, M?ns Rullg?rd <mans@mansr.com> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>> On Thu, Dec 8, 2016 at 11:54 AM, Mason <slash.tmp@free.fr> wrote:
>>>> On 08/12/2016 11:39, Vinod Koul wrote:
>>>>> On Wed, Dec 07, 2016 at 04:45:58PM +0000, M?ns Rullg?rd wrote:
>>>>>> Vinod Koul <vinod.koul@intel.com> writes:
>>>>>>> On Tue, Dec 06, 2016 at 01:14:20PM +0000, M?ns Rullg?rd wrote:
>>>>>>>> That's not going to work very well.  Device drivers typically request
>>>>>>>> dma channels in their probe functions or when the device is opened.
>>>>>>>> This means that reserving one of the few channels there will inevitably
>>>>>>>> make some other device fail to operate.
>>>>>>>
>>>>>>> No that doesn't make sense at all, you should get a channel only when you
>>>>>>> want to use it and not in probe!
>>>>>>
>>>>>> Tell that to just about every single driver ever written.
>>>>>
>>>>> Not really, few do yes which is wrong but not _all_ do that.
>>>>
>>>> Vinod,
>>>>
>>>> Could you explain something to me in layman's terms?
>>>>
>>>> I have a NAND Flash Controller driver that depends on the
>>>> DMA driver under discussion.
>>>>
>>>> Suppose I move the dma_request_chan() call from the driver's
>>>> probe function, to the actual DMA transfer function.
>>>>
>>>> I would want dma_request_chan() to put the calling thread
>>>> to sleep until a channel becomes available (possibly with
>>>> a timeout value).
>>>>
>>>> But Maxime told me dma_request_chan() will just return
>>>> -EBUSY if no channels are available.
>>>>
>>>> Am I supposed to busy wait in my driver's DMA function
>>>> until a channel becomes available?
>>>
>>> Can you fall back to PIO if requesting a channel fails?
>>>
>>> Alternatively, dma_request_chan() could always succeed, and
>>> dmaengine_prep_slave_sg() could fail if the channel is currently not
>>> available due to a limitation on the number of active channels, and
>>> the driver could fall back to PIO for that transfer.
>>
>> Why are we debating this nonsense?  There is an easy fix that doesn't
>> require changing the semantics of existing functions or falling back to
>> slow pio.
>
> You still want to fall back to PIO if the DMA engine is not available at all
> (e.g. DMA engine driver not compiled in, or module not loaded).

That's a choice for each device driver to make.  Some devices don't have
a pio mode at all.

-- 
M?ns Rullg?rd
