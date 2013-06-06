From: acourbot@nvidia.com (Alex Courbot)
Date: Thu, 6 Jun 2013 19:37:49 +0900
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <1740292.8Sz57ytBcM@flatron>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
 <1740292.8Sz57ytBcM@flatron>
Message-ID: <51B0667D.30801@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 06/06/2013 07:17 PM, Tomasz Figa wrote:
>> +Global properties
>> +-------------------------------------------
>> +
>> +The following properties can be specified into the "chosen" root
>> +node:
>> +
>> +  nvidia,secure-os: enable SecureOS.
>
> Hmm, on Exynos we had something like
>
>          firmware at 0203F000 {
>                  compatible = "samsung,secure-firmware";
>                  reg = <0x0203F000 0x1000>;
>          };
>
> but your solution might be actually the proper one, since firmware is not
> a hardware block. (The address in reg property is pointing to SYSRAM
> memory, which is an additional communication channel with the firmware.)

Yes, I saw your implementation but decided to do it through the chosen 
node anyway, since that's what it seems to be designed and we don't need 
any reg parameter.

> I think this patch could be split into several patches:
>   - add support for firmware
>   - split reset function
>   - add reset support using firmware.

Mmm possibly yes, but I wonder if that would not be too much splitting. 
Stephen?

> Hmm, I wonder if you need all this complexity here. Have a look at our
> exynos_smc function
>
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm/mach-exynos/exynos-smc.S?id=refs/tags/next-20130606

Yes, I just embarrassed myself showing my ignorance of ARM assembler. ;) 
The fix Russel proposed is pretty close to your version.

>> +static const struct firmware_ops tegra_firmware_ops = {
>> +     .set_cpu_boot_addr = tegra_set_cpu_boot_addr,
>> +};
>
> It's good that this interface is finally getting some user besides Exynos.

I didn't know about it first but Joseph kindly pointed it out to me and 
it indeed makes it easier to implement this.

Thanks,
Alex.
