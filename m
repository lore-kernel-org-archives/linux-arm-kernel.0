From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jan 2016 11:14:58 +0100
Subject: [PATCH] of: drop symbols declared by _OF_DECLARE() from modules
In-Reply-To: <1452745987-22146-1-git-send-email-yamada.masahiro@socionext.com>
References: <1452745987-22146-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <34759085.vISMJm6PEF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 January 2016 13:33:06 Masahiro Yamada wrote:
> 
> -#ifdef CONFIG_OF
> +#if defined(CONFIG_OF) && !defined(MODULE)
>  #define _OF_DECLARE(table, name, compat, fn, fn_type)                  \
>         static const struct of_device_id __of_table_##name              \
>                 __used __section(__##table##_of_table)                  \
> -- 
> 

Doesn't this lead to "unused function" warnings? Maybe we can change the "__used"
into "__unused" when MODULE is set, so the compiler will automatically
drop all code that is only referenced from the entry.

	Arnd
