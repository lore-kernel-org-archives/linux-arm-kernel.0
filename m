From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Apr 2013 16:59:37 +0200
Subject: [PATCH v2] pinctrl: move subsystem mutex to pinctrl_dev struct
In-Reply-To: <2852417.oyEN2DhaoE@wuerfel>
References: <1366794119-766-1-git-send-email-linus.walleij@stericsson.com>
 <2852417.oyEN2DhaoE@wuerfel>
Message-ID: <CACRpkdb0XgSB7bCxZUhNyTW6KmcQzqz5KMRbnMzYfQ5HSmRzBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 4:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 24 April 2013 11:01:59 Linus Walleij wrote:
>>  /**
>> - * pinctrl_lookup_state() - retrieves a state handle from a pinctrl handle
>> - * @p: the pinctrl handle to retrieve the state from
>> - * @name: the state name to retrieve
>> + * pinctrl_select_state() - select/activate/program a pinctrl state to HW
>> + * @p: the pinctrl handle for the device that requests configuration
>> + * @state: the state handle to select/activate/program
>>   */
>> -struct pinctrl_state *pinctrl_lookup_state(struct pinctrl *p, const char *name)
>> -{
>> -       struct pinctrl_state *s;
>> -
>> -       mutex_lock(&pinctrl_mutex);
>> -       s = pinctrl_lookup_state_locked(p, name);
>> -       mutex_unlock(&pinctrl_mutex);
>> -
>> -       return s;
>> -}
>> -EXPORT_SYMBOL_GPL(pinctrl_lookup_state);
>> -
>> -static int pinctrl_select_state_locked(struct pinctrl *p,
>> -                                      struct pinctrl_state *state)
>> +int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
>>  {
>>         struct p
>
>
> This showed up in linux-next and broke a lot of driver modules, since you
> remove the EXPORT_SYMBOL_GPL(pinctrl_lookup_state) line.

No that one is just moved ... I think you're seeing that
pinctrl_select_state() has lost its export. I'll fix this up
and send a v3.

Yours,
Linus Walleij
