From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 03 Aug 2018 18:51:03 +1000
Subject: [PATCH v5 09/11] hugetlb: Introduce generic version of
 huge_ptep_set_wrprotect
In-Reply-To: <90bf556f-144d-24b8-d2f6-70fee4a30559@ghiti.fr>
References: <20180731060155.16915-1-alex@ghiti.fr>
 <20180731060155.16915-10-alex@ghiti.fr>
 <87h8kfhg7o.fsf@concordia.ellerman.id.au>
 <6acb1389-6998-bafb-cf69-174fd522c04c@ghiti.fr>
 <90bf556f-144d-24b8-d2f6-70fee4a30559@ghiti.fr>
Message-ID: <87muu3hlzc.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

Sorry missed your previous mail.

Alex Ghiti <alex@ghiti.fr> writes:
> Ok, I tried every defconfig available:
>
> - for the nohash/32, I found that I could use mpc885_ads_defconfig and I 
> activated HUGETLBFS.
> I removed the definition of huge_ptep_set_wrprotect from 
> nohash/32/pgtable.h, add an #error in
> include/asm-generic/hugetlb.h right before the generic definition of 
> huge_ptep_set_wrprotect,
> and fell onto it at compile-time:
> => I'm pretty confident then that removing the definition of 
> huge_ptep_set_wrprotect does not
> break anythingin this case.

Thanks, that sounds good.

> - regardind book3s/32, I did not find any defconfig with 
> CONFIG_PPC_BOOK3S_32, CONFIG_PPC32
> allowing to enable huge page support (ie CONFIG_SYS_SUPPORTS_HUGETLBFS)
> => Do you have a defconfig that would allow me to try the same as above ?

I think you're right, it's dead code AFAICS.

We have:

config PPC_BOOK3S_64
        ...
	select SYS_SUPPORTS_HUGETLBFS

config PPC_FSL_BOOK3E
        ...
	select SYS_SUPPORTS_HUGETLBFS if PHYS_64BIT || PPC64

config PPC_8xx
	...
	select SYS_SUPPORTS_HUGETLBFS


So we can't ever enable HUGETLBFS for Book3S 32.

Presumably the code got copied when we split the headers apart.

So I think you can just ignore that one, and we'll delete it.

cheers
