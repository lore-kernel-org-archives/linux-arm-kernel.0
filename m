From: xiechao.mail@gmail.com (Chao Xie)
Date: Mon, 17 Jun 2013 12:17:02 +0800
Subject: [PATCH v2] ARM: mmp: bring up pxa988 with device tree support
In-Reply-To: <2766142.mFu63TyH69@wuerfel>
References: <1369969115-4279-1-git-send-email-zhangwm@marvell.com>
 <201306101035.20924.arnd@arndb.de>
 <CADApbeh9EJDetkvx9Sq=y58mkhU_X1oo-e_hgZqeBV9nriqTiQ@mail.gmail.com>
 <2766142.mFu63TyH69@wuerfel>
Message-ID: <CADApbejV3v11jedq=q9Nz7wyVWVAJp-4vYmAifsPb7UsdVj5zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 8:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 14 June 2013 17:15:33 Chao Xie wrote:
>> On Mon, Jun 10, 2013 at 4:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> > I guess that is a problem we have on other platforms as well, we should
>> > find a generic solution for that. It would be nice to reserve a page
>> > in "fixmap" and have common code map the SCU page into that.
>> >
>>
>> So you mean that reserve a page in arch/arm/asm/include/fixmap.h?
>
> Yes.
>
>> This reserve will depend on the cpu type beacuse only A9 will have SCU part.
>
> I think A5 and ARM11MPCore as well.
>
>> I do not know that in fixmap, the #ifdef is acceptable or not.
>
> Yes, it is. We don't really use fixmap on ARM for anything other than
> kmap_atomic at the moment. Please have a look at the powerpc and x86
> implementations.
>
>> For the common code to map the SCU page, where do you suggest to put it?
>
> arch/arm/kernel/smp_scu.c.
>
I think smp_scu.c may not be good place to put the mapping for SCU page.
As you know that the fix map will make use of the mapping that set up
by vector page.
It will make use of top_pmd, and some APIs only provided under arch/arm/mm/.
For example
get_mem_type: for the pgprot for MT_DEVICE
set_top_pte:
Is that possible to add a file fixmap.c under arch/arm/mm/? It can
including all the fix mapping
except highmem. So SCU is one of it.

>         Arnd
