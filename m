From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 12 Mar 2018 13:00:06 -0400 (EDT)
Subject: [PATCH 1/7] ARM: disallow combining XIP and LTO
In-Reply-To: <CAK8P3a128iw+HB5Fp6ZOBCyuK0LypqSXqnkNPQs8sWR1pc8x3g@mail.gmail.com>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20180220215954.4092811-2-arnd@arndb.de>
 <nycvar.YSQ.7.76.1803112233070.28583@knanqh.ubzr>
 <CAK8P3a06_zke6Zy77TCX6aUS1C0aK2btvnLA7APxRykkxS6S_w@mail.gmail.com>
 <CAK8P3a128iw+HB5Fp6ZOBCyuK0LypqSXqnkNPQs8sWR1pc8x3g@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1803121250360.28583@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Mar 2018, Arnd Bergmann wrote:

> On Mon, Mar 12, 2018 at 2:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Mar 12, 2018 at 3:40 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> On Tue, 20 Feb 2018, Arnd Bergmann wrote:
> >
> >>> Obviously we want to make the combination work, no idea why it doesn't.
> >>
> >> Well, it does work regardless of the noise. Here the nm output is piped
> >> into sed, and the later exits early when it finds what it is looking
> >> for, causing nm to complain about the broken pipe.
> >>
> >> Here's a patch silencing this bogus error message and fixing other minor
> >> issues.
> >>
> >> ----- >8
> >> Subject: [PATCH] ARM: deflate_xip_data.sh: minor fixes
> >>
> >> Send nm complaints about broken pipe (when sed exits early) to /dev/null.
> >> All errors should be printed to stderr.
> >> Don't trap on normal exit so the trap can return an error code.
> >>
> >> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> >
> > Ah, that explains it, thanks!
> >
> > Tested-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> Nevermind, I confused it with a different problem that I'm running into
> with randconfig builds:

At least you no longer get the "broken pipe" warning as your initial 
report showed, right?

> arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux':
> No such file

That is weird. The Makefile has:

cmd_mkxip = $(cmd_objcopy) && $(cmd_deflate_xip_data)

$(obj)/xipImage: vmlinux FORCE
        $(call if_changed,mkxip)

So the objcopy must succeed at producing vmlinux for deflate_xip_data 
(where nm is used) to be called.

Do you have a .config for this issue?


Nicolas
