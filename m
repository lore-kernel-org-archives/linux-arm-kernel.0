From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Apr 2013 16:43:32 +0200
Subject: [PATCH v2] pinctrl: move subsystem mutex to pinctrl_dev struct
In-Reply-To: <1366794119-766-1-git-send-email-linus.walleij@stericsson.com>
References: <1366794119-766-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <2852417.oyEN2DhaoE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 April 2013 11:01:59 Linus Walleij wrote:
>  /**
> - * pinctrl_lookup_state() - retrieves a state handle from a pinctrl handle
> - * @p: the pinctrl handle to retrieve the state from
> - * @name: the state name to retrieve
> + * pinctrl_select_state() - select/activate/program a pinctrl state to HW
> + * @p: the pinctrl handle for the device that requests configuration
> + * @state: the state handle to select/activate/program
>   */
> -struct pinctrl_state *pinctrl_lookup_state(struct pinctrl *p, const char *name)
> -{
> -       struct pinctrl_state *s;
> -
> -       mutex_lock(&pinctrl_mutex);
> -       s = pinctrl_lookup_state_locked(p, name);
> -       mutex_unlock(&pinctrl_mutex);
> -
> -       return s;
> -}
> -EXPORT_SYMBOL_GPL(pinctrl_lookup_state);
> -
> -static int pinctrl_select_state_locked(struct pinctrl *p,
> -                                      struct pinctrl_state *state)
> +int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
>  {
>         struct p


This showed up in linux-next and broke a lot of driver modules, since you
remove the EXPORT_SYMBOL_GPL(pinctrl_lookup_state) line.

	Arnd
