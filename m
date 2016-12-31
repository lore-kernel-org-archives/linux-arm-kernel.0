From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 31 Dec 2016 16:13:44 +0530
Subject: [PATCH] drivers: remoteproc: constify rproc_ops structures
In-Reply-To: <20161230120655.GB9118@builder>
References: <1481974176-19912-1-git-send-email-bhumirks@gmail.com>
 <20161230120655.GB9118@builder>
Message-ID: <CAOH+1jH=Y+1Nxe2L4d6OaC95dc-ORsuqsOYSNP5_8NYJVz-A4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 5:36 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Sat 17 Dec 03:29 PST 2016, Bhumika Goyal wrote:
>
>> Declare rproc_ops structures as const as they are only passed as an
>> argument to the function rproc_alloc. This argument is of type const, so
>> rproc_ops structures having this property can be declared const too.
>> Done using Coccinelle:
>>
>> @r1 disable optional_qualifier @
>> identifier i;
>> position p;
>> @@
>> static struct rproc_ops i at p = {...};
>>
>> @ok1@
>> identifier r1.i;
>> position p;
>> @@
>> rproc_alloc(...,&i at p,...)
>>
>> @bad@
>> position p!={r1.p,ok1.p};
>> identifier r1.i;
>> @@
>> i at p
>>
>> @depends on !bad disable optional_qualifier@
>> identifier r1.i;
>> @@
>> +const
>> struct rproc_ops i;
>>
>> File sizes before:
>>    text          data     bss     dec     hex filename
>>    1258           416       0    1674     68a remoteproc/omap_remoteproc.o
>>    2402           240       0    2642     a52 remoteproc/st_remoteproc.o
>>    2064           272       0    2336     920 remoteproc/st_slim_rproc.o
>>    2160           240       0    2400     960 remoteproc/wkup_m3_rproc.o
>>
>> File sizes after:
>>    text          data     bss     dec     hex filename
>>    1297           368       0    1665     681 remoteproc/omap_remoteproc.o
>>    2434           192       0    2626     a42 remoteproc/st_remoteproc.o
>>    2112           240       0    2352     930 remoteproc/st_slim_rproc.o
>>    2200           192       0    2392     958 remoteproc/wkup_m3_rproc.o
>>
>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>
> Thanks Bhumika, this looks good.
>
> But as Suman already asked. Is there any reason why da8xx_remoteproc.c
> did not get updated? It looks like the same change would apply there.
>
>

The reason I did not sent a patch for that driver is because the .o
file is not obtained. This is output I get when I try to compile the
da8xx_remoteproc.o file.

drivers/remoteproc/da8xx_remoteproc.c:22:72: fatal error:
mach/clock.h: No such file or directory
 #include <mach/clock.h>   /* for davinci_clk_reset_assert/deassert() */
                                                                        ^
compilation terminated.
make[1]: *** [drivers/remoteproc/da8xx_remoteproc.o] Error 1
make: *** [drivers/remoteproc/da8xx_remoteproc.o] Error 2

I also tried running the commands  make.cross ARCH=arm allyesconfig;
make.cross ARCH=arm drivers/remoteproc/da8xx_remoteproc.o but still
the error remains the same.

Could you please suggest me what to do in this case?

Thanks,
Bhumika

> Unless I'm missing something, please update the patch and I'll be happy
> to apply it.
>
> Regards,
> Bjorn
