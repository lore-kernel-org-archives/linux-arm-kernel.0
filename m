From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 21 Aug 2017 15:25:20 +0200
Subject: [PATCH v3] irqchip/tango: Don't use incorrect irq_mask_ack
 callback
In-Reply-To: <ee3119ec-75e9-376d-f1f1-630a9a17c660@arm.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
 <20170719190734.18566-3-opendmb@gmail.com>
 <7a51555f-8191-9ebd-1f30-7c20f6db9d3f@sigmadesigns.com>
 <8d29fec9-35b8-c33b-3091-3e9a51c99ed7@gmail.com>
 <dddc01e3-b4f0-1f94-db6a-e3d4b31e6f4d@sigmadesigns.com>
 <yw1xfudkodvv.fsf@mansr.com>
 <6f0092f7-692f-4a15-1d95-40f4e59c8585@sigmadesigns.com>
 <yw1xbmo8odan.fsf@mansr.com> <3b858e14-0da1-d4aa-eb84-f136ece8c2a6@gmail.com>
 <yw1x4ltzm2ok.fsf@mansr.com> <48734beb-0e6b-3a8f-ebf4-b1cec63322e5@gmail.com>
 <fb868111-bcff-9a12-70db-a820d3bbffd0@sigmadesigns.com>
 <ee3119ec-75e9-376d-f1f1-630a9a17c660@arm.com>
Message-ID: <a0dc9054-9c37-cc3b-eca5-f68080d5731c@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2017 14:56, Marc Zyngier wrote:

> On 28/07/17 15:06, Marc Gonzalez wrote:
>
>> On 27/07/2017 20:17, Florian Fainelli wrote:
>>
>>> On 07/26/2017 12:13 PM, M?ns Rullg?rd wrote:
>>>
>>>> Florian Fainelli writes:
>>>>
>>>>> On 07/25/2017 06:29 AM, M?ns Rullg?rd wrote:
>>>>>
>>>>>> Marc Gonzalez writes:
>>>>>>
>>>>>>> On 25/07/2017 15:16, M?ns Rullg?rd wrote:
>>>>>>>
>>>>>>>> What happened to the patch adding the proper combined function?
>>>>>>>
>>>>>>> It appears you're not CCed on v2.
>>>>>>>
>>>>>>> https://patchwork.kernel.org/patch/9859799/
>>>>>>>
>>>>>>> Doug wrote:
>>>>>>>> Yes, you understand correctly.  The irq_mask_ack method is entirely
>>>>>>>> optional and I assume that is why this issue went undetected for so
>>>>>>>> long; however, it is slightly more efficient to combine the functions
>>>>>>>> (even if the ack is unnecessary) which is why I chose to do so for my
>>>>>>>> changes to the irqchip-brcmstb-l2 driver where I first discovered this
>>>>>>>> issue.  How much value the improved efficiency has is certainly
>>>>>>>> debatable, but interrupt handling is one area where people might care
>>>>>>>> about such a small difference.  As the irqchip-tango driver maintainer
>>>>>>>> you are welcome to decide whether or not the irq_mask_ack method makes
>>>>>>>> sense to you.
>>>>>>>
>>>>>>> My preference goes to leaving the irq_mask_ack callback undefined,
>>>>>>> and let the irqchip framework use irq_mask and irq_ack instead.
>>>>>>
>>>>>> Why would you prefer the less efficient way?
>>>>>
>>>>> Same question here, that does not really make sense to me.
>>>>>
>>>>> The whole point of this patch series is to have a set of efficient and
>>>>> bugfree (or nearly) helper functions that drivers can rely on, are you
>>>>> saying that somehow using irq_mask_and_ack is exposing a bug in the
>>>>> tango irqchip driver and using the separate functions does not expose
>>>>> this bug?
>>>>
>>>> There is currently a bug in that the function used doesn't do what its
>>>> name implies which can't be good.  Using the separate mask and ack
>>>> functions obviously works, but combining them saves a lock/unlock
>>>> sequence.  The correct combined function has already been written, so I
>>>> see no reason not to use it.
>>>
>>> Marc/Mason, are you intending to get this patch accepted in order to
>>> provide a quick bugfix targeting earlier kernels with the tango irqchip
>>> driver or is this how you think the correct fix for the tango irqchip
>>> driver is as opposed to using Doug's fix?
>>
>> Hello Florian,
>>
>> I am extremely grateful for you and Doug bringing the defect to
>> my attention, as it was indeed causing an issue which I had not
>> found the time to investigate.
>>
>> The reason I proposed an alternate patch is that
>> 1) Doug didn't seem to mind, 2) simpler code leads to fewer bugs
>> and less maintenance IME, and 3) I didn't see many drivers using
>> the irq_mask_ack() callback (9 out of 86) with a few misusing it,
>> by defining irq_mask = irq_mask_ack.
>>
>> As you point out, my patch might be slightly easier to backport
>> than Doug's (TBH, I hadn't considered that aspect until you
>> mentioned it).
>>
>> Has anyone ever quantified the performance improvement of
>> mask_ack over mask + ack?
> 
> Aren't you the one who is in position of measuring this effect on the
> actual HW that uses this?

Using separate mask and ack functions (i.e. my patch)

# iperf3 -c 172.27.64.110 -t 20
Connecting to host 172.27.64.110, port 5201
[  4] local 172.27.64.1 port 40868 connected to 172.27.64.110 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec   106 MBytes   888 Mbits/sec   18    324 KBytes       
[  4]   1.00-2.00   sec   106 MBytes   885 Mbits/sec    0    361 KBytes       
[  4]   2.00-3.00   sec   105 MBytes   883 Mbits/sec    4    279 KBytes       
[  4]   3.00-4.00   sec   106 MBytes   890 Mbits/sec    0    300 KBytes       
[  4]   4.00-5.00   sec   106 MBytes   887 Mbits/sec    0    310 KBytes       
[  4]   5.00-6.00   sec   105 MBytes   883 Mbits/sec    0    315 KBytes       
[  4]   6.00-7.00   sec   105 MBytes   885 Mbits/sec    0    321 KBytes       
[  4]   7.00-8.00   sec   105 MBytes   880 Mbits/sec    0    325 KBytes       
[  4]   8.00-9.00   sec   106 MBytes   888 Mbits/sec    0    329 KBytes       
[  4]   9.00-10.00  sec   106 MBytes   886 Mbits/sec    0    335 KBytes       
[  4]  10.00-11.00  sec   105 MBytes   885 Mbits/sec    0    351 KBytes       
[  4]  11.00-12.00  sec   106 MBytes   887 Mbits/sec    1    276 KBytes       
[  4]  12.00-13.00  sec   106 MBytes   885 Mbits/sec    0    321 KBytes       
[  4]  13.00-14.00  sec   105 MBytes   883 Mbits/sec    0    349 KBytes       
[  4]  14.00-15.00  sec   106 MBytes   890 Mbits/sec    0    366 KBytes       
[  4]  15.00-16.00  sec   106 MBytes   888 Mbits/sec    2    286 KBytes       
[  4]  16.00-17.00  sec   105 MBytes   884 Mbits/sec    0    303 KBytes       
[  4]  17.00-18.00  sec   105 MBytes   883 Mbits/sec    0    311 KBytes       
[  4]  18.00-19.00  sec   105 MBytes   880 Mbits/sec    0    315 KBytes       
[  4]  19.00-20.00  sec   106 MBytes   890 Mbits/sec    0    321 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-20.00  sec  2.06 GBytes   885 Mbits/sec   25             sender


Using combined mask and ack functions (i.e. Doug's patch)

# iperf3 -c 172.27.64.110 -t 20
Connecting to host 172.27.64.110, port 5201
[  4] local 172.27.64.1 port 41235 connected to 172.27.64.110 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec   107 MBytes   897 Mbits/sec   60    324 KBytes       
[  4]   1.00-2.00   sec   107 MBytes   898 Mbits/sec    0    361 KBytes       
[  4]   2.00-3.00   sec   107 MBytes   898 Mbits/sec   39    194 KBytes       
[  4]   3.00-4.00   sec   107 MBytes   895 Mbits/sec    0    214 KBytes       
[  4]   4.00-5.00   sec   107 MBytes   901 Mbits/sec    0    223 KBytes       
[  4]   5.00-6.00   sec   108 MBytes   902 Mbits/sec    0    230 KBytes       
[  4]   6.00-7.00   sec   107 MBytes   895 Mbits/sec    0    242 KBytes       
[  4]   7.00-8.00   sec   107 MBytes   901 Mbits/sec    0    253 KBytes       
[  4]   8.00-9.00   sec   107 MBytes   899 Mbits/sec    0    264 KBytes       
[  4]   9.00-10.00  sec   108 MBytes   903 Mbits/sec    0    276 KBytes       
[  4]  10.00-11.00  sec   108 MBytes   902 Mbits/sec    0    286 KBytes       
[  4]  11.00-12.00  sec   107 MBytes   899 Mbits/sec    0    300 KBytes       
[  4]  12.00-13.00  sec   107 MBytes   898 Mbits/sec   33    247 KBytes       
[  4]  13.00-14.00  sec   107 MBytes   900 Mbits/sec    0    294 KBytes       
[  4]  14.00-15.00  sec   107 MBytes   900 Mbits/sec    0    325 KBytes       
[  4]  15.00-16.00  sec   107 MBytes   899 Mbits/sec    0    342 KBytes       
[  4]  16.00-17.00  sec   107 MBytes   898 Mbits/sec    0    351 KBytes       
[  4]  17.00-18.00  sec   108 MBytes   902 Mbits/sec    0    355 KBytes       
[  4]  18.00-19.00  sec   107 MBytes   901 Mbits/sec    0    359 KBytes       
[  4]  19.00-20.00  sec   108 MBytes   903 Mbits/sec   32    255 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-20.00  sec  2.09 GBytes   900 Mbits/sec  164             sender


Ergo, it seems that the performance improvement of the combined
implementation is approximately 1.5% for a load generating ~80k
interrupts per second.

I suppose a 1.5% improvement for free should not be ignored.
Therefore, I rescind my v3 patch.

Doug/Florian, thanks again for fixing the tango driver.

Regards.
