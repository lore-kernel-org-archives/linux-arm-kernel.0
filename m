From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Sep 2014 11:15:15 +0100
Subject: [PATCH] arm64: LLVMLinux: Fix inline arm64 assembly for use with
 clang
In-Reply-To: <CAFzeTN2Q-RkOeDx4jG5jiEtiN7i+gkfmyvBC1b3B1wpDPUDdxw@mail.gmail.com>
References: <1409959460-15989-1-git-send-email-behanw@converseincode.com>
 <20140908105307.GF26030@arm.com>
 <CAFzeTN2Q-RkOeDx4jG5jiEtiN7i+gkfmyvBC1b3B1wpDPUDdxw@mail.gmail.com>
Message-ID: <20140909101515.GB1754@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 07:35:47PM +0100, Mark Charlebois wrote:
> When I compile
> 
> int main()
> {
>         u64 foo, tmp;
> 
>        // This fails for clang but not gcc
>         asm volatile(
>         "       mrs     %0, mair_el1\n"
>         "       bfi     %0, %1, #%2, #8\n"
>         "       msr     mair_el1, %0\n"
>         "       isb\n"
>         : "=&r" (tmp)
>         : "r" (foo), "i" (MT_NORMAL * 8));
> }
> 
> Clang fails and GCC generates:
> 
> 00000000004004f0 <main>:
>   4004f0: d538a208 mrs x8, mair_el1
>   4004f4: b3601d08 bfi x8, x8, #32, #8
>   4004f8: d518a208 msr mair_el1, x8
>   4004fc: d5033fdf isb
>   400500: 2a1f03e0 mov w0, wzr
>   400504: d65f03c0 ret

Ok, so we can just drop the '#' prefix as it probably shouldn't be there
anyway. Can you send a patch making just that change, please?

Will
