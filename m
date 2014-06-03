From: dianders@chromium.org (Doug Anderson)
Date: Tue, 3 Jun 2014 16:26:01 -0700
Subject: [PATCH] arm: mct: Don't reset the counter during boot and resume
In-Reply-To: <1401821299-24431-1-git-send-email-chirantan@chromium.org>
References: <1401821299-24431-1-git-send-email-chirantan@chromium.org>
Message-ID: <CAD=FV=VfK6DoK53ZBzouoUz-j8COUDUkifEenggC0kkLrJnVcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chirantan,

On Tue, Jun 3, 2014 at 11:48 AM, Chirantan Ekbote
<chirantan@chromium.org> wrote:
> Unfortunately on some exynos systems, resetting the mct counter also
> resets the architected timer counter.  This can cause problems if the
> architected timer driver has already been initialized because the kernel
> will think that the counter has wrapped around, causing a big jump in
> printk timestamps and delaying any scheduled clock events until the
> counter reaches the value it had before it was reset.
>
> The kernel code makes no assumptions about the initial value of the mct
> counter so there is no reason from a software perspective to clear the
> counter before starting it.  This also fixes the problems described in
> the previous paragraph.
>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> ---
>  drivers/clocksource/exynos_mct.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

I can confirm that this fixes problems I described in
<http://www.spinics.net/lists/linux-samsung-soc/msg29085.html>.  Now
when I boot there's no mysterious delay and there's no big jump in
time.

I'd love to see this in 3.16 so we can get rid of this annoying delay.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
