From: nm@ti.com (Nishanth Menon)
Date: Wed, 1 Jun 2016 17:49:24 -0500
Subject: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
In-Reply-To: <3593753.UuDg5ybrvm@wuerfel>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <3593753.UuDg5ybrvm@wuerfel>
Message-ID: <574F6674.3010100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 05:31 PM, Arnd Bergmann wrote:
> On Wednesday, June 1, 2016 4:31:54 PM CEST Nishanth Menon wrote:
>> Introduce ARCH_KEYSTONE_TYPICAL which is common for all Keystone
>> platforms. This is particularly useful when custom optimized defconfig
>> builds are created for Keystone architecture platforms.
>>
>> An example of the same would be a sample fragment ks_only.cfg:
>> http://pastebin.ubuntu.com/16904991/ - This prunes all arch other than
>> keystone and any options the other architectures may enable.
>>
>> git clean -fdx && git reset --hard && \
>>  ./scripts/kconfig/merge_config.sh -m \
>>  	./arch/arm/configs/multi_v7_defconfig ~/tmp/ks_only.cfg &&\
>>  make olddefconfig
>>
>> The above unfortunately will disable options necessary for KS2 boards
>> to boot to the bare minimum initramfs.
>>
>> Hence the "KEYSTONE_TYPICAL" option is designed similar to commit 8d9166b519fd
>> ("omap2/3/4: Add Kconfig option to compile in typical omap features")
>> that can be enabled for most boards keystone platforms
>> without needing to rediscover these in defconfig all over again -
>> examples include multi_v7_defconfig base and optimizations done on top
>> of them for keystone platform.
> 
> I'd rather remove the option for OMAP as well, it doesn't really fit in with
> how we do things for other platforms, and selecting a lot of other Kconfig
> symbols tends to cause circular dependencies.

Hmm, fair enough -> adding Tony as well if he sees an problem with
dropping ARCH_OMAP2PLUS_TYPICAL.

> 
>>
>> NOTE: the alternative is to select the configurations under
>> ARCH_KEYSTONE. However, that would fail multi_v7 builds on ARM
>> variants that dont work with LPAE.
> 
> Please no arbitrary selects from the platform.
> 

Agreed.

>> Cc: Bill Mills <wmills@ti.com>
>> Cc: Murali Karicheri <m-karicheri2@ti.com>
>> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
>> Cc: Tero Kristo <t-kristo@ti.com>
>> Cc: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>
>> Based on: next-20160601
>>
>> Tested for basic initramfs boot for K2HK/K2G platforms with the
>> http://pastebin.ubuntu.com/16904991/ fragment + multi_v7_defconfig
>>
>> Side note on LPAE:
>> For our current device tree and u-boot, LPAE is mandatory to bootup
>> for current Keystone boards - but this is not a SoC requirement,
>> booting without LPAE/HIGHMEM results in non-coherent DDR accesses.
> 
> This sounds like a regression, I thought we had this working when
> keystone was initially merged and we got both the coherent and
> non-coherent mode working with the same DT.
> 
>> Currently:
>> - U-Boot assumes that lpae is always enabled in kennel and updates the 
>> DT memory node with higher addresses. Because of which you are not 
>> detecting any memory without lpae and kernel crashed very early, hence 
>> no prints. So, make mem_lpae env setting as 0 in U-boot.
> 
> We could work around this in the kernel by detecting the faulty u-boot
> behavior and fixing up the addresses in an early platform callback.
> 
>> - DT also assumes that lpae is always enabled, and always asks for 
>> dma-address translation for higher addresses to lower addresses.
>> Just delete the "dma-ranges" property or create a one-on-one mapping 
>> like dma-ranges = <0x80000000 0x0 0x80000000 0x80000000>
> 
> This may be a bit trickier, I think originally keystone ignored the
> dma-ranges property and hacked up its own offset by adding a magic
> constant to the dma address using a bus notifier. We probably don't
> want to bring that hack back, but maybe we can come up with another
> solution.
> 

Santosh, Bill, Lokesh, Grygorii: could you help feedback on the above
comments from Arnd?


-- 
Regards,
Nishanth Menon
