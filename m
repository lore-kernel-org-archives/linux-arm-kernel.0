From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 13:48:43 +0000
Subject: [PATCH v2 03/14] clocksource: sp804: append CONFIG_OF
In-Reply-To: <CAD6h2NQHjP2YSv2=BAqTa+MaZKvSe6JPwmuhMLkJcjuaMtVtsA@mail.gmail.com>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <201303121917.24928.arnd@arndb.de>
 <CAD6h2NQHjP2YSv2=BAqTa+MaZKvSe6JPwmuhMLkJcjuaMtVtsA@mail.gmail.com>
Message-ID: <201303141348.43552.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 March 2013, Haojian Zhuang wrote:
> If CONFIG_CLKSRC_OF is depend on CONFIG_USEOF, I think that
> we can resolve all these issue. We don't need to define
> CLOCKSOURCE_OF_DECLARE() for non-DT mode, and we also
> don't need to define of_device_is_available(), ... in non-DT mode.
> 
> We only need to add "depends on USE_OF" for CLKSRC_OF
> configuration. It's simpler. What's your opinion?
> 

I think that is not the right symbol. USE_OF is an ARM specific symbol
that should not get selected from common code. Also I think 'depends on'
is much better than 'select', because it has fewer side-effects.

Right now, CLKSRC_OF is only selected by platforms that also select USE_OF
on ARM, which seems appropriate for now, but if we want to make
CLKSRC_OF a generally visible option, it should use 'depends on OF'.

What I don't understand is how that relates to my comment on your
code. My goal was to support drivers that can contain all the code
needed for CLKSRC_OF without any #ifdef but that still work if CONFIG_OF
and CONFIG_CLKSRC_OF are both disabled.

	Arnd
