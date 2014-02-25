From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 15:37:02 +0100
Subject: [PATCH 4/4] ARM: keystone: Use dma-ranges for dma_pfn_offset
 configuration
In-Reply-To: <530CB49F.9060505@ti.com>
References: <1393275235-1087-1-git-send-email-santosh.shilimkar@ti.com>
 <201402251437.06400.arnd@arndb.de> <530CB49F.9060505@ti.com>
Message-ID: <5443441.XzmmNp2M6v@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014 17:19:59 Grygorii Strashko wrote:
> The Keystone can work in two modes:
> - LPAE disabled: In this case Platform bus notifier will not be called at all
> and DMA range == MEM range (32 bits mode)

The hardware setting doesn't change here, just the available memory, right?

> - LPAE enabled: In this case, I'll update code to treat absence of "dam-ranges"
> property as "no dma possible" and clean up DMA mask. Is it ok?
> In this mode "dam-ranges" prop has to be defined always to enable DMA.

Ok, sounds good.
 
> Empty "dma-ranges" can't be treated as "no translation required" because it is used
> to move one level up while traversing DT to find the valid "dma-ranges" prop.
> Used to handle child devices like:
> 
>  bus {
>         dma-ranges = <...>;
>         
>         Dev A {
>                 dma-ranges;
> 
>                 child_dev_A1 { }
>                 child_dev_A2 { }
> 
> This is standard behavior for "[dma-]ranges".

That is what I meant: "no translation required at this level". You still
have to go up to the root in order to know the full translation.

	Arnd
