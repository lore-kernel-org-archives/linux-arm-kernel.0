From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 May 2014 11:04:45 -0600
Subject: [PATCH] ARM: tegra: add SD wp-gpios to Venice2 DT
In-Reply-To: <20140429133449.GA23699@ulmo>
References: <1398711219-23029-1-git-send-email-swarren@wwwdotorg.org>
 <20140429133449.GA23699@ulmo>
Message-ID: <5369162D.9010600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 07:34 AM, Thierry Reding wrote:
> On Mon, Apr 28, 2014 at 12:53:39PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Venice2 can detect write-protect on the SD card. Add the required
>> DT entries to allow this.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Thierry, could you test this for me; my Venice2 has been sent away for
>> a few days for some rework. You should find that if you write-protect
>> your SD card, the kernel fails/panics trying to mount it as a r/w root
>> fs, whereas if the card is not write-protected, everything still works
>> fine. Thanks.
>> ---
>>  arch/arm/boot/dts/tegra124-venice2.dts | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
>> index 84a6ec039e1d..00e741ba6927 100644
>> --- a/arch/arm/boot/dts/tegra124-venice2.dts
>> +++ b/arch/arm/boot/dts/tegra124-venice2.dts
>> @@ -943,6 +943,7 @@
>>  	sdhci at 0,700b0400 {
>>  		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
>>  		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
>> +		wp-gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
> 
> I need to make this GPIO_ACTIVE_LOW for this to work properly on my
> Venice2.

Ah yes, I need that too. The other kernel I was using as a reference
evidently doesn't use the GPIO flags for inversion, but rather a
separate wp-inverted property, which I hadn't noticed.

With the polarity fixed, I have applied this to Tegra's for-3.16/dt branch.
