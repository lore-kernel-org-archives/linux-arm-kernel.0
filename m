From: yrehan@gmail.com (Mian Yousaf Kaukab)
Date: Tue, 1 Oct 2013 10:11:17 +0200
Subject: [PATCH] ARM: vexpress: ignore MIDR[0] for uart detection
In-Reply-To: <1380449869-19911-1-git-send-email-yrehan@gmail.com>
References: <1380449869-19911-1-git-send-email-yrehan@gmail.com>
Message-ID: <CAC_HJnzfvi59i0e0-VwhUtKPxiPLU9o+Y6Dvts9HVkKC6gyqRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Sun, Sep 29, 2013 at 12:17 PM, Mian Yousaf Kaukab <yrehan@gmail.com> wrote:
> Qemu vexpress-a9 target reports id of ARM Cortex-A9 core as r0p0
> and uses legacy map. That is UART0 at address 0x10009000. Ignore
> MIDR[0] during uart detection so that r0p0 as well as r0p1 use
> legacy map.
>
> Signed-off-by: Mian Yousaf Kaukab <yrehan@gmail.com>
> ---
>  arch/arm/include/debug/vexpress.S | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/debug/vexpress.S b/arch/arm/include/debug/vexpress.S
> index 524acd5..932db8b 100644
> --- a/arch/arm/include/debug/vexpress.S
> +++ b/arch/arm/include/debug/vexpress.S
> @@ -27,11 +27,16 @@
>
>                 @ Make an educated guess regarding the memory map:
>                 @ - the original A9 core tile (based on ARM Cortex-A9 r0p1)
> -               @   should use UART at 0x10009000
> +               @   should use UART at 0x10009000. Moreover, qemu vexpress-a9
> +               @   target reports id of ARM Cortex-A9 core as r0p0 and uses
> +               @   legacy map.
>                 @ - all other (RS1 complaint) tiles use UART mapped
>                 @   at 0x1c090000
>                 mrc     p15, 0, \rp, c0, c0, 0
> -               movw    \rv, #0xc091
> +               mov     \rv, #1
> +               @ Ignore MIDR[0] during comparison
> +               bic     \rp, \rp, \rv
> +               movw    \rv, #0xc090
>                 movt    \rv, #0x410f
>                 cmp     \rp, \rv

Can you please take a look at this patch? Default vexpress_defconfig
does not boot on qemu vexpress-a9 target without it.
I apologize if you get this message twice. I have to resend because
the previous message didn't reach the mailing list.


BR,
Yousaf
