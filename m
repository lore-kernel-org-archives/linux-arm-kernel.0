From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 01 Aug 2013 23:51:06 +0200
Subject: [PATCH v3 1/3] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <20130731103507.GF23681@mudshark.cambridge.arm.com>
References: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
 <51F28A20.7060105@hauke-m.de>
 <20130726165311.GH17886@mudshark.cambridge.arm.com>
 <201307272149.17108.arnd@arndb.de>
 <20130730133601.GN11527@mudshark.cambridge.arm.com>
 <51F827EC.3090104@hauke-m.de>
 <20130731103507.GF23681@mudshark.cambridge.arm.com>
Message-ID: <51FAD84A.4070701@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 12:35 PM, Will Deacon wrote:
> On Tue, Jul 30, 2013 at 09:54:04PM +0100, Hauke Mehrtens wrote:
>> On 07/30/2013 03:36 PM, Will Deacon wrote:
>>> On Sat, Jul 27, 2013 at 08:49:16PM +0100, Arnd Bergmann wrote:
>>>> On Friday 26 July 2013, Will Deacon wrote:
>>>>>>> At least, we need a pretty good explanation of what exactly is causing
>>>>>>> these spurious aborts before we start ignoring them unconditionally like
>>>>>>> this. You're effectively masking an extremely serious error indicator with
>>>>>>> this change.
>>>>>>
>>>>>> This fault occurs once every boot sometime early in the boot process,
>>>>>> but the actual time this happens varies randomly.
>>>>>
>>>>> Well that's interesting in itself. It sounds like we don't know *for sure*
>>>>> whether the abort is triggered by Linux. Since the abort is imprecise, the
>>>>> timing will vary.
>>>>
>>>> It might be possible to find out the culprit if you just enter an endless loop
>>>> in the early kernel boot code. If you enter the loop before Linux does something
>>>> wrong, it won't crash, otherwise it will. After that, you could bisect the
>>>> boot process by moving the busy loop around.
>>>>
>>>> If it even crashes at the point where Linux gets entered, it's a bug in the
>>>> boot loader.
>>>
>>> Can you give Arnd's suggestion a go please Hauke?
>>
>> Hi
>>
>> I just tried that, but it did not crash in the loop. :-(
> 
> Turn that frown around -- this is a useful result! It means that the abort
> is likely caused by the kernel, rather than the boot loader (although we
> still can't rule it out, it depends where you put the loop).
> 
>> Now, with 3.11-rc3 it crashed reproducible after Freeing unused kernel
>> memory, see this:
>>
>> [    0.859198] Freeing unused kernel memory: 1124K (c0260000 - c0379000)
>> [    0.866298] Unhandled fault: imprecise external abort (0x1c06) at
>> 0xb6f8b005
>> [    0.873538] Kernel panic - not syncing: Attempted to kill init!
>> exitcode=0x00000007
>>
>> Do you have some more informations about this type of error?
> 
> Hmm, so that's now exploding on a user address. Is this an A9-based SoC? If
> so, can you try disabling PL310 (CONFIG_CACHE_L2X0) and see if it makes a
> different please?

This is a A9-based SoC.

I already had PL310 disabled, now I tried to activate it, but I do not
see any difference.

[    1.049381] Freeing unused kernel memory: 1128K (c0261000 - c037b000)
[    1.056501] Unhandled fault: imprecise external abort (0x1c06) at
0xb6f34005
[    1.063738] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000007

Hauke
