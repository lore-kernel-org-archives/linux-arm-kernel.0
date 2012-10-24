From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 24 Oct 2012 07:19:13 -0700
Subject: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
In-Reply-To: <CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com>
 (Grazvydas Ignotas's message of "Wed, 24 Oct 2012 15:02:30 +0300")
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
 <CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com>
Message-ID: <87pq4854wu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Tue, Oct 23, 2012 at 9:09 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> From: Kevin Hilman <khilman@ti.com>
>>
>> When debounce clocks are disabled, ensure that the banks
>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>> subsequent off-mode transition will restore previous value from the
>> shadow copies (bank->context.debounce*) leading to mismatch state
>> between driver state and hardware state.
>
> This doesn't look right to me, aren't you effectively disabling
> debounce forever here? _gpio_dbck_disable is called from
> omap_gpio_runtime_suspend() and nothing will ever restore
> dbck_enable_mask back to what it was set by _set_gpio_debounce and
> debounce functionality is lost.

Yes, you're right.   Good catch.

I need a fix that's more targetted to the free/reset path.

Linus, please revert if it's not too late, and I'll come up with a more
targetted fix.

Kevin
