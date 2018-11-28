From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 28 Nov 2018 15:02:25 +0900
Subject: [PATCH] arm64: mm: define NET_IP_ALIGN to 0
In-Reply-To: <20181107171038.25281-1-ard.biesheuvel@linaro.org>
References: <20181107171038.25281-1-ard.biesheuvel@linaro.org>
Message-ID: <20181128150225.8D30.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I found that arm64 board that had AVE controller couldn't receive
any packets after this change.

AVE controller (hardware) forces to ignore lower 2bits of buffer start address,
that is, the address is always aligned with 4bytes.
And more, the controller puts received datas with "2byte headroom" [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/socionext/sni_ave.c#n591

In case that NET_IP_ALIGN is 2, the driver proceeds skb->data by 2byte
with calling netdev_alloc_skb_ip_align(), and then, skb->data is equivalent
to start address of data reception.

    +0x00 00  buffer start address
    +0x01 00  
    +0x02 XX  skb->data == start address of data reception
    +0x03 XX  
    ...

However, in case that NET_IP_ALIGN is zero, skb->data is the same address
as buffer start address, so skb->data differs from start address of data
reception. Finally the driver can't receive any packets collectly.

    +0x00 00  skb->data == buffer start address
    +0x01 00  
    +0x02 XX  start address of data reception
    +0x03 XX  
    ...

Although I might be able to replace NET_IP_ALIGN with an own macro
without calling netdev_alloc_skb_ip_align(), it seems clumsy.
Is that any ideas?

---
Best Regards,
Kunihiko Hayashi


On Wed, 7 Nov 2018 18:10:38 +0100
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On arm64, there is no need to add 2 bytes of padding to the start of
> each network buffer just to make the IP header appear 32-bit aligned.
> 
> Since this might actually adversely affect DMA performance some
> platforms, let's override NET_IP_ALIGN to 0 to get rid of this
> padding.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/processor.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 3e2091708b8e..6b0d4dff5012 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -24,6 +24,14 @@
>  #define KERNEL_DS	UL(-1)
>  #define USER_DS		(TASK_SIZE_64 - 1)
>  
> +/*
> + * On arm64 systems, unaligned accesses by the CPU are cheap, and so there is
> + * no point in shifting all network buffers by 2 bytes just to make some IP
> + * header fields appear aligned in memory, potentially sacrificing some DMA
> + * performance on some platforms.
> + */
> +#define NET_IP_ALIGN	0
> +
>  #ifndef __ASSEMBLY__
>  #ifdef __KERNEL__
>  
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
