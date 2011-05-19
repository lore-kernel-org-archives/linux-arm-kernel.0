From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 19 May 2011 16:04:05 +0800
Subject: atmel-mci causes kernel panic when CONFIG_DEBUG_VM is set
In-Reply-To: <4DD4CC68.80408@atmel.com>
References: <4DD4CC68.80408@atmel.com>
Message-ID: <BANLkTinaPW5xcdrNewJC6OW9nqWHC_-TVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/19 Ludovic Desroches <ludovic.desroches@atmel.com>:
> Hello,
>
> There is a bug with the atmel-mci driver when the debug feature
> CONFIG_DEBUG_VM is set.
>
> Into the atmci_read_data_pio function we use flush_dcache_page (do we really
> need it?) which call the page_mapping function where we can find
> VM_BUG_ON(PageSlab(Page)). Then a kernel panic happens.
>
> I don't understand the purpose of the VM_BUG_ON(PageSlab(Page)) (the page
> comes from a scatter list). How could I correct this problem?

linux/include/linux/mmdebug.h:

#ifdef CONFIG_DEBUG_VM
#define VM_BUG_ON(cond) BUG_ON(cond)
#else
#define VM_BUG_ON(cond) do { (void)(cond); } while (0)
#endif

it is something like "assert" in kernel.

>
> Thanks for your help
>
> Regards,
>
> Ludovic
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
