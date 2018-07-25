From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 25 Jul 2018 21:06:39 +0000
Subject: arm: mach-mvebu: dts: enable-method is always overwritten
References: <a2d4701e-28b3-07ee-6b2f-588b2e9a75c4@online.net>
 <20180608155858.GB19702@lunn.ch>
 <c26a750dbd25440bb9c3f669f757c491@svr-chch-ex1.atlnz.lc>
 <63a47bee-d550-fc05-a1f7-32d2a0d01d4f@online.net>
Message-ID: <d80ce42e79954ec2a7f6b0cc25598563@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yves,

On 25/07/18 21:06, Yves Lefloch wrote:
> 
> 
> On 11/06/2018 02:48, Chris Packham wrote:
>> Hi Yves,
>>
>> On 09/06/18 03:59, Andrew Lunn wrote:
>>> On Fri, Jun 08, 2018 at 05:43:11PM +0200, Yves Lefloch wrote:
>>>> Hello everybody,
>>>
>>> Adding Chris Packham. He did some work in this area.
>>>
>>>           Andrew
>>>
>>>>
>>>> I'm facing an issue that I believe to be a conflict between device-tree and
>>>> machine_desc.
>>>>
>>>> My platform is arm/mach-mvebu. I have a DT based on "armada-xp-db-dxbc2.dts"
>>>> (I just included it and added a few okays), my CPU is a Marvell Bobcat2
>>>> switching chip. My kernel is a vanilla 4.16.
>>>>
>>>> Everything works fine except that my second core won't boot: `CPU1: failed
>>>> to come online'.
>>>> I tracked down the problem to arch/arm/mach-mvebu/platsmp.c: in this file is
>>>> defined a machine_desc that hardcodes the SMP ops to `marvell,armada-xp-smp'
>>>> whereas my device tree (by including armada-xp-98dx3236.dtsi) attempts to
>>>> set the ops to `marvell,98dx3236-smp' through enable-method. In setup_arch()
>>>> the machine_desc's ops overwrites the enable-method's ops, causing the wrong
>>>> smp_boot_secondary() call to be issued.
>>>>
>>>> Now there is a note from 2014 saying that this machine_desc's `smp' field is
>>>> hardcoded like that because of "old Device Trees that were not specifying
>>>> the cpus enable-method property". As far as I can tell, this is still the
>>>> case, for instance "armada-370-db.dts" doesn't have any enable-method
>>>> property.
>>>>
>>>> I have worked around this by commenting out `armada_xp_smp_ops.smp' but
>>>> obviously I would prefer to keep a vanilla kernel.
>>>>
>>>> So I propose to:
>>>> - Add `enable-method = "marvell,armada-xp-smp"' to armada-370-xp.dtsi,
>>>> because it seems that all Armada 370/XP include it;
>>>> - Remove the `smp' field of `armada_xp_smp_ops'.
>>>>
>>>> If you agree with the diagnosis and the proposed fix I will write a patch.
>>
>> Personally my preferred option is to not set .smp at all and let the
>> device tree do it's thing.
>>
>> I'm not sure if things have changed w.r.t. backwards compatibility in
>> the 3.5 years since I initially suggested that, assuming that we still
>> want backwards compatibility with these older device trees this patch
>> might help
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303899.html
>>
>> I was pretty happy with that approach at the time but I obviously never
>> followed up to get that delivered. If someone has some spare cycles to
>> spend on it I wouldn't object to it being taken over.
>>
>> I'll see if I can find some time to resurrect it myself. I don't have an
>> Armada-370 board but I can test BC2 and A38x.
>>
> 
> Hi Chris,
> 
> I've tried the patch that is on your link above. It does solve my issue, and it
> is neater than what I suggested because it indeed preserves backward compatibility.

Glad to hear.

> I could only test on BC2 though, because it's the only platform that I have.
> 
> How would you like to proceed to carry this thing further? Do you have time to
> post the patch again or do you want me to do it?

I can resurrect the patch and test it on a few platforms here. I'll Cc 
you so you can test it as well.
