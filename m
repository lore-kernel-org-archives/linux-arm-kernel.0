From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 21 May 2013 11:15:35 +0800
Subject: [PATCH] arm64: kernel: need extern variable 'screen_info' for
 related driver using.
In-Reply-To: <20130520091008.GB31359@mudshark.cambridge.arm.com>
References: <5199B7D6.40907@asianux.com>
 <20130520091008.GB31359@mudshark.cambridge.arm.com>
Message-ID: <519AE6D7.1090401@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2013 05:10 PM, Will Deacon wrote:
> Hi Chen,
> 
> On Mon, May 20, 2013 at 06:42:46AM +0100, Chen Gang wrote:
>>
>> Add the extern variable 'screen_info' according to arm32 has done.
>>
>> The related error:
>>   drivers/video/console/vgacon.c:1305: undefined reference to `screen_info'
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm64/kernel/setup.c |   11 +++++++++++
>>  1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index add6ea6..1055992 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -374,3 +374,14 @@ const struct seq_operations cpuinfo_op = {
>>  	.stop	= c_stop,
>>  	.show	= c_show
>>  };
>> +
>> +#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
>> +struct screen_info screen_info = {
>> +	.orig_video_lines	= 30,
>> +	.orig_video_cols	= 80,
>> +	.orig_video_mode	= 0,
>> +	.orig_video_ega_bx	= 0,
>> +	.orig_video_isVGA	= 1,
>> +	.orig_video_points	= 8
>> +};
>> +#endif
> 
> I think it would be better if we added a something like
> CONFIG_HAVE_VGA_CONSOLE, which VGA_CONSOLE can then depend on. Architectures
> like x86 can then select the former, and we can remove the long list of
> architectures from the current option.
> 

I guess your meaning is:

  under arm64, actually, need not support 'VGA_CONSOLE', and 'screen_info' is useless.
  So better to define 'CONFIG_HAVE_VGA_CONSOLE' which 'VGA_CONSOLE' can depend on it, and in arm64, we do not define CONFIG_HAVE_VGA_CONSOLE.

Is it correct ?

If so, I recommend to add depend item for VGA_CONSOLE directly:

-------------------diff begin----------------------------------

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index bc922c4..b759157 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -6,7 +6,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
-	depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER)
+	depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !ARM64 && (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER)
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a

-------------------diff end------------------------------------


Thanks.
-- 
Chen Gang

Asianux Corporation
