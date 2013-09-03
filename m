From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 3 Sep 2013 18:24:11 +0530
Subject: [PATCH] dmaengine: sirf: add dmaengine_prep_slave_single/sg
 support
In-Reply-To: <CAGsJ_4wfpb6WYB_sExxZc-UOKXkbGx_G3k=fHUwGTW-TmcsL1A@mail.gmail.com>
References: <1377435433-23202-1-git-send-email-Baohua.Song@csr.com>
 <20130826085607.GN2748@intel.com>
 <CAGsJ_4yhVFL+j9PV-srAXdYkbEN62X18n-_+cXa+xy4wcOF7Qw@mail.gmail.com>
 <20130902062549.GG7376@intel.com>
 <CAGsJ_4w4dNOy=8HMQqy9sCL=UVWXSgADjoqBD9FmSxdoyzZ6pQ@mail.gmail.com>
 <CAJe_Zhfo0502tvd-0Rt-0kEKn+Z_S-B+JSAVd4=UNpneQ5GSvw@mail.gmail.com>
 <CAGsJ_4wfpb6WYB_sExxZc-UOKXkbGx_G3k=fHUwGTW-TmcsL1A@mail.gmail.com>
Message-ID: <CAJe_ZhfMzPAaeysDn3aXH_6qsj+4ZeKxfb5M=gZELJW6ZO9Aaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 September 2013 18:08, Barry Song <21cnbao@gmail.com> wrote:
> 2013/9/3 Jassi Brar <jaswinder.singh@linaro.org>:
>> On 3 September 2013 15:36, Barry Song <21cnbao@gmail.com> wrote:
>>> 2013/9/2 Vinod Koul <vinod.koul@intel.com>:
>>>> On Sun, Sep 01, 2013 at 09:02:01PM +0800, Barry Song wrote:
>>>>> 2013/8/26 Vinod Koul <vinod.koul@intel.com>:
>>>>> > On Sun, Aug 25, 2013 at 08:57:13PM +0800, Barry Song wrote:
>>>>> >> the dma engine of sirfsoc supports interleaved mode, but if we set
>>>>> >> xlen=width instead xlen<width, it will work as non-interleaved. as
>>>>> >> most clients of sirf dma driver still don't need interleaved mode,
>>>>> >> so here we still need to implement prep_slave_sg entry so that users
>>>>> >> like uart, spi can use these APIs instead of interleaved API.
>>>>> > Well in that case why dont you just create a wrapper on top of interleaved API
>>>>> > to make this work without driver changes
>>>>>
>>>>> Vinod, do you mean using interleaved API to provide sg/single API if
>>>>> specific drivers implement interleaved_dma but not implement sg_dma?
>>>>>
>>>>> the problem is that is difficult to set right legal sgl[i].size,
>>>>> sgl[i].icg and numf for all dmaengines as that depends on specific dma
>>>>> hardware limitation.
>>>> The whole premise of doing the generic interleaved api was to ensure we can use
>>>> any of the usuages as a case of interleaved api. Can you explain how it would be
>>>> difficult?
>>>
>>> for example, if someone wants to do a 16Kbytes single transfer. how
>>> will interleaved dma set transfer length and interval between every
>>> row?
>>> if it sets the transfer length to 16KB directly, the dma hardware
>>> might not support such long a transfer at all.
>>> so it might want to set as two 8KB transfer without interval between them.
>>> 0~8KB                empty interval
>>> 8KB-16KB          empty interval
>>> or four 4KB transfer as
>>> 0~4KB                empty interval
>>> 4KB-8KB          empty interval
>>> 8KB-12KB          empty interval
>>> 12KB-16KB          empty interval
>>>
>>> the problem is we don't know the hardware limitation of every dma
>>> controllers for transferring length of each row.
>>>
>> A client is only interested in transferring the total amount data and
>> if/when it wants notified. How the dma controller divides the big
>> transfer, shouldn't matter to the client. In fact it would be bad for
>> a client to care about the working of a dma controller.
>> IOW, the 16KB transfer could be divided into 4 parts by the dmac that
>> supports max 4KB transfers, into 8 parts if max is 2KB and so on...
>> the client shouldn't care.
>
> here my point is that we don't expose dma transferring hardware
> details to clients. i actually wanted to hide that in dma driver not
> dma client.
> the only difference between vinod and me is that Vinod's point is
> hiding that in dma core, my way is hiding it in dma driver.
>
How big is the effort to convert the clients to use interleaved api?

> btw, interleaved_dma clients do care about how the interleaved
> transfer will happen
>
No, there is difference. Interleaved api only tells how the data, to
be transferred, is laid out in memory. It doesn't not specify how the
dma controller actually does the transfer.

-jassi
