From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 14 Jan 2016 19:21:21 +0900
Subject: [PATCH] of: drop symbols declared by _OF_DECLARE() from modules
In-Reply-To: <34759085.vISMJm6PEF@wuerfel>
References: <1452745987-22146-1-git-send-email-yamada.masahiro@socionext.com>
 <34759085.vISMJm6PEF@wuerfel>
Message-ID: <CAK7LNATQB1ZBHM26HGSb=hHYsjROppAaOfWGE+M6TvadR71JQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2016-01-14 19:14 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 14 January 2016 13:33:06 Masahiro Yamada wrote:
>>
>> -#ifdef CONFIG_OF
>> +#if defined(CONFIG_OF) && !defined(MODULE)
>>  #define _OF_DECLARE(table, name, compat, fn, fn_type)                  \
>>         static const struct of_device_id __of_table_##name              \
>>                 __used __section(__##table##_of_table)                  \
>> --
>>
>
> Doesn't this lead to "unused function" warnings? Maybe we can change the "__used"
> into "__unused" when MODULE is set,

Yes, this is my intention.

I think this patch does so,
unless I am missing something...


  #if defined(CONFIG_OF) && !defined(MODULE)
          __used
  #else
          __unused
  #endif



> so the compiler will automatically
> drop all code that is only referenced from the entry.


-- 
Best Regards
Masahiro Yamada
