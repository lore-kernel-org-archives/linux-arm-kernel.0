From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 6 Feb 2018 14:08:58 +0100
Subject: [PATCH] ARM: dts: da850-evm: add clock properties to the nand node
In-Reply-To: <3f171f6a-bcea-65ec-d56d-f6ae24660f34@ti.com>
References: <20180205155222.22189-1-brgl@bgdev.pl>
 <3f171f6a-bcea-65ec-d56d-f6ae24660f34@ti.com>
Message-ID: <CAMpxmJUDbwkcJt_kx9GX+qY10xiGAp-j3+kXM-q3WP1VGwr0UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-06 12:07 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Monday 05 February 2018 09:22 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Make nand work with the common clock framework by specifying which
>> clock should be used and what name to look up.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/boot/dts/da850-evm.dts | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
>> index a86a8a1816f2..2602ad8e99ee 100644
>> --- a/arch/arm/boot/dts/da850-evm.dts
>> +++ b/arch/arm/boot/dts/da850-evm.dts
>> @@ -296,6 +296,9 @@
>>                       reg = <0 0x02000000 0x02000000
>>                              1 0x00000000 0x00008000>;
>>
>> +                     clocks = <&psc0 3>;
>> +                     clock-names = "aemif";
>
> Looks like this is being added only to satisfy the devm_clk_get() call
> in nand_davinci_probe() which I think is superfluous since we also
> enable the same clock in aemif_probe().
>
> Perhaps the better solution is to drip the clk code in
> drivers/mtd/nand/davinci_nand.c and shift legacy code to start using
> drivers/memory/aemif.c as well? This way we can also drop
> arch/arm/mach-davinci/aemif.c
>
> Thanks,
> Sekhar

Yes, this sounds good, but I think we should leave it for later as an
additional improvement, once everything else is in place. I think
these patches should be applied together with David's series in order
to not break the support on davinci boards and the aemif work would go
in later as a follow-up. How about that?

Also: I don't have any keystone board to test whether such changes
don't break the nand support there. Would you be able to test this?

Thanks,
Bartosz
