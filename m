From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 29 May 2013 11:38:11 -0700
Subject: [PATCH RFC 0/2] clk: add metag specific gate/mux clocks
In-Reply-To: <1368198127-1295-1-git-send-email-james.hogan@imgtec.com>
References: <1368198127-1295-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <20130529183811.6058.78627@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting James Hogan (2013-05-10 08:02:02)
> This adds a metag architecture specific clk-gate and clk-mux which
> extends the generic ones to use global lock2 to protect the register
> fields. It is common with metag to have an RTOS running on a different
> thread or core with access to different bits in the same register (which
> contain clock gate/switch bits for other clocks). Access to such
> registers must be serialised with a global lock such as the one provided
> by the metag architecture port in <asm/global_lock.h>
> 
> RFC because despite extending the generic clocks there's still a bit of
> duplicated code necessary. One alternative is to add special cases to
> the generic clock components for when a global or callback function
> based lock is desired instead of a spinlock, but I wasn't sure if that
> sort of hack would really be appreciated in the generic drivers.
> 
> Comments?
> 

The general approach looks OK, but you've kind of created generic
mux-clock and gate-clock bindings in a metag-specific driver.  I would
prefer to have those functions exist in the generic drivers and your
driver re-use those.  I'll be posting bindings for those clocks by the
end of the week (they're on my github repo now for the curious).

Wrapping the generic clock types is an OK approach and is done by
several other drivers, so there is no problem there.

Regards,
Mike

> James Hogan (2):
>   clk: metag/clk-gate: add metag specific clock gate
>   clk: metag/clk-mux: add metag specific clk-mux
> 
>  .../bindings/clock/img,meta-gate-clock.txt         |  28 +++
>  .../bindings/clock/img,meta-mux-clock.txt          |  33 ++++
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/metag/Makefile                         |   3 +
>  drivers/clk/metag/clk-gate.c                       | 179 +++++++++++++++++
>  drivers/clk/metag/clk-mux.c                        | 211 +++++++++++++++++++++
>  6 files changed, 455 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/img,meta-gate-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/img,meta-mux-clock.txt
>  create mode 100644 drivers/clk/metag/Makefile
>  create mode 100644 drivers/clk/metag/clk-gate.c
>  create mode 100644 drivers/clk/metag/clk-mux.c
> 
> -- 
> 1.8.1.2
