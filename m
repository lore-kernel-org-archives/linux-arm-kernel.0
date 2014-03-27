From: zhangfei.gao@linaro.org (zhangfei)
Date: Thu, 27 Mar 2014 20:53:00 +0800
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <7101996.LQrASEuksF@wuerfel>
References: <1395670496-17381-1-git-send-email-zhangfei.gao@linaro.org>
 <21873900.AIOr1ryy37@wuerfel>
 <1395768102.12610.159.camel@edumazet-glaptop2.roam.corp.google.com>
 <7101996.LQrASEuksF@wuerfel>
Message-ID: <53341F2C.2030303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/26/2014 01:54 AM, Arnd Bergmann wrote:
> On Tuesday 25 March 2014 10:21:42 Eric Dumazet wrote:
>> On Tue, 2014-03-25 at 18:05 +0100, Arnd Bergmann wrote:
>>> On Tuesday 25 March 2014 10:00:30 Florian Fainelli wrote:
>>>
>>>> Using a timer to ensure completion of TX packets is a trick that
>>>> worked in the past, but now that the networking stack got smarter,
>>>> this might artificially increase the processing time of packets in the
>>>> transmit path, and this will defeat features like TCP small queues
>>>> etc.. as could be seen with the mvneta driver [1]. The best way really
>>>> is to rely on TX completion interrupts when those exist as they cannot
>>>> lie about the hardware status (in theory) and they should provide the
>>>> fastest way to complete TX packets.
>>>
>>> By as Zhangfei Gao pointed out, this hardware does not have a working
>>> TX completion interrupt. Using timers to do this has always just been
>>> a workaround for broken hardware IMHO.
>>
>> For this kind of drivers, calling skb_orphan() from ndo_start_xmit() is
>> mandatory.
>
> Cool, thanks for the information, I was wondering already if there was
> a way to deal with hardware like this.
>

That's great,
In the experiment, keeping reclaim in the ndo_start_xmit always get the 
best throughput, also simpler, even no requirement of spin_lock.

By the way, still have confusion about build_skb.

At first, I thought we can malloc n*buffers as a ring and keep using 
them for dma, every time when packet coming, using build_skb adds a 
head, send to upper layer.
After data is consumed, we can continue reuse the buffer next time.

However, in the iperf stress test, always error happen.
The buffer is released in fact, and we need alloc new buffer for the 
next transfer.

So the build_skb is not used for reusing buffers, but only for keeping 
hot data in cache, right?

Thanks
