From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 19:17:24 +0000
Subject: [PATCH v2 03/14] clocksource: sp804: append CONFIG_OF
In-Reply-To: <1363108124-17484-4-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201303121917.24928.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resending this email as I got a few rejects from mailing lists when
I accidentally had an invalid email address for Mike)

On Tuesday 12 March 2013, Haojian Zhuang wrote:
> of_find_matching_node() & of_device_is_available() are depend on CONFIG_OF
> macro. If CONFIG_OF isn't defined for non-DT mode, the build error
> occurs.
> 
> So add CONFIG_OF for those DT functions.

I don't like this patch too much:

We should be able to do this without the #ifdef. The problem is really that the
declarations are also hidden behind an #ifdef. I think we should change the
linux/of.h header file to either provide alternative empty inline functions
or at least leave the declarations visible so we can compile the code as
long as the call gets discarded.

>  
> +#ifdef CONFIG_OF
>  static struct device_node *from = NULL;
>  
>  static struct of_device_id sp804_timer_match[] __initdata = {
> @@ -294,3 +295,4 @@ err:
>  	iounmap(base);
>  }
>  CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_dt_init);
> +#endif

There is actually an empty definition for CLOCKSOURCE_OF_DECLARE(),
but I think it would be better to still define it the same way as
with CONFIG_OF enabled but attribute((__unused__)), like:

#ifdef CONFIG_CLKSRC_OF
extern void clocksource_of_init(void);
#define CLOCKSOURCE_OF_DECLARE(name, compat, fn)                        \
        static const struct of_device_id __clksrc_of_table_##name       \
                __used __section(__clksrc_of_table)                     \
                 = { .compatible = compat, .data = fn };
#else
static inline void clocksource_of_init(void) {}
#define CLOCKSOURCE_OF_DECLARE(name, compat, fn)                        \
        static const struct of_device_id __clksrc_of_table_##name       \
                __unused = { .compatible = compat, .data = fn };
#endif

This way, all the code still gets built, but since there is nothing
pointing to __clksrc_of_table_##name and it is marked __unused, it
gets dropped along with all other symbols that are only referenced
from it.

	Arnd
