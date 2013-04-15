From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Apr 2013 12:59:06 +0100
Subject: [PATCH 3/8] dmaengine: ste_dma40: Actually write the runtime
 configuration to registers
In-Reply-To: <CAH+eYFB2+oMPXsnzQVVrEK8CjKGVYFa_n4Wxr=CpdtJwFfOGYw@mail.gmail.com>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-3-git-send-email-lee.jones@linaro.org>
 <CAH+eYFB_fYmCjvh5PXKRhd-FnaWfeu+LtH+q3VywhCk-PYhHVQ@mail.gmail.com>
 <20130415110601.GE6512@gmail.com>
 <CAH+eYFB2+oMPXsnzQVVrEK8CjKGVYFa_n4Wxr=CpdtJwFfOGYw@mail.gmail.com>
Message-ID: <20130415115906.GF6512@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Apr 2013, Rabin Vincent wrote:

> 2013/4/15 Lee Jones <lee.jones@linaro.org>:
> > On Fri, 12 Apr 2013, Rabin Vincent wrote:
> >> 2013/4/9 Lee Jones <lee.jones@linaro.org>:
> >> > Someone has spent a fair amount of effort writing a runtime configuration
> >> > changing algorithm for DMA clients. However, the config appears to never
> >> > actually make it to hardware. In order for the configuration to take hold
> >> > we need to issue a d40_config_write(), as this is the routine which writes
> >> > it into the hardware's registers.
> >>
> >> No, it's not.  This function is only for initial configuration which
> >> should only be written when the channel is allocated.  In fact, by
> >> calling it here in runtime_config, you are introducing a serious bug:
> >> other logical channels on the same physical channel will stop because of
> >> the SSLNK/SDLNK of the physical channel being zeroed.
> >>
> >> The runtime config already makes it the hardware in the existing code,
> >> via d40_*_cfg().
> >
> > Sorry Rabin, but the only place I can see the config being written is
> > in d40_config_write().
> >
> > Can you paste the line of code in d40_*_cfg() which actually writes
> > the config to hardware please? I don't see it.
> 
> It's not that simple.  There are some pointers passed to d40_*_cfg() and
> that function writes the configuration to the variables those pointers
> point to (d40c->log_def.lcsp1, d40c->src_def_cfg, etc.).  Please read
> the code to see how those variables end up being used later when the
> LLIs are prepared for the HW.

I have read the code, which is why I know that the config only gets
written in d40_config_write(). :)

So the configuration which gets set in the runtime_config routine
doesn't ever make it to hardware - hence this patch.

Unless I'm missing something?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
