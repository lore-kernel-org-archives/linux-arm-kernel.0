From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Jul 2016 10:01:15 -0600
Subject: [PATCH] ARM: tegra: fix erroneous address in dts
In-Reply-To: <8a8ccb29-ba73-f29f-2b57-5c1d91e13bf7@ramses-pyramidenbau.de>
References: <1468514937-23250-1-git-send-email-ralf@ramses-pyramidenbau.de>
 <20160714220218.GB4205@mithrandir.ba.sec>
 <8a8ccb29-ba73-f29f-2b57-5c1d91e13bf7@ramses-pyramidenbau.de>
Message-ID: <578908CB.7040802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2016 03:37 AM, Ralf Ramsauer wrote:
> On 07/15/2016 12:02 AM, Thierry Reding wrote:
>> On Thu, Jul 14, 2016 at 06:48:57PM +0200, Ralf Ramsauer wrote:
>>> c90bb7b enabled the high speed UARTs of the Jetson TK1. The address
>>> specification inside the dts is wrong. Fix it and use the correct
>>> address.
>>>
>>> Fixes: c90bb7b9b9 ("ARM: tegra: Add high speed UARTs to Jetson TK1 device tree")
>>> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
>>> ---
>>>   arch/arm/boot/dts/tegra124-jetson-tk1.dts | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> These addresses are correct. The 0, prefix was dropped from the unit
>> address in commit b5896f67ab3c ("ARM: tegra: Remove commas from unit
>> addresses on Tegra124").
>>
>> What's the problem that you're seeing? What's not working for you?
 >
> I cannot find b5896f67ab3c neither in swarren's tree nor in linux
> upstream. But there's d0bc5aaf890 in swarren's linux-tegra tree that
> matches your described changes and was committed on 1st of July. But
> this patch is not upstream yet, while the other patch is.

The fix is in linux-next, and will be in mainline soon I expect.

My github linux-tegra.git isn't relevant since it's just my own personal 
dev branch, but for reference, the commit is there since it's based on 
linux-next.

> Have a look at mainline tegra124-jetson-tk1.dts, there the addresses are
> erroneous as they still use the 0, annotation. And I just realised, that
> somehow, upstream patch c90bb7b slightly differs from my initial patch
> [1] on the mailing list.

Your patch should probably be CC: stable so that existing kernel 
versions get fixed. That said, I'd argue that since the original patch 
never actually had any effect since it applied to the wrong node, the 
best fix for stable kernels is simply to revert it rather than fixing 
it, to avoid the potential for behaviour changes and regressions. 
Starting with kernel 4.8 (I think), that patch will begin to have actual 
effect.
