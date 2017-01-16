From: julien.grall@arm.com (Julien Grall)
Date: Mon, 16 Jan 2017 12:43:58 +0000
Subject: [PATCH v3 4/5] Xen: Select correct dom0 console
In-Reply-To: <20170103172859.GC14183@leverpostej>
References: <20161215122718.21422-1-andre.przywara@arm.com>
 <20161215122718.21422-5-andre.przywara@arm.com>
 <20170103172859.GC14183@leverpostej>
Message-ID: <063e6a8d-2d1e-d88e-7a38-a2f9d992813e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 03/01/17 17:29, Mark Rutland wrote:
> On Thu, Dec 15, 2016 at 12:27:17PM +0000, Andre Przywara wrote:
>> From: Ian Campbell <ian.campbell@citrix.com>
>>
>> If Xen is enabled, tell Dom0 to use the 'hvc0' console, and fall back to
>> the usual ttyAMA0 otherwise.
>>
>> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Reviewed-by: Julien Grall <julien.grall@arm.com>
>> Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> ---
>>  configure.ac | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index ea02dca..d23cced 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -105,7 +105,8 @@ AC_ARG_WITH([initrd],
>>  AC_SUBST([FILESYSTEM], [$USE_INITRD])
>>  AM_CONDITIONAL([INITRD], [test "x$USE_INITRD" != "x"])
>>
>> -C_CMDLINE="console=ttyAMA0 earlyprintk=pl011,0x1c090000"
>> +AS_IF([test "x$X_IMAGE" = "x"],[C_CONSOLE="ttyAMA0"],[C_CONSOLE="hvc0"])
>> +C_CMDLINE="console=$C_CONSOLE earlyprintk=pl011,0x1c090000"
>
> Just to check: what happesns if Dom0 tries to write to 0x1c090000?

Xen is emulating a simple UART (only write is supported) replacing the 
real UART for DOM0. So character will be printed on the console when the 
domain is writing to 0x1c090000.

>
> Shouldn't we override/delete earlyprintk/earlycon here too?

The ideal would be to use xen console for the earlyprintk/earlycon, but 
it seems that it has not been wired for ARM.

So for now, I would keep the earlyprintk options to help developer 
debugging early crash.

> I've applied this as-is, so if we do need to, I'll need a fixup patch.

Thank you for pushing the series.

Cheers,

-- 
Julien Grall
