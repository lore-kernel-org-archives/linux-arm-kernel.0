From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 11 Jun 2014 09:58:28 -0600
Subject: [PATCH v7 3/5] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <20140611152551.GH5961@tbergstrom-lnx.Nvidia.com>
References: <1401973754-19701-1-git-send-email-pdeschrijver@nvidia.com>
 <1401973754-19701-4-git-send-email-pdeschrijver@nvidia.com>
 <53984FE3.6010509@nvidia.com>
 <20140611152551.GH5961@tbergstrom-lnx.Nvidia.com>
Message-ID: <53987CA4.4040506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2014 09:25 AM, Peter De Schrijver wrote:
> On Wed, Jun 11, 2014 at 02:47:31PM +0200, Mikko Perttunen wrote:
>> On 05/06/14 16:09, Peter De Schrijver wrote:
>> ...
>>> +int tegra_fuse_readl(u32 offset, u32 *val)
>>> +{
>>> +       if (!fuse_readl)
>>> +               return -ENXIO;
>>> +
>>> +       *val = fuse_readl(offset);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>
>> -EPROBE_DEFER would be a better error value, so that drivers can work 
> 
> Ok.
> 
>> even if they are initially probed before the fuse driver. Of course, if 
>> the fuse initialization is moved into machine init then this is a non-issue.
> 
> The exported function will always be initialized later because on Tegra20 it
> requires APB DMA to be available. If you read the fuses directly, the system
> sometimes hangs.

That's not true in the current code. IIRC, the bug was that *if* an APB
DMA access to anything and a CPU access to the fuses happen at the same
time, then there can be a hang. As such, the current fuse code accesses
the fuses directly (without potential for a hang) if the APB DMA driver
is not available, but once the driver becomes available, it reads the
fuses through DMA instead. Does the new code not do that?
