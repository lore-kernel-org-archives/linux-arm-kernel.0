From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 15:57:13 +0200
Subject: [PATCH v3] pinctrl: move subsystem mutex to pinctrl_dev struct
In-Reply-To: <CAAG0J990rqDdG5WdOrVGqZ9tFgJmnmP18S=c6o9JNygTLHS6=g@mail.gmail.com>
References: <1366988907-13485-1-git-send-email-linus.walleij@stericsson.com>
 <CAAG0J990rqDdG5WdOrVGqZ9tFgJmnmP18S=c6o9JNygTLHS6=g@mail.gmail.com>
Message-ID: <CACRpkda4s_Qq-R3wZ0BQSxLWm1udR4Or=h28QdEcwt6BnwEb7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 5:22 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On 26 April 2013 16:08, Linus Walleij <linus.walleij@stericsson.com> wrote:
>> @@ -608,7 +610,7 @@ static int pinconf_dbg_config_print(struct seq_file *s, void *d)
>>         bool found = false;
>>         unsigned long config;
>>
>> -       mutex_lock(&pinctrl_mutex);
>> +       mutex_lock(&pctldev->mutex);
>>
>>         /* Parse the pinctrl map and look for the elected pin/state */
>>         for_each_maps(maps_node, i, map) {
>
> This change causes an oops on v3.10-rc2 when you read pinconf-config
> because pctldev is initialised to NULL and not set until inside the
> loop.

It is taking the wrong mutex. The function right below it is
also iterating the maps, and then it shall take the maps
mutex and nothing else.

I just sent a patch fixing it up.

> If this debugfs file
> isn't meant to be specific to a pinctrl device should it be in the
> root pinctrl directory instead of in each pinctrl device's directory?

Yes. We need to fix this after this immediate fixup, for the next
merge window.

Yours,
Linus Walleij
