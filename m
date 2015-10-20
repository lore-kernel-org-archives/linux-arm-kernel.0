From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 20 Oct 2015 01:33:54 -0700
Subject: [PATCH] fpga: zynq-fpga: Change fw format to handle bin instead
 of bit.
In-Reply-To: <5625D02A.3060904@topic.nl>
References: <1445299319-14921-1-git-send-email-moritz.fischer@ettus.com>
 <1445299319-14921-2-git-send-email-moritz.fischer@ettus.com>
 <5625D02A.3060904@topic.nl>
Message-ID: <CAAtXAHewY=B5oBBZR1KECo-QqpXH0zxNVO44F7f4AUOZxmFvKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Mon, Oct 19, 2015 at 10:24 PM, Mike Looijmans
<mike.looijmans@topic.nl> wrote:
> On 20-10-15 02:01, Moritz Fischer wrote:
>>
>> This gets rid of the code to strip away the header and byteswap.
>>
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> ---
>>   drivers/fpga/zynq-fpga.c | 23 ++++++++++-------------
>>   1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>> index 617d382..916c551 100644
>> --- a/drivers/fpga/zynq-fpga.c
>> +++ b/drivers/fpga/zynq-fpga.c
>> @@ -104,6 +104,8 @@
>>   #define INIT_POLL_TIMEOUT             2500000
>>   /* Delay for polling reset bits */
>>   #define INIT_POLL_DELAY                       20
>> +/* Sync sequence for firmware */
>> +#define SYNC_SEQUENCE                  "\x66\x55\x99\xAA"
>>
>>   /* Masks for controlling stuff in SLCR */
>>   /* Disable all Level shifters */
>> @@ -301,24 +303,19 @@ static int zynq_fpga_ops_write(struct fpga_manager
>> *mgr,
>>
>>         memcpy(kbuf, buf, count);
>>
>> -       /* look for the sync word */
>> +       /* look for the sync sequence */
>>         for (i = 0; i < count - 4; i++) {
>> -               if (memcmp(kbuf + i, "\xAA\x99\x55\x66", 4) == 0) {
>> -                       dev_dbg(priv->dev, "Found swapped sync word\n");
>> +               if (memcmp(kbuf + i, SYNC_SEQUENCE, 4) == 0) {
>> +                       dev_dbg(priv->dev, "Found sync sequence");
>>                         break;
>>                 }
>>         }
>
>
> Regarding this check, and judging from the code, I'd say that any file with
> a non word-aligned sync word is broken. So you could speed this up
> considerably by walking through the array word-by-word instread of
> byte-by-byte.

True.
>
> Checking the whole 4MB buffer from beginning to end doesn't make it really
> efficient either, if you're going to visit all that memory in case the
> stream is invalid, you might as well send it to the hardware, I wouldn't be
> surprised if that even takes less effort than going through it byte-by-byte.

You raised a good point here. I was hesitant to put in the additional check,
in my tests the reloading took no noticeable time, which was good enough for my
application, so I figured rather be more 'defensive'. Probably overly defensive,
as the reloading entity would have to check for success in either case before
attempting to use the FPGA afterwards.

> I for one would rather see this check removed, the hardware handles it just
> fine and also catches more likely errors (e.g. sending a 7030 bitstream to a
> 7015 chip is something that the driver cannot catch anyway, but the hardware
> detects that error just fine).

Fair enough. I'll remove it for v2, makes the code even easier :-)

Thanks for the feedback,

Moritz
