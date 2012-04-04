From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Apr 2012 15:23:16 +0100
Subject: [PATCH] ARM: fix __io macro for PCMCIA
In-Reply-To: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120404142316.GY24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2012 at 10:11:52PM -0500, Rob Herring wrote:
> @@ -134,9 +136,9 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
>   * readb() et.al. on such platforms.
>   */
>  #ifndef IO_SPACE_LIMIT
> -#if defined(CONFIG_PCMCIA_SOC_COMMON) || defined(CONFIG_PCMCIA_SOC_COMMON_MODULE)
> +#if defined(CONFIG_PCCARD)
>  #define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
> -#elif defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
> +#elif defined(CONFIG_PCI) || defined(CONFIG_ISA)
>  #define IO_SPACE_LIMIT ((resource_size_t)0xffff)
>  #else
>  #define IO_SPACE_LIMIT ((resource_size_t)0)

Now that we have a better understanding of the PCMCIA implementation on
HX4700, I'm NAKing at least the above part on the grounds its totally
wrong and bogus - the original unpatched is correct, and the modified
version is likely to introduce further problems for platforms which do
things properly.
