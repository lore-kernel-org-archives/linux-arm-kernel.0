From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 27 Mar 2015 22:08:06 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <20150323183211.GB1128@katana>
References: <55097C46.9010605@gmail.com> <20150318140037.GE3580@katana>
 <550A05E5.3050100@gmail.com> <20150319100944.GA914@katana>
 <550AEF9D.6090307@wwwdotorg.org> <20150319160208.GF7657@katana>
 <550B3725.10209@gmail.com> <20150320101925.GC2071@katana>
 <20150321210028.GA1078@katana> <550EBDBC.9000903@gmail.com>
 <20150323183211.GB1128@katana>
Message-ID: <5515C6B6.7080903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.03.2015 19:32, Wolfram Sang wrote:
>> If modifying i2c-mux-pinctrl to respect the sub-bus status property is
>> such a big issue, I'd rather leave the driver as is and expose all
>> sub-busses to userspace.
>
> Well, dunno what 'big issue' is in your book :) What definately needs to
> be done is:

Wolfram,

I had a look at the code in question again and prepared some patches
to return ERR_PTRs from i2c_add_mux_adapter(), rework users to check
for IS_ERR() and finally skip i2c_add_adapter for the OF disabled case.

I have them compile-tested but I don't have any hardware available
right now.

Anyway, I still have some questions.

> * handle "status" at mux-core level, not mux-driver

I get that.. but:

> * that probably needs us to convert i2c_add_mux_adapter() to return
>    ERR_PTRs instead of NULL, so we can distinguish the "disabled" case

What do you want to return from i2c_add_mux_adapter() if you find an OF
disabled child node?

AFAIKS, there is no explicit errno for a disabled device (node) so all
I can imagine here is to return either the &priv->adap before actually
calling i2c_add_adapter on it or NULL now that we explicitly check for
errors.

> * that would mean to fix all existing users

If we choose to return NULL, those users who can deal with a
missing/disabled sub-bus on the mux can check with IS_ERR()
the others should check with IS_ERR_OR_NULL().

We could also choose to return some other errno (-ENODEV maybe)
but still we'd have to double-check that return value on i2c-mux-pinctrl
and the others too if we don't care that i2c_add_adapter() wasn't
called for a mux.

> That's all not groundbreaking stuff, but needs caution and thoroughness.
> There might be some gory details left, though...

As I said before, the intention was not disable a possible i2c bus that
can be dynamically added/removed on that specific Dove SBC/CM-A510
board but to have a single i2c-mux-pinctrl in the SoC dtsi just because
the SoC has the optional i2c bus muxing.

While thinking about it (and I still think of it as a 'big issue'
compared to the intention of the initial patch) I came to the
conclusion that I should maybe just go for a board-specific
i2c-mux-pinctrl node instead of adding it to the SoC dtsi. That will
also avoid doubled i2c busses on boards with just the default i2c
option.

Sebastian
