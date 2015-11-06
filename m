From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Nov 2015 10:29:54 +0100
Subject: [RFC PATCH 0/7] reset: make RESET_CONTROLLER a select'ed option
In-Reply-To: <CAK7LNARjtTXUNQFDtcqtxUo0c49h_kfNCf-2WZUEFXmttZoFyA@mail.gmail.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
 <3770393.BLNOaUSB5Q@wuerfel>
 <CAK7LNARjtTXUNQFDtcqtxUo0c49h_kfNCf-2WZUEFXmttZoFyA@mail.gmail.com>
Message-ID: <4121507.a7FHqRxKcX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 November 2015 14:58:04 Masahiro Yamada wrote:
> 2015-11-05 23:49 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> [1]
> Why is ARCH_HAS_RESET_CONTROLLER select'ed by
> ARCH_MULTIPLATFORM, but not by others?
> This seems weird.

I tried to avoid having to set this from each platform separately,
and all users of ARCH_HAS_RESET_CONTROLLER on ARM are also
based on ARCH_MULTIPLATFORM. The other platforms are lagging behind
in their conversion and use neither reset controllers not
multiplatform. If anyone wants to make them use reset controllers,
we probably want them to use multiplatform as well.

> We do not have such options like
>   ARCH_HAS_PINCTRL,  ARCH_HAS_COMMON_CLK...

We could of course change it in one direction or another, but it
didn't seem urgent here.

> [2]
> The difference is that yours is adding per-driver options such as
> RESET_SOCFPGA, RESET_BERLIN, etc.
> I think this is a good idea.
> 
> But, I notice lowlevel drivers select RESET_CONTROLLER,
> for example, RESET_SOCFPGA select RESET_CONTROLLER.
> 
> We generally do the opposite in other subsystems, I think.
> 
> 
> For example, the whole of clk menu is guarded by "depends on COMMON_CLK".
> 
> menu "Common Clock Framework"
>          depends on COMMON_CLK
> 
>      <bunch of low-level drivers>
> 
> endmenu
> 
> 
> Likewise for pinctrl.

We can do that too, either way works for me, and we are using both
in other parts of the kernel. REGMAP is an example for another subsystem
that gets selected by each driver that relies on the framework.

The practical difference is only in the case that the subsystem
is enabled (e.g. by using ARCH_MULTIPLATFORM) but all reset drivers
are disabled. A device driver using the API in one case will see
the stubbed-out inline helpers and not contain any object code
that relies on non-NULL return values from them, while in the
other case it calls into the subsystem code to get the same
return value at runtime.

If you volunteer to clean up my patch, feel free to choose between
the two options as you like.

	Arnd
