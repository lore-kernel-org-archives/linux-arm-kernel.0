From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Mon, 5 Jun 2017 19:05:40 +0900
Subject: [PATCH] arm: LPAE: kexec: clear TTBCR.T1SZ explicitly when
 PHYS_OFFSET > PAGE_OFFSET
In-Reply-To: <20170605093429.GE4902@n2100.armlinux.org.uk>
References: <1496654569-4749-1-git-send-email-hoeun.ryu@gmail.com>
 <20170605093429.GE4902@n2100.armlinux.org.uk>
Message-ID: <CABeRdtoEi+21mzz0h0s9qfYGtnAr4N4AK3PHNcNxv_4A89s=Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 6:34 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Jun 05, 2017 at 06:22:20PM +0900, Hoeun Ryu wrote:
>> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
>> index 5e5720e..9ac2bec 100644
>> --- a/arch/arm/mm/proc-v7-3level.S
>> +++ b/arch/arm/mm/proc-v7-3level.S
>> @@ -140,6 +140,7 @@ ENDPROC(cpu_v7_set_pte_ext)
>>        * otherwise booting secondary CPUs would end up using TTBR1 for the
>>        * identity mapping set up in TTBR0.
>>        */
>> +     bichi   \tmp, \tmp, #(1 << 16)                          @ clear TTBCR.T1SZ
>
> This looks insufficient.  There's two bits here:
>
>  * TTBR0/TTBR1 split (PAGE_OFFSET):
>  *   0x40000000: T0SZ = 2, T1SZ = 0 (not used)
>  *   0x80000000: T0SZ = 0, T1SZ = 1
>  *   0xc0000000: T0SZ = 0, T1SZ = 2
>
> but you seem to only be clearing one bit.

Oh, I'm sorry for the mistake, I'll fix this like #(7 << 16) in v2.
(There're 3 bits in TxSZ)
Thank you for the review.

>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
