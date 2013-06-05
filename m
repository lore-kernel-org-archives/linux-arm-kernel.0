From: dianders@chromium.org (Doug Anderson)
Date: Wed, 5 Jun 2013 13:56:52 -0700
Subject: [PATCH] ARM: samsung: avoid racy early printk at bootup
In-Reply-To: <20130605031536.GA24910@quad.lixom.net>
References: <1370397539-21653-1-git-send-email-dianders@chromium.org>
 <20130605031536.GA24910@quad.lixom.net>
Message-ID: <CAD=FV=UqLaAWh6pxAXXjcEu+D5ByoCB1V7F8Z2h-Ddq9ObS_6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Tue, Jun 4, 2013 at 8:15 PM, Olof Johansson <olof@lixom.net> wrote:
> This seems to be caused by not calling iotable_ini() in exynos_init_io()
> when a device tree is passed into the kernel, thus not setting up the
> mapping for the UART in that case.
>
> I think the solution is instead to map the uart earlier. The window of
> exposure is still there, but much smaller (and similar to how it always
> has been).
>
> In current upstream, if there is no map_io mach_desc entry at all,
> debug_ll_io_init() will be called on all platforms. Seems appropriate
> to call that explicitly before of_scan_flat_dt() in exynos_init_io()
> in this case.

Oh.  Ummm, right.  Yes, debug_ll_io_init() is exactly what's needed
here instead of all the complexity of what I proposed.  New patch
coming shortly.  Thanks!  :)

-Doug
