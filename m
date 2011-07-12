From: vishwanath.bs@ti.com (Vishwanath Sripathy)
Date: Tue, 12 Jul 2011 17:21:52 +0530
Subject: Issues using runtime API's with console uart
In-Reply-To: <CAAL8m4yeT9Qm0WFP-7rVH6dMuLd0YHB9zGS4NiHL8thOY4QWFg@mail.gmail.com>
References: <CAAL8m4yeT9Qm0WFP-7rVH6dMuLd0YHB9zGS4NiHL8thOY4QWFg@mail.gmail.com>
Message-ID: <054381c0ba1688bfc51e3ac309a99a6a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+linux_pm.

Vishwa

> -----Original Message-----
> From: Govindraj [mailto:govindraj.ti at gmail.com]
> Sent: Tuesday, July 12, 2011 5:14 PM
> To: linux-omap at vger.kernel.org
> Cc: Kevin Hilman; Paul Walmsley; Basak, Partha; Tony Lindgren;
> Sripathy, Vishwanath; linux-arm-kernel at lists.infradead.org; Rajendra
> Nayak; Shilimkar, Santosh
> Subject: RFC: Issues using runtime API's with console uart
>
> Hi All,
>
> With recent uart runtime conversion I am facing some issues with
> runtime
> API usage with console.
>
> With runtime adaptation the clock cutting is done aggressively with
> get and put.
>
> as below with console_write API in uart code.
>
> serial_omap_console_write(.....)
> {
>       get_sync();
>       .
>       .
>       .
>       put();
> }
>
> serial_omap_set_mctrl(..)
> {
>      get_sync();
>       .
>       .
>       .
>       put()
> }
>
> Now if debug messages(pr_debug) from hwmod and omap_device are
> enabled
> then get_sync and put will internally have prints which get
> redirected to
> console_write and will call get_sync.
>
> so from a runtime API context I call another runtime API which leads
> to power lock contention, since every runtime API entrant tries to
> get
> a power lock.
>
> To elaborate further from above code snippets consider set_mctrl
> calling get_sync and printk from omap_hwmod calling console_write
> which calls get_sync.
>
> -> leads to get_sync calling get_sync.
>
> similarly with put_sync having prints calling console driver calling
> get_sync
> leading to power_lock contention.
>
> As of today I don't see any clean approaches to be available.
>
> Some of the approaches I am considering is
>
> 1.) let the clock gating for uart be handled with idle path as done
> today with
>      prepare and resume calls.
>
> 2.) Aggressively binding all get and put with console lock to
> suppress
>      prints from get/put and to printed during console_unlock.
>
>     uart_port_enb(..)
>     {
>           if (console_trylock()) {
>               get_sync();
>               console_unlock();
>           }
>     }
>
>     Even this approach doesn't seem fool proof, Similarly if I have
> port_disable
>     console unlock(has not yet released the console lock)
>     will have a print stating uart clock is disabled will call
> console_write
>     which will call port_enb since above trylock fails and
> eventually
>     might oops out trying
>     to print the message as put has already disabled the uart
> clocks.
>
>
> I don't see any clean method rather using approach[1] as of today.
>
> So any suggestions on any other approach will be helpful.
>
> ---
> Thanks,
> Govindraj.R
