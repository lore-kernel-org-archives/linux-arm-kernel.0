From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Thu, 2 May 2013 14:45:43 -0400
Subject: Latest build results - errors/warnings - lots of them
In-Reply-To: <201305022003.27037.arnd@arndb.de>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <20130502153834.GR28721@atomide.com> <51829D65.7040109@ti.com>
 <201305022003.27037.arnd@arndb.de>
Message-ID: <5182B457.5030009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-05-2013 14:03, Arnd Bergmann wrote:
> On Thursday 02 May 2013, Eduardo Valentin wrote:
>> index e3c0ae9..e3f3cba 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -250,12 +250,6 @@ void thermal_unregister_governor(struct
>> thermal_governor *);
>>  #ifdef CONFIG_NET
>>  extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>>                                                 enum events event);
>> -#else
>> -static int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>> -                                               enum events event)
>> -{
>> -       return 0;
>> -}
>>  #endif
> 
> Actually it seems this bug is already fixed in linux-next:
> 
> commit f8b587055a793c7719f0d4f41b7b4aeeef43aa2d
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Wed Mar 20 21:38:07 2013 +0000
> 
>     thermal: Fix compiler warning
>     
>     The following warning is obtained when CONFIG_NET is not defined:
>     
>     In file included from drivers/thermal/mvebu_thermal.c:27:0:
>     include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_event'
>     defined but not used [-Wunused-function]
>     
>     This patch fixes the warning by properly inlining
>     thermal_generate_netlink_event().
>     
>     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f0bd7f9..fd7b8f3 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -251,7 +251,7 @@ void thermal_unregister_governor(struct thermal_governor *);
>  extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>                                                 enum events event);
>  #else
> -static int thermal_generate_netlink_event(struct thermal_zone_device *tz,
> +static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>                                                 enum events event)
>  {
>         return 0;
> 
> 
> Your patch also seems correct, but it would conflict with Ezequiel's.
> The problem was apparently that you removed the 'inline' keyword
> in 8ab3e6a08a "thermal: Use thermal zone device id in netlink messages",
> I assume by accident, since defining a non-inline function in a header
> file is obviously wrong.

Yeah, that was my bad. I am fine with Ezequiel s patch.

Thanks.

> 
> 	Arnd
> 
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130502/39ed3af9/attachment.sig>
