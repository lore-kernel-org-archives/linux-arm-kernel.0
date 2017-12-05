From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 5 Dec 2017 19:02:26 +0900
Subject: [PATCH] mtd: nand: squash struct nand_buffers into struct
 nand_chip
In-Reply-To: <20171204101043.602ff213@bbrezillon>
References: <1512366470-16772-1-git-send-email-yamada.masahiro@socionext.com>
 <20171204101043.602ff213@bbrezillon>
Message-ID: <CAK7LNATtk9=i3HkPrW=F1YtnM1vvEM3NtMZcPNi_0C5s_X1X1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

2017-12-04 18:10 GMT+09:00 Boris Brezillon <boris.brezillon@free-electrons.com>:

>>       }
>>
>>       if (!(chip->options & NAND_OWN_BUFFERS)) {
>> -             nbuf = kzalloc(sizeof(*nbuf), GFP_KERNEL);
>> -             if (!nbuf)
>> +             chip->ecccalc = kmalloc(mtd->oobsize, GFP_KERNEL);
>> +             if (!chip->ecccalc)
>>                       return -ENOMEM;
>>
>> -             nbuf->ecccalc = kmalloc(mtd->oobsize, GFP_KERNEL);
>> -             if (!nbuf->ecccalc) {
>> +             chip->ecccode = kmalloc(mtd->oobsize, GFP_KERNEL);
>> +             if (!chip->ecccode) {
>>                       ret = -ENOMEM;
>>                       goto err_free_nbuf;
>>               }
>
> Hm, again not directly related to this patch, but I wonder if we
> couldn't allocate those buffers only when they are really needed. For
> example, most NAND controllers do the ECC calculation/correct in HW and
> simply don't need those buffers.


The only idea I came up with is to add a new flag,
but I am not sure if you are happy with it
because we are removing NAND_OWN_BUFFERS.





-- 
Best Regards
Masahiro Yamada
