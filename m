From: johan@kernel.org (Johan Hovold)
Date: Sat, 14 Oct 2017 10:11:24 +0200
Subject: Dramatic lockdep slowdown in 4.14
In-Reply-To: <20171014072659.f2yr6mhm5ha3eou7@gmail.com>
References: <20171013090333.GA17356@localhost>
 <20171014072659.f2yr6mhm5ha3eou7@gmail.com>
Message-ID: <20171014081124.GB16632@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 14, 2017 at 09:26:59AM +0200, Ingo Molnar wrote:
> 
> * Johan Hovold <johan@kernel.org> wrote:
> 
> > Hi,
> > 
> > I had noticed that the BeagleBone Black boot time appeared to have
> > increased significantly with 4.14 and yesterday I finally had time to
> > investigate it.
> > 
> > Boot time (from "Linux version" to login prompt) had in fact doubled
> > since 4.13 where it took 17 seconds (with my current config) compared to
> > the 35 seconds I now see with 4.14-rc4.
> > 
> > I quick bisect pointed to lockdep and specifically the following commit:
> > 
> > 	28a903f63ec0 ("locking/lockdep: Handle non(or multi)-acquisition
> > 	               of a crosslock")
> > 
> > which I've verified is the commit which doubled the boot time (compared
> > to 28a903f63ec0^) (added by lockdep crossrelease series [1]).
> > 
> > I also verified that simply disabling CONFIG_PROVE_LOCKING on 4.14-rc4
> > brought boot time down to about 14 seconds.
> > 
> > Now since it's lockdep I guess this can't really be considered a
> > regression if these changes did improve lockdep correctness, but still,
> > this dramatic slow down essentially forces me to disable PROVE_LOCKING
> > by default on this system.
> > 
> > Is this lockdep slowdown expected and desirable?
> 
> It's not desirable at all.
> 
> Does the patch below fix the regression for you - or does the introduction and 
> handling of ->nr_acquire hurt as well?

> -	select LOCKDEP_CROSSRELEASE
> -	select LOCKDEP_COMPLETIONS
> +#	select LOCKDEP_CROSSRELEASE
> +#	select LOCKDEP_COMPLETIONS

Disabling these options this way gives me a about boot time of 17
seconds again, so yes, that fixes the problem.

Thanks,
Johan
