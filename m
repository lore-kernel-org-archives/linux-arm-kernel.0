From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 May 2013 21:30:30 +0200 (CEST)
Subject: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
In-Reply-To: <CACRpkdZCP=w=4Q3bnuMQxm=Oe-uZke+Cc5NgddM5vsQbgr9E-Q@mail.gmail.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022260-2197-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdZCP=w=4Q3bnuMQxm=Oe-uZke+Cc5NgddM5vsQbgr9E-Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1305132114490.2863@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 May 2013, Linus Walleij wrote:
> On Wed, May 8, 2013 at 4:11 PM, Srinivas KANDAGATLA
> > +       clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> > +       clk->set_mode = gt_clockevent_set_mode;
> > +       clk->set_next_event = gt_clockevent_set_next_event;
> > +       this_cpu_clk = __this_cpu_ptr(gt_evt);
> > +       *this_cpu_clk = clk;
> > +       clk->irq = gt_ppi;
> > +       clockevents_config_and_register(clk, gt_clk_rate,
> > +                                       0xf, 0xffffffff);
> 
> Why can't this clock event handle anything lower than 0xf?
> Does that come from the datasheet or have you just copied some
> code?
> 
> Further, since this clock event hardware *most definately* supports
> using a delta upper bound *beyond* 32 bits, I think the clock event
> core code should be altered to allow for registereing such clock
> events, but TGLX may have some idea here. This will work but will
> not expose the full potential of this 64-bit counter hardware.

That requires a full source tree sweep to change all set_next_event
callbacks in one go. Easy to do with coccinelle, but that needs the
proper timing, i.e. right after a -rc1.

Thanks,

	tglx
