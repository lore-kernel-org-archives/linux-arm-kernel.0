From: jayakumar.lkml@gmail.com (Jaya Kumar)
Date: Tue, 15 Jun 2010 08:16:25 +0800
Subject: [PATCH v3 10/11] [ARM] tegra: Add framebuffer driver
In-Reply-To: <AANLkTikqOrciEnESCC1yGm0UvcxdK942ddrZF4K49TVb@mail.gmail.com>
References: <1271198563-10424-1-git-send-email-konkers@android.com>
	<1276549827-2688-1-git-send-email-konkers@android.com>
	<1276549827-2688-2-git-send-email-konkers@android.com>
	<1276549827-2688-3-git-send-email-konkers@android.com>
	<1276549827-2688-4-git-send-email-konkers@android.com>
	<1276549827-2688-5-git-send-email-konkers@android.com>
	<1276549827-2688-6-git-send-email-konkers@android.com>
	<1276549827-2688-7-git-send-email-konkers@android.com>
	<1276549827-2688-8-git-send-email-konkers@android.com>
	<1276549827-2688-9-git-send-email-konkers@android.com>
	<1276549827-2688-10-git-send-email-konkers@android.com>
	<1276549827-2688-11-git-send-email-konkers@android.com>
	<AANLkTikqOrciEnESCC1yGm0UvcxdK942ddrZF4K49TVb@mail.gmail.com>
Message-ID: <AANLkTilppHVz2XpLfin9wxrt9kHE1PIbct5XYvd_4iiX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 7:59 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 5:10 AM, Erik Gilling <konkers@android.com> wrote:
>
>> + ? ? ? ? ? ? ? if (tegra_fb_wait_for_event(tegra_fb, HZ/10, DC_INT_FRAME_END))
>
> I still didn't follow how tegra_fb_activate is using the -ETIMEDOUT
> return value from the wait, it seems like it is just ignored. You are
> also doing stuff like HZ/10 and you might prefer to use
> msecs_to_jiffies.
>

I was unclear above. I mean the following code:

+	while (tegra_fb_readl(tegra_fb, DC_CMD_STATE_CONTROL) & 3) {
+		vsync_count++;
+		if (tegra_fb_wait_for_event(tegra_fb, HZ/10, DC_INT_FRAME_END))
+			break;
+	}
+	if (unlikely(vsync_count > 1))
+		pr_warning("%s: waited for %d vsyncs\n", __func__, vsync_count);

It seems to me like the timeout from wait_for_event isn't propagated
back upwards. Maybe it isn't needed but the way the code handles this
seems confusing to me.

Thanks,
jaya
