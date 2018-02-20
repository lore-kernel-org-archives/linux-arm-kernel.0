From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 20 Feb 2018 11:17:28 +0800
Subject: [PATCH] ARM: sunxi: Fix multi-cluster SMP support compilation in
 multi v6/v7 configs
In-Reply-To: <20180219080511.wfzeokrwbyyr5l3r@flea.lan>
References: <20180217050112.14619-1-wens@csie.org>
 <20180219080511.wfzeokrwbyyr5l3r@flea.lan>
Message-ID: <CAGb2v642RKd7UAsqTkCRfeL6hEPWMEWTL1H_hes0CFFPfGtVRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 4:05 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Sat, Feb 17, 2018 at 01:01:12PM +0800, Chen-Yu Tsai wrote:
>> Various parts of the assembly code used in the multi-cluster SMP support
>> requires ARMv7-A. If the kernel config also has multi v6 support enabled,
>> Kbuild defaults to building for armv6k, which does not support some of
>> the instructions we use.
>>
>> Configure the Makefile such that the multi-cluster SMP code is always
>> built for ARMv7-A. This is also what mach-exynos does for their MC-SMP
>> code.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>
>> This addresses "[sunxi:sunxi/core-for-4.17 1/4] /tmp/ccSQM2rD.s:438:
>> Error: selected processor does not support `isb' in ARM mode"
>> reported by the kbuild test robot for arm-allmodconfig.
>>
>> Should we apply it, or squash it in the original patch?
>
> I guess we can squash it. And while you're at it..
>
>> ---
>>  arch/arm/mach-sunxi/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
>> index 3e741e959c7c..3c2c4384357a 100644
>> --- a/arch/arm/mach-sunxi/Makefile
>> +++ b/arch/arm/mach-sunxi/Makefile
>> @@ -1,3 +1,4 @@
>>  obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
>>  obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o
>> +CFLAGS_mc_smp.o      += -march=armv7-a
>
> Can you move it to the first line of the file (before the other obj-*)
> with a newline after it?

Done and done.

ChenYu
