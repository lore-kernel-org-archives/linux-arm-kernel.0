From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 9 Oct 2010 12:32:05 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101009030455.GB5913@kroah.com>
References: <20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<20101009000046.GA30616@kroah.com>
	<20101009002546.GB14675@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010082210150.3107@xanadu.home>
	<20101009030455.GB5913@kroah.com>
Message-ID: <AANLkTimwNivgL1cxrQnmoOQj_FmSVznHMuFwHO365wRU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 9, 2010 at 6:04 AM, Greg KH <greg@kroah.com> wrote:
> On Fri, Oct 08, 2010 at 10:41:42PM -0400, Nicolas Pitre wrote:
>> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
>> index 99627d3..4f071e4 100644
>> --- a/arch/arm/mm/ioremap.c
>> +++ b/arch/arm/mm/ioremap.c
>> @@ -201,6 +201,15 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
>> ? ? ? if (pfn >= 0x100000 && (__pfn_to_phys(pfn) & ~SUPERSECTION_MASK))
>> ? ? ? ? ? ? ? return NULL;
>>
>> + ? ? /*
>> + ? ? ?* Warn if RAM is mapped to discourage this usage. Let's forbid it
>> + ? ? ?* outright on ARMv6+ where this became architecturally undefined
>> + ? ? ?* in theory and causes memory corruption in practice.
>> + ? ? ?*/
>> + ? ? if (WARN_ON(pfn_valid(pfn)))
>> + ? ? ? ? ? ? if (__LINUX_ARM_ARCH__ >= 6)
>> + ? ? ? ? ? ? ? ? ? ? return NULL;
>> +
>> ? ? ? type = get_mem_type(mtype);
>> ? ? ? if (!type)
>> ? ? ? ? ? ? ? return NULL;
>>
>
> That looks good to me, anyone else object to this?

I object; this is still breaking drivers.

The decision was to don't allow ioremap() on RAM for all ARM, I agree
with that decision, there's no point in an API to works differently on
different ARM chips. Moreover, this would be more in line with x86's
ioremap().

All that is needed IMO is a grace period... Before this is activated
for real, the warning should happen on all drivers.

-- 
Felipe Contreras
