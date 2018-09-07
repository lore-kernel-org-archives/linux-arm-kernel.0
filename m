From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Sep 2018 09:10:27 +0200
Subject: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
In-Reply-To: <b1cb586397a4cd444c33dd83d72fa544@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
 <4035252.QuWadVx7pr@avalon>
 <1569297.pdEFdpi3HS@avalon> <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
 <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com>
 <b1cb586397a4cd444c33dd83d72fa544@agner.ch>
Message-ID: <CACRpkdaUuWUHZgT0b64hMNZm3oy=7rece3H0p5VVe4d8jpFRaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2018 at 10:25 PM Stefan Agner <stefan@agner.ch> wrote:

> Ok, I read a bit up on the history of bridge timing, especially:
> https://www.spinics.net/lists/dri-devel/msg155618.html
>
> IMHO, this got overengineered. For displays we do not need all that
> setup/sample delay timing information, and much longer cables are in
> use. So why is all that needed for bridges?

I also avoided the overhead of creating this abstraction initially.

But after doing it I have this Stockholm syndrome that I start
liking what Laurent told me to do.

> For Linus case, the THS8134(A/B) data sheet I found (revised March 2010)
> clearly states:
> Clock input. A rising edge on CLK latches RPr0-7, GY0-7, BPb0-7.
>
> So we need to drive on negative edge, hence DRM_BUS_FLAG_PIXDATA_NEGEDGE
> should be used, which makes the pl111 driver setting TIM2_IPC:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0121d/index.html

That is easy to say, but if I just set that up in code, even with a good
comment it is hard for the next reader to understand what is going
on. The central question will be, why does PL111 need to do this
but not R-Car though they are using the same bridge?

So this elaborate model gives a better transfer of abstract concepts
to whoever needs to touch that code next. The code is not just
logic, but also our map of the world and the documentation of our
problem space.

Donald Knuth has this idea about literate programming which even
turns the documentation/implementation process around. We are
not there, not even remotely, but IMO the more complex the problem.
the more we need to convey our thinking, not just our solution.

Yours,
Linus Walleij
