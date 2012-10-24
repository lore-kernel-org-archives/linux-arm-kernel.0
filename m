From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 10:16:09 +0200
Subject: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
In-Reply-To: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <CACRpkdb_zO0G5hsU5hTqnmD6Zju_xBwdmnk6C=Ok1R7-oNT_iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 8:09 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:

> From: Kevin Hilman <khilman@ti.com>
>
> When debounce clocks are disabled, ensure that the banks
> dbck_enable_mask is cleared also.  Otherwise, context restore on
> subsequent off-mode transition will restore previous value from the
> shadow copies (bank->context.debounce*) leading to mismatch state
> between driver state and hardware state.
>
> This was discovered when board code was doing
>
>   gpio_request_one()
>   gpio_set_debounce()
>   gpio_free()
>
> which was leaving the GPIO debounce settings in a confused state.
> Then, enabling off mode causing bogus state to be restored, leaving
> GPIO debounce enabled which then prevented the CORE powerdomain from
> transitioning.
>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Thanks! Applied with Felipe's and Santosh's ACKs.

Yours,
Linus Walleij
