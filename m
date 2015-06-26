From: andrew@ncrmnt.org (Andrew)
Date: Fri, 26 Jun 2015 13:11:26 +0300
Subject: [PATCH 1/4] ARM: rcm-k1879xb1: Add support for K1879XB1 SoC
In-Reply-To: <CAL_JsqKTUM8-ufR8gGJBsNtbc94LyS7o-7v=R2Fit3+0=-SofA@mail.gmail.com>
References: <1435074604-19312-1-git-send-email-andrew@ncrmnt.org>
 <1435074604-19312-2-git-send-email-andrew@ncrmnt.org>
 <CAL_JsqKTUM8-ufR8gGJBsNtbc94LyS7o-7v=R2Fit3+0=-SofA@mail.gmail.com>
Message-ID: <fb7ebabe2ce9cac0fac05535bbabfdbc@mail.ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring ????? 24.06.2015 05:15:
>> +
>> +static void __iomem *k1879_sctl_base(void)
>> +{
>> +       return (void __iomem *)RCM_K1879_SCTL_VIRT_BASE;
>> +}
>> +
>> +static void k1879_level_irq_i2c0_fixup(unsigned int irq, struct 
>> irq_desc *desc)
>> +{
>> +       writel(1, k1879_mif_base() + RCM_K1879_MIF_I2C_INT_STAT);
>> +       handle_level_irq(irq, desc);
>> +}
>> +
>> +static void k1879_level_irq_i2c1_fixup(unsigned int irq, struct 
>> irq_desc *desc)
>> +{
>> +       writel(1 << 0, k1879_sctl_base() + RCM_K1879_SCTL_INT_P_OUT);
>> +       handle_level_irq(irq, desc);
>> +}
>> +
>> +static void k1879_level_irq_i2c2_fixup(unsigned int irq, struct 
>> irq_desc *desc)
>> +{
>> +       writel(1 << 1, k1879_sctl_base() + RCM_K1879_SCTL_INT_P_OUT);
>> +       handle_level_irq(irq, desc);
>> +}
>> +
>> +static void k1879_level_irq_i2c3_fixup(unsigned int irq, struct 
>> irq_desc *desc)
>> +{
>> +       writel(1 << 2, k1879_sctl_base() + RCM_K1879_SCTL_INT_P_OUT);
>> +       handle_level_irq(irq, desc);
>> +}
> 
> What are all these for? They probably belong somewhere else.

As I've written already in response to to Russel King's review, these 
are the workarounds
around aeroflex i2c IP interrupt handling. Basically every interrupt 
from i2c requires
cleaning up respective 'pending' bit in SCTL register. This could be 
done in i2c driver,
but it is very platform-specific and would look ugly in the driver. If 
you know any cleaner
way for such a workaround, please advice. Right now I've cleaned up 
everything, save for
these fixups.


>> diff --git a/arch/arm/mach-rcm-k1879xb1/cpuidle.c 
>> b/arch/arm/mach-rcm-k1879xb1/cpuidle.c
>> new file mode 100644
>> index 0000000..7c621b6
>> --- /dev/null
>> +++ b/arch/arm/mach-rcm-k1879xb1/cpuidle.c
> 
> This should be a separate patch and located in drivers/cpuidle/

Got it, thanks.


-- 
Regards,
Andrew
RC Module :: http://module.ru
