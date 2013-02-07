From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 7 Feb 2013 19:42:25 +0530
Subject: [PATCH 1/1] DMA: PL330: allow submitting 2 requests at a time
In-Reply-To: <5113B03D.5010206@gmail.com>
References: <1360233523-20825-1-git-send-email-dirac3000@gmail.com>
 <CABb+yY3iPoXBFpKgmdTijeee71Xz9dkwjcay8keu+vsdWtDfXw@mail.gmail.com>
 <5113B03D.5010206@gmail.com>
Message-ID: <CABb+yY2o2eWj4KY3immegSB26QcEYAykbpjJohL3ri1+8RPQFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 7:16 PM, dirac3000 <dirac3000@gmail.com> wrote:
> On 02/07/2013 12:31 PM, Jassi Brar wrote:
>
>> On Thu, Feb 7, 2013 at 4:08 PM, Alvaro Moran<dirac3000@gmail.com>  wrote:
>>>
>>> Due to the original driver design, only one request was processed at a
>>> time by the driver, even if the low-level part of the driver was able to
>>> handle 2 requests.
>>> With this patch we are able to create 2 microcodes per thread and to
>>> launch the second transfer on the interrupt handler of the first one,
>>> instead of having to wait for the tasklet to generate the microcode.
>>>
>> The following seems more appropriate and complete. Does it fix your
>> problem?
>>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index 758122f..a821d71 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c
>> @@ -2292,13 +2292,12 @@ static inline void fill_queue(struct
>> dma_pl330_chan *pch)
>>
>>                 /* If already submitted */
>>                 if (desc->status == BUSY)
>> -                       break;
>> +                       continue;
>>
>>                 ret = pl330_submit_req(pch->pl330_chid,
>>                                                 &desc->req);
>>                 if (!ret) {
>>                         desc->status = BUSY;
>> -                       break;
>>                 } else if (ret == -EAGAIN) {
>>                         /* QFull or DMAC Dying */
>>                         break;
>
>
>
> Actually that isn't good enough. With your patch it will keep on looping on
> the pch->work_list entries, but it will call pl330_submit_req the first time
> only. I want it to call the function twice, so it will generate 2 microcodes
> (one per available request) and it will be ready the moment we get into the
> interrupt handler.

Why would it "keep on looping"? It's a for loop that will exit after
iterating over the list once or when the lower layer indicates QFull -
whichever comes first. Practically it achieves the same effect only
without introducing a new local variable 'busy_reqs'
Did you actually test the patch? If yes and it didn't work, please
share some log suitable log.
thnx.
