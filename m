From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 10:25:46 -0700
Subject: [PATCH 17/31] ASoC: tegra: call pm_runtime APIs around register
 accesses
In-Reply-To: <20131116100205.GG15393@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-18-git-send-email-swarren@wwwdotorg.org>
 <20131116100205.GG15393@sirena.org.uk>
Message-ID: <528A4D9A.10809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2013 03:02 AM, Mark Brown wrote:
> On Fri, Nov 15, 2013 at 01:54:12PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Call pm_runtime_get_sync() before all register accesses; the HW requires
>> clocks to be running when accessing registers.
>>
>> This hasn't been needed to date, since all register IO was performed
>> while playback was active, and hence the ASoC core had already called
>> pm_runtime_get(). However, an imminent future commit will allocate and
>> set up the FIFOs and routing during probe(), when that "protection"
>> won't be in place.
> 
> Acked-by: Mark Brown <broonie@linaro.org>
> 
> However should we fix this at the regmap level in the same way that we
> do for clocks?  That would need to be using _put_autosuspend() to avoid
> being horrific.

I did wonder about that, but it seemed like rather a lot of overhead?

> Or alternatively should the driver be making the device
> cache only when runtime PM is disabled?

The regmap is already cache-only when runtime-suspended. However the
registers don't get flushed during resume. I suppose that would require
only adding one extra call to the PM resume function?

For some reason, my gut prefers this current solution, but I could be
persuaded.
