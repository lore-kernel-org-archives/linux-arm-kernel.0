From: ccross@android.com (Colin Cross)
Date: Mon, 14 Jun 2010 17:43:34 -0700
Subject: [PATCH v3 10/11] [ARM] tegra: Add framebuffer driver
In-Reply-To: <AANLkTilppHVz2XpLfin9wxrt9kHE1PIbct5XYvd_4iiX@mail.gmail.com>
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
	<AANLkTilppHVz2XpLfin9wxrt9kHE1PIbct5XYvd_4iiX@mail.gmail.com>
Message-ID: <AANLkTikOYNoOGH5-6hYJ5dVZ-qlHE88xGb3G64e_eUH8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 14, 2010 at 5:16 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 7:59 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> On Tue, Jun 15, 2010 at 5:10 AM, Erik Gilling <konkers@android.com> wrote:
>>
>>> + ? ? ? ? ? ? ? if (tegra_fb_wait_for_event(tegra_fb, HZ/10, DC_INT_FRAME_END))
>>
>> I still didn't follow how tegra_fb_activate is using the -ETIMEDOUT
>> return value from the wait, it seems like it is just ignored. You are
>> also doing stuff like HZ/10 and you might prefer to use
>> msecs_to_jiffies.
>>
>
> I was unclear above. I mean the following code:
>
> + ? ? ? while (tegra_fb_readl(tegra_fb, DC_CMD_STATE_CONTROL) & 3) {
> + ? ? ? ? ? ? ? vsync_count++;
> + ? ? ? ? ? ? ? if (tegra_fb_wait_for_event(tegra_fb, HZ/10, DC_INT_FRAME_END))
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? }
> + ? ? ? if (unlikely(vsync_count > 1))
> + ? ? ? ? ? ? ? pr_warning("%s: waited for %d vsyncs\n", __func__, vsync_count);
>
> It seems to me like the timeout from wait_for_event isn't propagated
> back upwards. Maybe it isn't needed but the way the code handles this
> seems confusing to me.

ETIMEDOUT in tegra_fb_wait_for_event is detecting waiting on an
interrupt that is not firing, and the loop in tegra_fb_activate is
checking for the double-buffering bits to clear in a reasonable amount
of time.  The if check in the loop makes sure that if the frame
interrupt is not occuring, the driver doesn't loop forever on the
double-buffering bits.

I'll modify tegra_fb_activate to propagate the error code and use
msecs_to_jiffies.

Thanks,
Colin
