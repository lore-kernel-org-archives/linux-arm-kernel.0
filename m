From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 5 Apr 2018 21:34:31 -0400
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
Message-ID: <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2018 8:55 AM, Sinan Kaya wrote:
> While a barrier is present in writeX() function before the register write,
> a similar barrier is missing in the readX() function after the register
> read. This could allow memory accesses following readX() to observe
> stale data.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index fd00ddaf..6ac502f 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
>  		BUG();							\
>  	}								\
>  									\
> +	rmb();								\
>  	return pfx##ioswab##bwlq(__mem, __val);				\
>  }
>  
> 

Can we get these merged to 4.17? 

There was a consensus to fix the architectures having API violation issues.
https://www.mail-archive.com/netdev at vger.kernel.org/msg225971.html


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
