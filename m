From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Jun 2013 20:15:36 -0700
Subject: [PATCH] ARM: samsung: avoid racy early printk at bootup
In-Reply-To: <1370397539-21653-1-git-send-email-dianders@chromium.org>
References: <1370397539-21653-1-git-send-email-dianders@chromium.org>
Message-ID: <20130605031536.GA24910@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 04, 2013 at 06:58:59PM -0700, Doug Anderson wrote:
> At boot, we've got a stack trace that looks something like this
> (exynos5 as example)
> * exynos5_map_io
> * s3c_init_cpu
> * exynos_init_io
> * exynos5_dt_map_io
> * paging_init
> * setup_arch
> 
> When paging_init() runs we'll lose any early MMU mappings that we
> might have had to allow us access to S3C_VA_UART.  We won't add those
> mappings back in until after the SoC-specific map_io() function is
> called.  However, we print the CPU ID _right before_ we call the
> SoC-specific function.  Oops.
> 
> 
> Things happen to work all right most of the time because the mapping
> is sticking around in our TLB.  ...but if we get really unlucky (like
> me!) or we put an explicit flush_tlb_all() at the start of
> exynos_init_io(), then things go boom.
> 
> This patch moves the problematic printk() till after the cpu->map_io()
> call.  It also switches it over to pr_info().  This patch _doesn't_
> remove the questionable printks in the panic case, since we might get
> lucky and the TLB might still let us print.  This patch also adds a
> few warnings to help others avoid similar headaches.

This seems to be caused by not calling iotable_ini() in exynos_init_io()
when a device tree is passed into the kernel, thus not setting up the
mapping for the UART in that case.

I think the solution is instead to map the uart earlier. The window of
exposure is still there, but much smaller (and similar to how it always
has been).

In current upstream, if there is no map_io mach_desc entry at all,
debug_ll_io_init() will be called on all platforms. Seems appropriate
to call that explicitly before of_scan_flat_dt() in exynos_init_io()
in this case.

Or am I missing something?


-Olof
