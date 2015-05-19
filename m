From: ganguly.s@samsung.com (Sarbojit Ganguly)
Date: Tue, 19 May 2015 11:20:11 +0000 (GMT)
Subject: [RFC] arm: Add for atomic half word exchange
Message-ID: <1795987946.405311432034410830.JavaMail.weblogic@ep2mlwas07a>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes, I will try to do that. OTOH, I saw that  there was a discussion on removal of bad_xchg() altogether. Perhaps that approach be better than adding this half word exchange?


Regards,
Sarbojit

------- Original Message -------
Sender : Arnd Bergmann<arnd@arndb.de>
Date : May 19, 2015 18:51 (GMT+09:00)
Title : Re: [RFC] arm: Add for atomic half word exchange

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
