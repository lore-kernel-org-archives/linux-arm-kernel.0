From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Nov 2014 14:24:51 +0100
Subject: [PATCH] ahci_sunxi: Drop AHCI_HFLAG_NO_PMP flag
In-Reply-To: <5465FA40.8000508@redhat.com>
References: <1415874256-6580-1-git-send-email-hdegoede@redhat.com>
 <20141113222952.GI2598@htj.dyndns.org>
 <037f97ce-468b-4b91-9616-51a3301c5be6@googlegroups.com>
 <5465FA40.8000508@redhat.com>
Message-ID: <546602A3.7010900@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/14/2014 01:49 PM, Hans de Goede wrote:
> Hi,
> 
> On 11/14/2014 12:56 PM, Hans de Goede wrote:
>> Hi,
>>
>> On Thursday, November 13, 2014 11:29:56 PM UTC+1, Tejun Heo wrote:
>>>
>>> On Thu, Nov 13, 2014 at 11:24:16AM +0100, Hans de Goede wrote: 
>>>> This is something which we inherited from the Allwinner android kernel 
>>> sources, 
>>>> and I've always wanted to test if this is really necessary. 
>>>>
>>>> So recently I've bought a sata port multiplexer, and I've given this a 
>>> test 
>>>> spin on both A10 and A20 devices, and it seems to work fine: 
>>>>
>>>> [    2.154456] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300) 
>>>> [    2.161092] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 5 ports, 
>>> feat 0x5/0xf 
>>>> [    2.175511] ata1.00: hard resetting link 
>>>> [    2.524929] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320) 
>>>> [    2.531430] ata1.01: hard resetting link 
>>>> [    2.974465] ata1.01: link resume succeeded after 1 retries 
>>>> [    3.094932] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300) 
>>>> [    3.101431] ata1.02: hard resetting link 
>>>> [    4.174466] ata1.02: failed to resume link (SControl 0) 
>>>> [    4.180065] ata1.02: SATA link down (SStatus 0 SControl 0) 
>>>> (and the same for links 3 and 4) 
>>>>
>>>> Once the NO_PMP flag is removed it correctly sees the 2 disks which I've 
>>>> attached, and I can mount and use them just fine, so lets drop the flag. 
>>>>
>>>> Signed-off-by: Hans de Goede <hdeg...@redhat.com <javascript:>> 
>>>
>>> Applied to libata/for-3.18-fixes. 
>>>
>>
>> I just found out why Allwinner added that AHCI_HFLAG_NO_PMP flag, after 
>> putting the system I used to test the port multiplexer back together this 
>> morning, it seems that probing for a port multiplexer being present breaks 
>> the no-port-multiplexer (so direct attached disk) case :(  I guess I should 
>> have tested for that before sending the patch, but the thought of it 
>> breaking normal usage did not cross my mind.
>>
>> So self NACK. If it is not too late, can you please drop this from your 
>> tree ?
>>
>> Let me know if you want me to send a revert instead.
>>
>> I'll look into fixing this another way, maybe with a quirk + an extra reset 
>> after failed pmp testing, and it that does not work a module option.
> 
> Ok, so the problem seems to be that the controller fails to do a soft-reset
> when attached directly to a normal device rather then to a pmp.
> 
> If I comment out this block of code in libata-core.c:
> 
>         if (sata_pmp_supported(link->ap) && ata_is_host_link(link)) {
>                 /* If PMP is supported, we have to do follow-up SRST.
>                  * Some PMPs don't send D2H Reg FIS after hardreset if
>                  * the first port is empty.  Wait only for
>                  * ATA_TMOUT_PMP_SRST_WAIT.
>                  */
>                 if (check_ready) {
>                         unsigned long pmp_deadline;
> 
>                         pmp_deadline = ata_deadline(jiffies,
>                                                     ATA_TMOUT_PMP_SRST_WAIT);
>                         if (time_after(pmp_deadline, deadline))
>                                 pmp_deadline = deadline;
>                         ata_wait_ready(link, pmp_deadline, check_ready);
>                 }
>                 rc = -EAGAIN;
>                 goto out;
>         }
> 
> Then things work again. This code looks like it is a must have for
> pmp use, so I'll do a follow up patch to my initial patch dropping the
> AHCI_HFLAG_NO_PMP flag, which re-adds it based on a module option
> (defaulting to the non-pmp case).
> 
> This way you don't have to do a forced-push to your tree to drop the
> original patch (or revert it).

Just saw your message that you've dropped the troublesome patch, in that
case I'll do a completely new patch, rather then a follow on patch, to
add a module option for this (unless you've a better idea).

Regards,

Hans
