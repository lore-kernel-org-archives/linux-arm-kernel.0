From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 24 May 2013 16:22:31 +0100
Subject: [PATCH v3] pinctrl: move subsystem mutex to pinctrl_dev struct
In-Reply-To: <1366988907-13485-1-git-send-email-linus.walleij@stericsson.com>
References: <1366988907-13485-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAAG0J990rqDdG5WdOrVGqZ9tFgJmnmP18S=c6o9JNygTLHS6=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2013 16:08, Linus Walleij <linus.walleij@stericsson.com> wrote:
> @@ -608,7 +610,7 @@ static int pinconf_dbg_config_print(struct seq_file *s, void *d)
>         bool found = false;
>         unsigned long config;
>
> -       mutex_lock(&pinctrl_mutex);
> +       mutex_lock(&pctldev->mutex);
>
>         /* Parse the pinctrl map and look for the elected pin/state */
>         for_each_maps(maps_node, i, map) {

This change causes an oops on v3.10-rc2 when you read pinconf-config
because pctldev is initialised to NULL and not set until inside the
loop. I considered initialising pctldev to s->private, but I'm
concerned that if pctldev is altered in the loop it could end up
unlocking a different mutex to the one it locked. If this debugfs file
isn't meant to be specific to a pinctrl device should it be in the
root pinctrl directory instead of in each pinctrl device's directory?

Cheers
James
