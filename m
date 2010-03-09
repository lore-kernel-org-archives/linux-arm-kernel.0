From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Tue, 09 Mar 2010 12:19:04 +0000
Subject: pxa: Couple of build issues (missing dependencies)
In-Reply-To: <f17812d71003081912k57459703x37e3babca5dc3977@mail.gmail.com>
References: <4B953A83.7020705@cam.ac.uk>
	<f17812d71003081905p2967eb6fgd301f3198b421955@mail.gmail.com>
	<f17812d71003081912k57459703x37e3babca5dc3977@mail.gmail.com>
Message-ID: <4B963CB8.1070206@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/10 03:12, Eric Miao wrote:
> Correct Ian Molton's email address.
> 
> On Tue, Mar 9, 2010 at 11:05 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> On Tue, Mar 9, 2010 at 1:57 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>>> Whilst testing the uncompress patch just sent, I tried a full build
>>> of pxa platforms by just enabling them along side my normal couple.
>>> This is more or less a vanilla tree as of earlier today (+ a couple
>>> of uncompress related patches from Eric's tree).  I haven't chased
>>> these down terribly carefully  but thought I might as well bring them
>>> to the lists attention.
>>>
>>> Sharpsl_pm calls max1111_read_channel if CONFIG_CORGI_SSP_DEPRECATED
>>> is not set.  There is no dependancy to enforce this being available.
>>> (none obvious in the pxa devel tree either).
>>>
>>
>> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
>> index 38fbd0a..912bdfd 100644
>> --- a/arch/arm/mach-pxa/Kconfig
>> +++ b/arch/arm/mach-pxa/Kconfig
>> @@ -454,6 +454,13 @@ config PXA_SHARPSL
>>  config SHARPSL_PM
>>        bool
>>        select APM_EMULATION
>> +       select SHARPSL_PM_MAX1111
>> +
>> +config SHARPSL_PM_MAX1111
>> +       bool
>> +       depends on !CORGI_SSP_DEPRECATED
>> +       select HWMON
>> +       select SENSORS_MAX1111
>>
>>  config CORGI_SSP_DEPRECATED
>>        bool
>>
>>
>> An ugly patch above should address this problem, but a real fix would
>> be to have a sharpsl-battery.c driver.
>>
>>>
>>> FB_W100 is selected by MACH_E740 leading to the following which
>>> I would guess indicate some missing dependencies as well.
>>> Looks like it doesn't actually drag in frame buffer support as I'd
>>> imagine was intended:
>>
>> MACH_E740 should not have selected that option, as user has the
>> flexibility to include support of FB_W100 or not. Apparently, the build
>> error is caused by FB_W100 being selected, while FB is made to
>> module.
>>
>> I'm yet not sure why MACH_E740 mandates FB_W100, and as Ian is
>> no longer active on this series, I'm going to drop this 'select'.
>>
>> As well as for MACH_HIMALAYA. Zbynek CC'ed.
>>
>> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
>> index 912bdfd..5b6ee46 100644
>> --- a/arch/arm/mach-pxa/Kconfig
>> +++ b/arch/arm/mach-pxa/Kconfig
>> @@ -272,7 +272,6 @@ config MACH_H5000
>>  config MACH_HIMALAYA
>>        bool "HTC Himalaya Support"
>>        select CPU_PXA26x
>> -       select FB_W100
>>
>>  config MACH_MAGICIAN
>>        bool "Enable HTC Magician Support"
>> @@ -554,7 +553,6 @@ config MACH_E740
>>        bool "Toshiba e740"
>>        default y
>>        depends on ARCH_PXA_ESERIES
>> -       select FB_W100
>>        help
>>          Say Y here if you intend to run this kernel on a Toshiba
>>          e740 family PDA.
>> @@ -563,7 +561,6 @@ config MACH_E750
>>        bool "Toshiba e750"
>>        default y
>>        depends on ARCH_PXA_ESERIES
>> -       select FB_W100
>>        help
>>          Say Y here if you intend to run this kernel on a Toshiba
>>          e750 family PDA.
>> @@ -580,7 +577,6 @@ config MACH_E800
>>        bool "Toshiba e800"
>>        default y
>>        depends on ARCH_PXA_ESERIES
>> -       select FB_W100
>>        help
>>          Say Y here if you intend to run this kernel on a Toshiba
>>          e800 family PDA.
>>

Both look fine to me.

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Thanks for sorting out the patches.

Jonathan
