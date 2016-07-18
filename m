From: ralf@ramses-pyramidenbau.de (Ralf Ramsauer)
Date: Mon, 18 Jul 2016 11:25:33 +0200
Subject: [PATCH] ARM: tegra: fix erroneous address in dts
In-Reply-To: <20160718060129.GA10785@ulmo.ba.sec>
References: <1468514937-23250-1-git-send-email-ralf@ramses-pyramidenbau.de>
 <20160714220218.GB4205@mithrandir.ba.sec>
 <8a8ccb29-ba73-f29f-2b57-5c1d91e13bf7@ramses-pyramidenbau.de>
 <578908CB.7040802@wwwdotorg.org>
 <4a4d7fd4-7514-c5cb-435b-af34159fc1c4@ramses-pyramidenbau.de>
 <20160718060129.GA10785@ulmo.ba.sec>
Message-ID: <64837117-32d6-1f1d-a370-3f20d4368b7b@ramses-pyramidenbau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/18/2016 08:01 AM, Thierry Reding wrote:
> On Fri, Jul 15, 2016 at 06:18:03PM +0200, Ralf Ramsauer wrote:
>> On 07/15/2016 06:01 PM, Stephen Warren wrote:
>>> On 07/15/2016 03:37 AM, Ralf Ramsauer wrote:
>>>> On 07/15/2016 12:02 AM, Thierry Reding wrote:
>>>>> On Thu, Jul 14, 2016 at 06:48:57PM +0200, Ralf Ramsauer wrote:
>>>>>> c90bb7b enabled the high speed UARTs of the Jetson TK1. The address
>>>>>> specification inside the dts is wrong. Fix it and use the correct
>>>>>> address.
>>>>>>
>>>>>> Fixes: c90bb7b9b9 ("ARM: tegra: Add high speed UARTs to Jetson TK1
>>>>>> device tree")
>>>>>> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
>>>>>> ---
>>>>>>   arch/arm/boot/dts/tegra124-jetson-tk1.dts | 4 ++--
>>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> These addresses are correct. The 0, prefix was dropped from the unit
>>>>> address in commit b5896f67ab3c ("ARM: tegra: Remove commas from unit
>>>>> addresses on Tegra124").
>>>>>
>>>>> What's the problem that you're seeing? What's not working for you?
>>>>
>>>> I cannot find b5896f67ab3c neither in swarren's tree nor in linux
>>>> upstream. But there's d0bc5aaf890 in swarren's linux-tegra tree that
>>>> matches your described changes and was committed on 1st of July. But
>>>> this patch is not upstream yet, while the other patch is.
>>>
>>> The fix is in linux-next, and will be in mainline soon I expect.
>> Ah okay, but I still wonder how my original patch got changed on its
>> way... The original version on the mailinglist was not buggy.
> 
> It's most likely my fault. My recollection is that we used to have an
> earlier patch that removed all 0, prefixes from unit addresses and what
> happens is probably that I applied your patch on top, adjusted it to
> omit the 0, prefix and then we noticed that removing the 0, prefix does
> not work for the GPU (because U-Boot looks it up by node name to enable
> it), so the patch that removes the 0, prefix was dropped and I forgot
> to adjust your patch to compensate.
Ok, i see.
> 
>>> My github linux-tegra.git isn't relevant since it's just my own personal
>>> dev branch, but for reference, the commit is there since it's based on
>>> linux-next.
>>>
>>>> Have a look at mainline tegra124-jetson-tk1.dts, there the addresses are
>>>> erroneous as they still use the 0, annotation. And I just realised, that
>>>> somehow, upstream patch c90bb7b slightly differs from my initial patch
>>>> [1] on the mailing list.
>>>
>>> Your patch should probably be CC: stable so that existing kernel
>>> versions get fixed. That said, I'd argue that since the original patch
>>> never actually had any effect since it applied to the wrong node, the
>>> best fix for stable kernels is simply to revert it rather than fixing
>>> it, to avoid the potential for behaviour changes and regressions.
>>> Starting with kernel 4.8 (I think), that patch will begin to have actual
>>> effect.
>> There is no current existing stable kernel that is affected, as it went
>> in during the last merge window in 4.6-rc1. So no need for fixing
>> stable. Maybe it's still possible to fix it as the stabilisation window
>> is still open and 4.7 is not released yet?
> 
> Unfortunately a patch to remove the 0, prefix from all nodes except the
> GPU was now merged into the arm-soc tree, which means that if we try to
> get this into v4.7, then we'll have to make sure to patch up the unit
> address again for v4.8.
> 
> I have no objections to doing that, so feel free to add my Acked-by and
> resend this to arm at kernel.org. When you do, please keep linux-tegra in
> Cc so that we can track it, and maybe mention that you want this to go
> into v4.7 and how this came about to be, so that the arm-soc maintainers
> won't be surprised when the patch to revert this shows up in a couple of
> days for v4.8.
Alright, I'll prepare it and add a RESEND as well as your Acked-by.
Thank you.
> 
> Can you take care of sending out the second patch as well? Probably best
> to send it the same way as this, with a mention that it's targetted at
> v4.8 and a revert of this one.
Yep, I'll take care of it. I'm tracking this patch since January in any
case :-)

  Ralf
> 
> Thanks,
> Thierry
> 

-- 
Ralf Ramsauer
PGP: 0x8F10049B

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160718/38b77777/attachment.sig>
