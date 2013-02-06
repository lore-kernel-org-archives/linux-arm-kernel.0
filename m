From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Feb 2013 16:38:11 +0000
Subject: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
In-Reply-To: <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
 <20130206115219.GE17833@n2100.arm.linux.org.uk>
 <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
 <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com>
Message-ID: <20130206163811.GI17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 05:31:24PM +0100, Linus Walleij wrote:
> On Wed, Feb 6, 2013 at 1:31 PM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
> 
> CC Grant on this issue...
> 
> > On 6 February 2013 19:52, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Wed, Feb 06, 2013 at 07:47:14PM +0800, Haojian Zhuang wrote:
> >>> If uart driver is probed defer, console_setup will be called later
> >>> after __init && __initdata sections destroyed. And amba_console isn't
> >>> defined in __init or __initdata section. So we needn't define
> >>> pl011_console_setup() && pl011_console_get_options() in __init section.
> >>
> >> It sounds like there's a deeper problem here - if this driver being
> >> deferred, why isn't it being retried after the pinctrl stuff gets
> >> its driver registered?
> >>
> >> We've had bugs in this deferred probing before, I wouldn't be surprised
> >> if there's more... and we should not be "fixing" drivers because of bugs
> >> elsewhere.
> >
> > It retried if driver is being deferred. But those console setup
> > functions are released
> > since they're declared in __init section.
> >
> > rest_init()
> >    --> creates kernel_init thread that could free __init section memory
> >
> > deferred_probe_initicall() creates a workqueue that is used to retry
> > deferred probe
> > function.
> >
> > I think that these two threads are competing.
> 
> Now that is the *real* problem. The __init sections surely should
> not be discarded until *after* all deferred probes are complete
> and the deferral workqueue terminates.
> 
> How about writing a patch to fix that instead? (If possible...)

Well, we have the facilities to flush workqueues, so it should be possible.

However, I'm just wondering if this shows that we _do_ need to get rid
of a pile of __init marked functions as well as fixing this, thanks to
the deferred probing we now have (maybe the whole __init thing becomes
useless with deferred probing?)  There's nothing really to guarantee
that the pinctrl stuff will be available by the time the init sections
are discarded (it could be in a loadable module?) or indeed any other
resources that might be necessary.

I think in this regard, deferred probing has opened a similar can of
worms which hotplug devices created (which eventually ended up with
killing the __dev* marking).
