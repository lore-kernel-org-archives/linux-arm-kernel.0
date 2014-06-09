From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 09 Jun 2014 12:29:21 -0600
Subject: [PATCH v7 3/5] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <20140606073507.GS5961@tbergstrom-lnx.Nvidia.com>
References: <1401973754-19701-1-git-send-email-pdeschrijver@nvidia.com>
 <1401973754-19701-4-git-send-email-pdeschrijver@nvidia.com>
 <5390B8E6.1050600@wwwdotorg.org>
 <20140605220946.GP5961@tbergstrom-lnx.Nvidia.com>
 <5390F508.8080104@wwwdotorg.org>
 <20140606073507.GS5961@tbergstrom-lnx.Nvidia.com>
Message-ID: <5395FD01.2060908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2014 01:35 AM, Peter De Schrijver wrote:
> On Fri, Jun 06, 2014 at 12:54:00AM +0200, Stephen Warren wrote:
...
>>> No. It's only used to populate /sys/devices/soc0/revision. I don't think
>>> that's particularly important.
>>
>> But it's a feature that works today. Why should we break it?
> 
> I don't expect people to not update their DT actually...

But that's not how DT works; old DTs must continue to work.

>>> sdhci needs this for faster modes I guess which will also need extra DT
>>> properties looking at the chromeos driver. The others definitely will need
>>> an updated DT. For randomness I haven't seen any appreciable difference in when
>>> the 'random: nonblocking pool is initialized' message appears between having
>>> the randomness addition or not. Most likely the bulk of the randomness comes
>>> from serial interrupts rather than the fuse data. So I don't think the move to
>>> a driver probe will cause any problem. Nor do I think the lack of an updated
>>> DT will cause problems.
>>
>> But what advantage do we have by actively changing it?
> 
> We need to move the code anyway when we will have 64bit SoCs. Using DT also
> allows us to reuse the code even when the base address changes in the future.
> If it weren't for Tegra20 A03p, we could also drop the hack to enable the
> clocks directly, but use CCF instead.

Sure we need to move the code out of arch/arm so it can be shared with
arm64. However, that doesn't imply that we need to change anything about
the way the code works or is initialized; we can still do all the
initialization in response to a function call from the arch/board
support, and not in response to driver probe.
