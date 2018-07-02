From: pgwipeout@gmail.com (Peter Geis)
Date: Mon, 2 Jul 2018 14:53:08 -0400
Subject: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
In-Reply-To: <11534185.70fb5jbPr6@dimapc>
References: <20180619110027.16935-1-digetx@gmail.com>
 <d99935be-797d-4676-c186-a045a590f01b@gmail.com> <11534185.70fb5jbPr6@dimapc>
Message-ID: <5c47ef70-b90e-6e81-39dd-fbcfad2b93e5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/02/2018 10:48 AM, Dmitry Osipenko wrote:
> On Friday, 29 June 2018 22:37:02 MSK Peter Geis wrote:
>> Good Afternoon,
>>
>> I have tested these patches on the Ouya T3 device.
>> They work great to enable the L2 cache controller, however they do not
>> respect explicitly disabling the L2 cache controller via the kernel
>> config nor device tree.
>>
>> With CONFIG_CACHE_L2X0 disabled, but CONFIG_TRUSTED_FOUNDATIONS enabled,
>> the L2 cache controller is silently enabled and allows all four cores to
>> boot.
>>
> 
> I don't see how cache could be enabled with CONFIG_CACHE_L2X0 disabled, there
> is no code to do that. Could you elaborate please?
> 
> Secondary cores do not depend on the cache state, disabled cache shouldn't
> prevent them to boot.

On the untouched mainline kernel running on a Trusted Foundations T3 
device, I observed the following indications:
With the L2 cache controller enabled, all four processor cores were 
enabled, but it would immediately panic for writing to a secure register 
from insecure mode.
With the L2 cache controller disabled, only the boot core is detected, 
but it successfully boots.
This is the issue that I inquired originally to you about.

With your patch running on the same device, the following is observed:
With the L2 controller enabled, all four cores are active, and the cache 
controller appears to function.
With the L2 controller disabled, but trusted foundations enabled, the L2 
controller enabled kernel message is missing, however all four cores 
still enable.

After looking through the code a little more deeply, I see you modified 
the reset handler for handling offline cores.
I am wondering if you fixed an additional issue inadvertently.

The reason I discovered this is I am working with kexec as a bootloader.
On a device without trusted foundations, kexec works without issue.
On a device with trusted foundations and your patch, I found that 
disabling the l2 cache controller and trusted foundations allow kexec to 
occur.
I haven't tried an either/or scenario, though now you have me thinking I 
should.
> 
>> One must also disable CONFIG_TRUSTED_FOUNDATIONS to stop the L2 cache
>> controller from spinning up.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>
> 
> 
> 
> 
