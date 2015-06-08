From: gangchen@rdamicro.com (Chen Gang)
Date: Mon, 08 Jun 2015 13:30:18 +0800
Subject: [PATCH 1/1] ARM : missing corrupted reg in __do_div_asm
In-Reply-To: <1433225609-7148-1-git-send-email-gangchen@rdamicro.com>
References: </home/gachen/Re: [PATCH 1_1] ARM:r0 is also corrupted after
 calling __do_div64..eml>
 <1433225609-7148-1-git-send-email-gangchen@rdamicro.com>
Message-ID: <5575286A.1080002@rdamicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

     I tried to make a test program to illustrate the patch.

Without the patch, the log shows
"[250970.715392] remains1 is 2, remains2 is 0"
And the remains2 is wrong

With the patch, the log is
"[250977.724181] remains1 is 2, remains2 is 4".
now both remains1 and remains2 are correct.

I compared the output assembly and it showed in the faulty version,
r0 ( I am using little endian system) is not reload after the
first do_div and before the second do_div call in function mydiv64.



Br, Chen Gang

#include <asm/div64.h>
#include <linux/init.h>
#include <linux/printk.h>

typedef unsigned long long ull;

void mydiv64(ull tt, unsigned base1, unsigned base2,
         unsigned *rems1, unsigned *rems2)
{
     ull t = tt;
     *rems1 = do_div(t, base1);
     *rems2 = do_div(tt, base2);
     return ;
}

static int __init div_test(void)
{
     ull t;
     unsigned int remains1;
     unsigned int remains2;
     unsigned base1, base2;

     t = 100;
     base1 = 7;
     base2 = 8;

     mydiv64(t, base1, base2, &remains1, &remains2);
     printk(KERN_ERR"remains1 is %d, remains2 is %d\n",
             remains1, remains2);

     return -1;
}

static void __exit div_test_exit(void)
{
}

module_init(div_test);
module_exit(div_test_exit);

On 06/02/2015 02:13 PM, Chen Gang wrote:
> __xl (r0 in little endian system, or R1 in big endian system) is corrupted
> after calling __do_div64 and compiler is not informed about this in
> macro __do_div_asm. If n is used again afterwards, __xl won't be
> reloaded and n will contain incorrect value.
> ---
>   arch/arm/include/asm/div64.h | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index 662c7bd..fa9489e 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -34,12 +34,14 @@
>   	register unsigned long long __n   asm("r0") = n;	\
>   	register unsigned long long __res asm("r2");		\
>   	register unsigned int __rem       asm(__xh);		\
> +	register unsigned int __clobber   asm(__xl);		\
>   	asm(	__asmeq("%0", __xh)				\
> -		__asmeq("%1", "r2")				\
> -		__asmeq("%2", "r0")				\
> -		__asmeq("%3", "r4")				\
> +		__asmeq("%1", __xl)				\
> +		__asmeq("%2", "r2")				\
> +		__asmeq("%3", "r0")				\
> +		__asmeq("%4", "r4")				\
>   		"bl	__do_div64"				\
> -		: "=r" (__rem), "=r" (__res)			\
> +		: "=r" (__rem), "=r" (__clobber), "=r" (__res)  \
>   		: "r" (__n), "r" (__base)			\
>   		: "ip", "lr", "cc");				\
>   	n = __res;						\
