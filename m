From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Jun 2011 09:01:18 +0100
Subject: ARM: 6910/1: MTD: physmap: let set_vpp() pass a platform_device
	instead of a map_info
In-Reply-To: <BANLkTim1=DBd1AvPw1VuPfGi_Z5ktAhyPg@mail.gmail.com>
References: <201105240059.p4O0xPfN009516@hera.kernel.org>
	<BANLkTim1=DBd1AvPw1VuPfGi_Z5ktAhyPg@mail.gmail.com>
Message-ID: <4DF07DCE.60707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/11 19:53, Geert Uytterhoeven wrote:

Hi Geert,

> On Tue, May 24, 2011 at 02:59, Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
>>    ARM: 6910/1: MTD: physmap: let set_vpp() pass a platform_device instead of a map_info
>>
>>    The set_vpp() method provided by physmap passes a map_info back to
>>    the platform code, which has little relevance as far as the platform
>>    is concerned (this parameter is completely unused).
>>
>>    Instead, pass the platform_device, which can be used in the pismo
>>    driver to retrieve some important information in a nicer way, instead
>>    of the hack that was in place.
>>
>>    The empty set_vpp function in board-at572d940hf_ek.c is left untouched,
>>    as the board/SoC is scheduled for removal.
>>
>>    Cc: Andrew Victor <linux@maxim.org.za>
>>    Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>    Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>    Cc: Philipp Zabel <philipp.zabel@gmail.com>
>>    Cc: Eric Miao <eric.y.miao@gmail.com>
>>    Cc: Ben Dooks <ben-linux@fluff.org>
>>    Acked-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>>    Acked-by: David Woodhouse <dwmw2@infradead.org>
>>    Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
>> --- a/include/linux/mtd/physmap.h
>> +++ b/include/linux/mtd/physmap.h
>> @@ -24,7 +24,7 @@ struct physmap_flash_data {
>>        unsigned int            width;
>>        int                     (*init)(struct platform_device *);
>>        void                    (*exit)(struct platform_device *);
>> -       void                    (*set_vpp)(struct map_info *, int);
>> +       void                    (*set_vpp)(struct platform_device *, int);
>>        unsigned int            nr_parts;
>>        unsigned int            pfow_base;
>>        char                    *probe_type;
> 
> You forgot to update the set_vpp parameter of physmap_configure():
> 
> void physmap_configure(unsigned long addr, unsigned long size,
>                 int bankwidth, void (*set_vpp)(struct map_info *, int) );
> 
> causing
> 
> drivers/mtd/maps/physmap.c: In function ?physmap_configure?:
> drivers/mtd/maps/physmap.c:255: warning: assignment from incompatible
> pointer type
> 
> Interestingly, there are no (in-tree) users of physmap_configure()?

It's already been removed in -next:

commit 3b1b2b07088ed190090f0b1973416b6c8e49a2a1
Author: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Thu Jun 2 18:51:14 2011 +0400

    mtd: drop physmap_configure

    physmap_configure() and physmap_set_partitions() have no users in
kernel.
    Out of kernel users should have been converted to regular platform
device
    long ago. Drop support for this obsolete API.

    Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
    Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

Maybe this should be merged to -rc3.

Thanks for the heads up.

	M.
-- 
Jazz is not dead. It just smells funny...
