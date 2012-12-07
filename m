From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 7 Dec 2012 13:54:23 +0530
Subject: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <50BE2115.4000606@ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-5-git-send-email-rtivy@ti.com> <50AB76FA.1050505@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F952B@DFLE08.ent.ti.com>
 <50B88F7C.5000705@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FAC29@DFLE08.ent.ti.com>
 <50BCBA26.4070608@ti.com> <50BD07D8.5000305@ti.com> <50BD90F6.4080102@ti.com>
 <50BE0E54.5060607@ti.com> <50BE2115.4000606@ti.com>
Message-ID: <50C1A7B7.1020502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/4/2012 9:43 PM, Murali Karicheri wrote:
> On 12/04/2012 09:53 AM, Murali Karicheri wrote:
>> On 12/04/2012 12:58 AM, Sekhar Nori wrote:
>>> On 12/4/2012 1:43 AM, Cyril Chemparathy wrote:
>>>
>>>> On 12/03/2012 09:41 AM, Sekhar Nori wrote:
>>>>> On 12/1/2012 7:41 AM, Tivy, Robert wrote:
>>>>> Passing function pointers from platform code will not work when
>>>>> converting to device tree (DT). DA850 will gain DT boot with v3.8 and
>>>>> there is work ongoing on converting drivers to be DT-aware. Adding
>>>>> a new
>>>>> driver which is DT-incompatible will not be right. Hence, I will not
>>>>> recommend this now.
>>>> Not sure if this solves your problem, but you could add a new clock
>>>> type
>>>> (PSC_LRESET?) as a child under the PSC clock node for the DSP.
>>>> Something
>>>> like:
>>>>
>>>>    |
>>>>    +-- PSC x (DSP0 clock)
>>>>    |    |
>>>>    |    +-- PSC-LRESET x (DSP0 reset control)
>>>>    |
>>>>    +-- PSC y (DSP1 clock)
>>>>    |    |
>>>>    |    +-- PSC-LRESET y (DSP1 reset control)
>>>>    |
>>>>    +-- PSC z (DSP2 clock)
>>>>    |    |
>>>>    |    +-- PSC-LRESET z (DSP2 reset control)
>>>>
>>>>
>>>> The idea here being that if you enable the PSC clocks, you enable the
>>>> clock gates, but leave the DSPs in reset.  On the other hand, if you
>>>> enable the reset clock, the code implicitly enables the gate (via
>>>> parent), and takes the DSP out of reset as well.
>>>>
>>>> This is not quite the cleanest way to do it, considering that reset
>>>> lines have no business in the clock tree, but then, this is probably
>>>> the
>>>> simplest way to fit in.  Thoughts?
>>> This may work (on a technical level), but I am not really a fan of this
>>> since this is essentially a hack, as you (almost) point out. It does not
>>> model the hardware clock tree correctly and we are still struck with
>>> using clock APIs for reset control.
>>>
>>> I still think we need to find a better method of dealing with IP reset.
>>> May be an acceptable method already exists. Some one needs to summarize
>>> the problem statement well enough and I am sure finding the right
>>> solution will not be too long drawn.
>>>
>>> Thanks,
>>> Sekhar
>>> _______________________________________________
>>> Davinci-linux-open-source mailing list
>>> Davinci-linux-open-source at linux.davincidsp.com
>>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>>>
>>>
>> I believe this is addressing the same issue. This is a DT based
>> solution, which I believe should add a framework and enhance it to
>> support DT.
> Forgot to paste the link. Here we go
> 
> https://patchwork.kernel.org/patch/1635051/

Rob,

Since there is a solution for reset handling proposed but seems to be
slightly far from taking a concrete shape, I suggest you go ahead and
implement davinci reset using a platform private API ala Tegra.

You can create and send the patches. I will review and accept them but
not send them upstream immediately.

Lets wait till v3.8-rc4. If there is a generic solution that is merged
by that time, I will ask you to use that instead of your API (this will
give you about 2 weeks to convert). If the generic solution is not
merged by that time, I will send your private API to the upstreams for
v3.9 and we can convert to generic solution for later kernel versions.

This should give you a fair chance to get remoteproc working on DA850
for v3.9.

Sounds like a plan? The remoteproc folks need to agree too. I am copying
Ohad here.

Meanwhile I do suggest you work with Stephen and Mike in giving shape to
the reset API so it suits your needs when it gets ready.

Thanks,
Sekhar
