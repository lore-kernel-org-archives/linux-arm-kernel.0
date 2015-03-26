From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 26 Mar 2015 17:55:12 +0100
Subject: [PATCH v3 0/4] clk: st: New always-on clock domain
In-Reply-To: <20150326135144.GI5951@x1>
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
 <20150304120003.GL32624@x1> <20150306190812.11109.82130@quantum>
 <20150309092804.GB3427@x1>
 <CAMuHMdV8_uKQQgYkRPFOBgrqgw_y9A7T84ukfgWZpJmTL0eFCQ@mail.gmail.com>
 <20150326135144.GI5951@x1>
Message-ID: <CAMuHMdVpXCFk9Z68OeVt0924dhR_9vdLYmBkWun1UGY3NJJ4wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, Mar 26, 2015 at 2:51 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 25 Mar 2015, Geert Uytterhoeven wrote:
>> On Mon, Mar 9, 2015 at 10:28 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Fri, 06 Mar 2015, Mike Turquette wrote:
>> >> This approach looks fine to me. In practice I think it is restricted to
>> >> hardware blocks that don't exist in DT yet (e.g. no driver, in the case
>> >> of your interconnect) and that restriction is probably for the best.
>> >
>> > Agreed.
>>
>> I think this restriction should be documented in the DT binding more clearly,
>> as adding a "clk-always-on" node prohibits you from handling the clock
>> correctly in
>> the future.
>
> Would you mind taking the time to explain what you think those
> limitations are?

If you add a "clk-always-on" node, the clock will always on using that DT.
That will still be true later, when you get a better understanding of the
hardware, and might discover you're gonna need a driver for the currently
hidden core component that's driven by the clock, and may want to manage
that clock.

When that happens, you're gonna need a DT update to make use of the
newly introduced driver and the features it provides (e.g. better power
management).

On the other hand, if you would describe the actual hardware topology in DT,
the device node for the future driver would already be there, and no DT update
is needed (assuming you can guess right w.r.t. its bindings; usually these are
transparent buses, for which bindings are fairly generic, cfr. e.g.
"simple-pm-bus").

Until you have (a need for) a real driver, you do need some platform code that
makes sure the clock is enabled. When a real driver is introduced, the
platform code has to be updated, but DT doesn't have to change.

(The same is true for devices where the current driver isn't aware of the
 clock, and shouldn't be, but you still need to enable the clock until the
 driver has Runtime PM support (E.g. ARM GIC on shmobile, cfr.
 https://www.marc.info/?l=linux-pm&m=142670617929493&w=3 (good, now
 we have a bidirectional link between these two threads :-) Using a
 "clk-always-on" property there instead of adding a reference to the clock
 in the existing GIC device node would be just lying.)

If we start seeing many users, perhaps we need a general framework where
the platform code can register a list of clocks that must be enabled (properly,
i.e. using clk_prepare_enable())? But I don't think the list should be put
in DT: DT describes hardware, not behavior.

If you don't care about DT stability, and can afford always updating your DT
with your kernel, the above doesn't apply. I heard during the ELC hallways
chats this is actually the case for you?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
