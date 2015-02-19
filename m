From: torfl6749@gmail.com (Torsten Fleischer)
Date: Thu, 19 Feb 2015 08:54:22 +0100
Subject: [PATCH 1/2] dma: at_hdmac: Fix calculation of the residual bytes
In-Reply-To: <20150218150216.GE32600@odux.rfo.atmel.com>
References: <1423387744-2410-1-git-send-email-torfl6749@gmail.com>
 <1423387744-2410-2-git-send-email-torfl6749@gmail.com>
 <20150218150216.GE32600@odux.rfo.atmel.com>
Message-ID: <CANZ4BrQwEei8GsskU2jrDbd4z+DDoq0U8S3sa947=+EuUMavwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ludovic,

>>
>> transfer 1: residue = 975584
>> transfer 2: residue = 1048380
>>
>
> You're right about these points. Good job. I think it should be sent to
> stable if it can be applied properly.
>
> For multilines comments, please follow the coding rule
> /*
>  * my
>  * comments
>  */
>
thanks for the hint. I will fix this in the next version of the patch.

>> +     /* cookie matches to the currently running transfer */
>> +     ret = desc_first->total_len;
>> +
>> +     if (desc_first->lli.dscr) {
>> +             /* hardware linked list transfer */
>> +
>> +             /* Calculate the residue by removing the length of the child
>> +              * descriptors already transferred from the total length.
>> +              * To get the current child descriptor we can use the value of
>> +              * the channel's DSCR register and compare it against the value
>> +              * of the hardware linked list structure of each child
>> +              * descriptor. */
>> +
>> +             dscr = channel_readl(atchan, DSCR);
>> +
>> +             /* the first descriptor is currently in work */
>> +             if (desc_first->lli.dscr == dscr)
>> +                     return ret;
>>
>
> Why returning total_len in this case? I think you can return a more accurate
> value as you do for the last descriptor.
>
Good point. I will add a calculation for the first descriptor.

Regards

Torsten
