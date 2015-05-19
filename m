From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 11:51:21 +0200
Subject: [RFC] arm: Add for atomic half word exchange
In-Reply-To: <1122007906.400701432028368414.JavaMail.weblogic@ep2mlwas07a>
References: <1122007906.400701432028368414.JavaMail.weblogic@ep2mlwas07a>
Message-ID: <4497461.dn0jdrPFfy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 09:39:33 Sarbojit Ganguly wrote:
> Since 16 bit half word exchange was not there and MCS based qspinlock by Waiman's xchg_tail() requires an atomic exchange on a half word,
> here is a small modification to __xchg() code.

We have discussed a similar patch before, see
https://lkml.org/lkml/2015/2/25/390

>  #if __LINUX_ARM_ARCH__ >= 6
> @@ -50,6 +52,23 @@
>                         : "r" (x), "r" (ptr)
>                         : "memory", "cc");
>                 break;
> +               /* 
> +                * halfword exclusive exchange
> +                * This is new implementation as qspinlock
> +                * wants 16 bit atomic CAS.
> +                */
> +       case 2:
> +               asm volatile("@ __xchg2\n"
> +               "1:     ldrexh  %0, [%3]\n"
> +               "       strexh  %1, %2, [%3]\n"
> +               "       teq     %1, #0\n"
> +               "       bne     1b"
> +                       : "=&r" (ret), "=&r" (tmp)
> +                       : "r" (x), "r" (ptr)
> +                       : "memory", "cc");
> +               break;
>         case 4: 
>                 asm volatile("@ __xchg4\n"
>                 "1:     ldrex   %0, [%3]\n"

Please try to find a way to make this compile when CONFIG_CPU_V6
is set.

	Arnd
