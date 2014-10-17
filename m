From: yifan.zhangm@gmail.com (Yifan Zhang)
Date: Fri, 17 Oct 2014 19:23:42 +0800
Subject: [PATCH] arm64: mm: use macro instead of if judgement of ZONE_DMA
In-Reply-To: <20141017105156.GF29470@pengutronix.de>
References: <CAGZxSSRsYYNURnVB1fpGSTMA7WJMdy=Cmt1pj0Q=69ahHEsO1w@mail.gmail.com>
 <20141017105156.GF29470@pengutronix.de>
Message-ID: <CAGZxSSTsb6xVM-VZee86xX_4XPXkBQ834_2_LN_+NN1xWQCWDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Yes, the first patch is broken. So I sent a v2 which is in correct format.

I understand IS_ENABLED is better, but in this case, we can't use "if"
since "ZONE_DMA" is defined under "#ifdef CONFIG_ZONE_DMA". In current
code, once we disable CONFIG_ZONE_DMA, "zone_size[ZONE_DMA]" will
report compiling error as below:


# configuration written to .config
#
making android
scripts/kconfig/conf --silentoldconfig Kconfig
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC      scripts/mod/devicetable-offsets.s
  GEN     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/mod/modpost
  CHK     include/generated/compile.h
  CC      arch/arm64/mm/init.o
make[1]: Nothing to be done for `dtbs'.
  CGIT    kernel/gitinfo.S
arch/arm64/mm/init.c: In function 'zone_sizes_init':
arch/arm64/mm/init.c:85:13: error: 'ZONE_DMA' undeclared (first use in
this function)
   zone_size[ZONE_DMA] = max_dma - min;
             ^
arch/arm64/mm/init.c:85:13: note: each undeclared identifier is
reported only once for each function it appears in
make[1]: *** [arch/arm64/mm/init.o] Error 1
make: *** [arch/arm64/mm] Error 2
make: *** Waiting for unfinished jobs....
  AS      kernel/gitinfo.o
  LD      kernel/built-in.o


BR,
Yifan

On Fri, Oct 17, 2014 at 6:51 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Thu, Oct 16, 2014 at 05:19:43PM +0800, Yifan Zhang wrote:
>> @@ -82,10 +82,10 @@ static void __init zone_sizes_init(unsigned long
>> min, unsigned long max)
>>
>>         memset(zone_size, 0, sizeof(zone_size));
>>
>>
>>
>>         /* 4GB maximum for 32-bit only capable devices */
>>
>> -        if (IS_ENABLED(CONFIG_ZONE_DMA)) {
>>
>> -                 max_dma = PFN_DOWN(max_zone_dma_phys());
>>
>> -                 zone_size[ZONE_DMA] = max_dma - min;
>>
>> -        }
>>
>> +#ifdef CONFIG_ZONE_DMA
>>
>> +       max_dma = PFN_DOWN(max_zone_dma_phys());
>>
>> +       zone_size[ZONE_DMA] = max_dma - min;
>>
>> +#endif
> Apart from your patch being broken (probably by your MUA or MTA) usually
> if (IS_ENABLED(...)) is preferred over #ifdef because it doesn't stand
> out over the other program source.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
