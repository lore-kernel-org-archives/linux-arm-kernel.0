From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 02 Sep 2016 17:58:38 +0900
Subject: [PATCH v2 3/3] ARM: dts: Set the clock rate for DREX block 800Mhz
 on exynos5422-odroidxu3
In-Reply-To: <20160827163310.GA8616@kozik-book>
References: <1472108238-24309-1-git-send-email-cw00.choi@samsung.com>
 <1472108238-24309-4-git-send-email-cw00.choi@samsung.com>
 <CGME20160827163323epcas1p36e8aa80709136d2784f38f4531a5dab8@epcas1p3.samsung.com>
 <20160827163310.GA8616@kozik-book>
Message-ID: <57C93F3E.4030802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 08? 28? 01:33, Krzysztof Kozlowski wrote:
> On Thu, Aug 25, 2016 at 03:57:18PM +0900, Chanwoo Choi wrote:
>> This patch sets the clock rate for DREX (DRAM Express) block
>> on exynos5422-odroidxu3 board. In the exynos5422 TRM,
>> DRAM clocks use BPLL clock and CMU_CDREX generates
>> the 800MHz DRAM clock.
>>
> 
>>From the commit message I don't get two things:
> 1. Why setting this on XU3-family of boards, not all 542x/5800?

I have the only xu3 board. I cannot test it on other boards.

> 2. Why this is needed? The commit msg lacks the answer to the "why".

In the exynos5422's TRM, CMU_CDREX generates the 800MHz DRAM clock
as above commit message. But, I'm missing what there is different
before applying this patch. I add comment why we should set the 
clock rate for DRAM on below.

> 
>> [clk_summary on exynos5422-odroidxu3 board]
>> fout_bpll                             0            0   800000000          0 0
>>     mout_bpll                          0            0   800000000          0 0
>>        mout_mclk_cdrex                 0            0   800000000          0 0
>>           dout_pclk_core_mem           0            0   200000000          0 0
>>           dout_sclk_cdrex              0            0   800000000          0 0
>>
> 
> What is the purpose of this dump of clk_summary? Is it a state before or
> after the change? After it is quite obvious that it should have
> 800MHz...

I'm missing the difference before applying this patch.

As I mentioned on v1[1] patch, if I don't set the clock rate for CDREX,
the default clock is 825MHz instead of 800MHz. So, I set the clock rate
on this patch.
[1] https://lkml.org/lkml/2016/8/22/255

If I don't apply this patch, the DREX clock is 825MHz.
fout_bpll                             0            0   825000000          0 0  
       mout_bpll                          0            0   825000000          0 0  
          mout_mclk_cdrex                 0            0   825000000          0 0  
             dout_pclk_core_mem           0            0   206250000          0 0  
             dout_sclk_cdrex              0            0   825000000          0 0  
                dout_clk2x_phy0           0            0   825000000          0 0  
                   dout_aclk_cdrex1           0            0   412500000          0 0  
                      dout_pclk_cdrex           0            0   103125000          0 0  
                   dout_cclk_drex0           0            0   412500000          0 0  


If you want to edit the commit message, I'll resend the v3 patch.

Best Regards,
Chanwoo Choi

> 
> Best regards,
> Krzysztof
> 
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> index d56253049ccb..fd3f67c72039 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> @@ -229,6 +229,11 @@
>>  	status = "okay";
>>  };
>>  
>> +&clock {
>> +	assigned-clocks = <&clock CLK_DOUT_SCLK_CDREX>;
>> +	assigned-clock-rates = <800000000>;
>> +};
>> +
>>  &clock_audss {
>>  	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
>>  			<&clock_audss EXYNOS_MOUT_I2S>,
>> -- 
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
