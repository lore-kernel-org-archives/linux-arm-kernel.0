From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Dec 2013 21:59:39 +0100
Subject: [PATCH v2 16/16] misc: support for I-8024 in LP-8x4x
In-Reply-To: <1386901645-28895-17-git-send-email-ynvich@gmail.com>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-17-git-send-email-ynvich@gmail.com>
Message-ID: <201312142159.40250.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 December 2013, Sergei Ianovich wrote:
> +void nsleep(unsigned long nanosec)
> +{
> +       ktime_t t = ns_to_ktime(nanosec);
> +       long state = current->state;
> +
> +       __set_current_state(TASK_UNINTERRUPTIBLE);
> +       schedule_hrtimeout(&t, HRTIMER_MODE_REL);
> +       __set_current_state(state);
> +}
> +
> +static void lp8x4x_slot_reset_AO(struct lp8x4x_slot *s)
> +{
> +       int i;
> +       mutex_lock(&s->lock);
> +       for (i = 0; i < s->AO_len; i++)
> +               s->AO[i] = 0x2000;
> +       iowrite8(0x00, s->data_addr);
> +       nsleep(450);
> +       iowrite8(0xff, s->data_addr);
> +       mutex_unlock(&s->lock);
> +}

Have you checked that the nsleep definition actually does the
right thing here? 450 nanoseconds must be close the latency
you get from calling schedule_hrtimeout(). I'd suggest using
either ndelay() or usleep_range() instead, depending on your
needs.

If nsleep is really useful here, we should probably add that
as a generic API rather than having it in one driver.

	Arnd
