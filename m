From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Oct 2015 23:54:39 +0200
Subject: Atmel SoCs and the newly added CONFIG_DELAY_DEVICE_PROBES option
In-Reply-To: <CAAObsKBn5DaXT3J9CG6j_f0RxJpo+WQcj-8w5xz_N64OWEYesw@mail.gmail.com>
References: <20151016181129.GA1764@gradator.net>
 <CAAObsKBn5DaXT3J9CG6j_f0RxJpo+WQcj-8w5xz_N64OWEYesw@mail.gmail.com>
Message-ID: <20151016215439.GR3421@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/2015 at 21:29:25 +0200, Tomeu Vizoso wrote :
> On 16 October 2015 at 20:11, Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> > Hi,
> >
> > FYI, to save you a git bisect, the recently added
> > CONFIG_DELAY_DEVICE_PROBES (enabled by default) breaks Atmel SoCs.
> >
> > For a few of quickly noticeable issues:
> > - PM is not working:   at91_pm_sram_init: sram pool unavailable!
> > - Watchdog is not even probed
> > - on -ek boards the wm8904 is not probed either.
> >
> > Disabling CONFIG_DELAY_DEVICE_PROBES fixes all issues.
> >
> > Tomeu, what should I provide to help find out what's happening ?
> 
> Hi Sylvain, I believe I can do some testing via kernelci on those
> boards, latest on monday.
> 

This also probably broke PM on i.mx5 and i.mx6 (and I think socfpga)
boards as they use the sram driver the same way. That is why sram_init
is a postcore_initcall.

> It will probably involve moving some initcalls, and probing more kinds
> of devices on-demand. Sometimes the proper solution is to move code
> from initcalls into proper drivers which can defer their probe if some
> dependency isn't there at that point, but that's likely to be more
> invasive than wanted at this point.
> 

I guess that the PM code will be really difficult to move into drivers
but I'd be happy to see that done on AT91 as this is the only thing left
in mach-at91.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
