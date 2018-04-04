From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 04 Apr 2018 21:21:55 +0200
Subject: [PATCH 02/15] ARM: pxa: add dma slave map
In-Reply-To: <CAK8P3a21xkp5KkNRpnxJH1bSZjyiyO=f7_9XyyqvGS3EC=GBWg@mail.gmail.com>
 (Arnd Bergmann's message of "Wed, 4 Apr 2018 12:18:58 +0200")
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-3-robert.jarzmik@free.fr>
 <CAK8P3a3pSitVqfiF2LK0cMrAKLOeCWXXJBLeVc5f_Tg=vALkUA@mail.gmail.com>
 <87tvss48ti.fsf@belgarion.home>
 <CAK8P3a2FFVnPj4+VoQET3-Jz2DaYbc6UUJnX1fH5s8VumJZ7Og@mail.gmail.com>
 <87h8os3uwa.fsf@belgarion.home>
 <CAK8P3a21xkp5KkNRpnxJH1bSZjyiyO=f7_9XyyqvGS3EC=GBWg@mail.gmail.com>
Message-ID: <87d0ze4w18.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tue, Apr 3, 2018 at 10:19 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> ... chop chop removing unneeded recipients ....
>>
>> Arnd Bergmann <arnd@arndb.de> writes:
>>> It still feels odd to me that there is an entry in the slave map for
>>> a device that does not have a request line. However, it also seems
>>> that the entire code in those two drivers that deals with DMA is specific
>>> to PXA anyway, so maybe it can be done differently: instead of
>>> calling dma_request_slave_channel_compat() or dma_request_chan()
>>> with a fake request line, how about calling dma_request_channel()
>>> with an NULL filter function and data, and have the driver handle
>>> the empty data case the same way as the rq=-1 case today?
>> Okay, in this case :
>>  - the channel priority cannot be passed anymore
>
> Right, but it could just always use a static priority, right?
Yes, an implicit default priority. I'm not a big fan of implicit parameters, yet
I can do it.

>>  - and I don't see how this can work :
>>    dma_request_channel()
>>      __dma_request_channel()
>>        find_candidate()
>>          private_candidate(mask, device, fn, fn_param);
>>            /* Here, fn == NULL and fn_param == NULL as per your proposal */
>>
>>    This function will find the first available dma channel, all right, but
>>    no function will be called in pxa_dma driver, and therefore the last
>>    requestor of the channel will be used, which is bad.
>
> Can't you just reset those in pxad_free_chan_resources()?
I can, let's see what happens next ...

Cheers.

-- 
Robert
