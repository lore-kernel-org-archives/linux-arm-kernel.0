From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Jul 2014 22:11:06 +0200
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU advertises
 it has exclusives
In-Reply-To: <E1X39Wr-0000ly-RF@rmk-PC.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <E1X39Wr-0000ly-RF@rmk-PC.arm.linux.org.uk>
Message-ID: <4606711.7KmFAGVNmG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 July 2014 20:52:17 Russell King wrote:
>         /*
>          * HWCAP_TLS is available only on 1136 r1p0 and later,
>          * see also kuser_get_tls_init.
>          */
> -       if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
> +       if (read_cpuid_part() == ARM_CPU_PART_ARM1136 &&
> +           ((id >> 20) & 3) == 0) {
>                 elf_hwcap &= ~HWCAP_TLS;
> +               return;
> +       }
> 

Would it make sense to tie this check to the ARMv6K architecture level?

I see that cpu_architecture currently reports the same value for plain
ARMv6 (1136r0) and for ARMv6K (1136r1+ or any other ARM11), but we already
distinguish them at compile time in a number of places and it seems you
make the exact same distinction here at runtime.

	Arnd
