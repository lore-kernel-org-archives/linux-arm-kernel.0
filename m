From: arvind.yadav.cs@gmail.com (arvindY)
Date: Fri, 8 Dec 2017 15:08:38 +0530
Subject: [PATCH 4/7 v2] net: ethernet: i825xx: Fix platform_get_irq's
 error checking
In-Reply-To: <d0b7e1cc-4190-437a-6461-35cee6edc203@cogentembedded.com>
References: <1512409703-20881-5-git-send-email-arvind.yadav.cs@gmail.com>
 <20171204.132556.1601454745789376393.davem@davemloft.net>
 <39363858-995c-eea4-070e-b21a7ac49bec@gmail.com>
 <20171205.104947.121188625730183933.davem@davemloft.net>
 <d0b7e1cc-4190-437a-6461-35cee6edc203@cogentembedded.com>
Message-ID: <5A2A5D9E.9040907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Wednesday 06 December 2017 05:49 PM, Sergei Shtylyov wrote:
> On 12/05/2017 06:49 PM, David Miller wrote:
>
>>>> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>>> Date: Mon,  4 Dec 2017 23:18:20 +0530
>>>>
>>>>> @@ -120,9 +120,10 @@ static int sni_82596_probe(struct 
>>>>> platform_device
>>>>> *dev)
>>>>>        netdevice->dev_addr[5] = readb(eth_addr + 0x06);
>>>>>        iounmap(eth_addr);
>>>>>    -    if (!netdevice->irq) {
>>>>> +    if (netdevice->irq <= 0) {
>>>>>            printk(KERN_ERR "%s: IRQ not found for i82596 at 0x%lx\n",
>>>>>                __FILE__, netdevice->base_addr);
>>>>> +        retval = netdevice->irq ? netdevice->irq : -ENODEV;
>>>>>            goto probe_failed;
>>>>>        }
>>>> Ok, thinking about this some more...
>>>>
>>>> It is impossible to use platform_get_irq() without every single call
>>>> site having this funny:
>>>>
>>>>     ret = val ? val : -ENODEV;
>>>>
>>>> sequence.
>>>>
>>>> This is unnecessary duplication and it is also error prone, so I
>>>> really think this logic belongs in platform_get_irq() itself.  It can
>>>> convert '0' to -ENODEV and that way we need no special logic in the
>>>> callers at all.
>>> platform_get_irq() will return 0 only for sparc, If sparc initialize
>>> platform
>>> data irq[PROMINTR_MAX] as zero. Otherwise platform_get_irq() will
>>> never return
>>> 0. It will return either IRQ number or error (as negative number). But
>>> I am getting
>>> review comment by reviewer/maintainer in other subsystem to add check
>>> for
>>> zero. So I have done same changes here. Please correct me if i am
>>> wrong.
>>
>> If you make the change that I suggest, you instead can check for
>
>    I assume such change is needed only for the SPARC-specific section 
> of platform_get_irq()?
>
>> '-ENODEV' to mean no IRQ.
>
>    No specific error check is needed, just irq < 0 check should be 
> enough...
> Also, looking at platform_get_irq(), -ENXIO should be returned in this 
> case.
>
> MBR, Sergei
Is it ok. If We will add a check for only < 0.

Regards
Arvind
