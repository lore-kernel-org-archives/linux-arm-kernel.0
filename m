From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 4 Aug 2014 23:33:17 -0300
Subject: Suspend/resume broken on mx5/mx6 running 4.16
In-Reply-To: <CAOMZO5D0a96m0NPibN5pHOMsu+muHygeb=oqPd=etG8WjgyAwQ@mail.gmail.com>
References: <CAOMZO5BN9H-4__2s9yyGiuOBsLO0gf9LOQ0_N1552P8LWJTxCg@mail.gmail.com>
 <20140804181106.GI30282@n2100.arm.linux.org.uk>
 <CAOMZO5D0a96m0NPibN5pHOMsu+muHygeb=oqPd=etG8WjgyAwQ@mail.gmail.com>
Message-ID: <CAOMZO5DhTk+Pd=77OB5nfQonjwHMdozi4C4bzfWLyYXz3_xHsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 4, 2014 at 3:21 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Russell,
>
> On Mon, Aug 4, 2014 at 3:11 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>
>> Right, so the code which oopsed was:
>>
>>    0:   e1a0c00d        mov     ip, sp
>>    4:   e92dd818        push    {r3, r4, fp, ip, lr, pc}
>>    8:   e24cb004        sub     fp, ip, #4
>>    c:   e5904088        ldr     r4, [r0, #136]  ; 0x88
>>   10:   e594302c        ldr     r3, [r4, #44]   ; 0x2c
>>
>> and from the above, we can see that r4 was NULL.
>>
>> fec_suspend(struct device *dev)
>> {
>>         struct net_device *ndev = dev_get_drvdata(dev);
>>
>> which would make ndev NULL.  I don't see how that could happen though,
>> as we set the driver data in the probe function.  Any patches on top of
>> 3.16?
>
> Yes, I still do not understand why we are getting this NULL pointer
> inside fec_suspend().
>
> I am using the original 3.16 with no other patches on top.

I managed to bisect it. Will start a thread at netdev about it.
