From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Oct 2017 12:53:38 +0100
Subject: [PATCH 1/1] arm/stacktrace: stop unwinding after an invalid
 address.
In-Reply-To: <1508845602-33508-1-git-send-email-maninder1.s@samsung.com>
References: <CGME20171024114852epcas5p199ffd8d75fc57e46d46025e12180c156@epcas5p1.samsung.com>
 <1508845602-33508-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20171024115338.GF20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 05:16:42PM +0530, Maninder Singh wrote:
> This patch stops unwinding backtrace in case of below 2 cases.
> 
> (Issue observed while porting stackdepot on ARM, duplicate
> entries created in stackdepot
> reference patch for workaround in stackdepot:-
> https://lkml.org/lkml/2017/10/11/353
> ).
> 
> 1. If address belongs to irq/exception code, ignore it.
> save_stack+0x40/0xec
>  __set_page_owner+0x2c/0x64
> ....
> ....
>  __handle_domain_irq+0x9c/0x130
>  gic_handle_irq+0x40/0x80
>  __irq_usr+0x4c/0x60
>  0xb6507818
> ^^^^^^^

However, we _do_ want to trace through an IRQ taken in SVC mode, but you
completely remove all that code.  So, not taking this patch, sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
