From: alchark@gmail.com (Alexey Charkov)
Date: Sun, 7 Nov 2010 20:16:21 +0300
Subject: [PATCH 1/6 v2] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20101107170005.GC1759@n2100.arm.linux.org.uk>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101107170005.GC1759@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim30K0PQsoQDyPyzoVgxBQnO3KFe8hHnNJOhBSN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/7 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> A couple of other points - sorry, should've been in the last mail.
>
> On Sun, Nov 07, 2010 at 07:28:52PM +0300, Alexey Charkov wrote:
>> diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
>> new file mode 100644
>> index 0000000..e0c6268
>> --- /dev/null
>> +++ b/arch/arm/mach-vt8500/Kconfig
>> @@ -0,0 +1,65 @@
>> +if ARCH_VT8500
>> +
>> +config VTWM_VERSION_VT8500
>> + ? ? bool
>> + ? ? default n
>
> n is the default anyway, so specifying this is redundant.
>

Great, I'll drop it then.

>> +void __init bv07_init(void)
>> +{
>> +#ifdef CONFIG_FB_VT8500
>> + ? ? void __iomem *gpio_mux_reg = ioremap(wmt_current_regs->gpio
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+ 0x200, 4);
>
> ioremap() is generally regarded as a function which can fail, and therefore
> needs its return value checked. ?There seems to be multiple instances of
> this through this patch.
>

Is it OK to simply skip the code that uses the relevant pointer if
ioremap fails (possibly issuing an error via printk)? The problem is
that these are void functions, so I can't just return -ENODEV on
failure.
