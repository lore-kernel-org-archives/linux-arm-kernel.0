From: bhelgaas@google.com (Bjorn Helgaas)
Date: Sun, 25 Sep 2011 06:59:27 -0600
Subject: [RFC PATCH 2/3] bootstage: Insert bootstage_mark to record timing
	for bootup.
In-Reply-To: <1316818998-30711-3-git-send-email-sjg@chromium.org>
References: <1316818998-30711-1-git-send-email-sjg@chromium.org>
	<1316818998-30711-3-git-send-email-sjg@chromium.org>
Message-ID: <CAErSpo6PFPLRAfPd_myJXrGdYofOR82YXy6U4YZEfp-bfXhQuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 5:03 PM, Simon Glass <sjg@chromium.org> wrote:
> From: Da Zheng <zhengda@chromium.org>
>
> From: Da Zheng <zhengda@chromium.org>
>
> This inserts calls to bootstage_mark() to timestamp the kernel moving
> between the different initcall levels.
>
> Signed-off-by: Da Zheng <zhengda@chromium.com>
> ---
> ?init/bootstage.c | ? 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> ?init/main.c ? ? ?| ? ?7 +++++++
> ?2 files changed, 56 insertions(+), 0 deletions(-)
>
> diff --git a/init/bootstage.c b/init/bootstage.c
> index 79e9761..6f4668f 100644
> --- a/init/bootstage.c
> +++ b/init/bootstage.c
> @@ -226,3 +226,52 @@ static int __init bootstage_init(void)
> ?}
>
> ?postcore_initcall(bootstage_init);
> +
> +static int __init post_core_initcall(void)
> +{
> + ? ? ? bootstage_mark("core_initcall");
> + ? ? ? return 0;
> +}
> +core_initcall_sync(post_core_initcall);

I'm sure you considered just instrumenting do_one_initcall() rather
than adding these individual initcall marks?  That would get you a lot
more timestamps (maybe too many), and would help identify individual
drivers, which I suspect will be common offenders.

Bjorn
