From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jul 2014 15:48:42 +0200
Subject: [PATCH 1/8] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <CAJe_Zhc91g1=CTJUBaFaqk9Np4u4oEqddZEx_zeVxn7EdMEjmw@mail.gmail.com>
References: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
 <5755738.IRCDfO2QJn@wuerfel>
 <CAJe_Zhc91g1=CTJUBaFaqk9Np4u4oEqddZEx_zeVxn7EdMEjmw@mail.gmail.com>
Message-ID: <13950816.fBdtyDiPqD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 July 2014 19:02:53 Jassi Brar wrote:
> On 16 July 2014 01:39, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 15 July 2014 23:07:58 Jassi Brar wrote:
> 
> >> >> diff --git a/arch/arm/mach-mb86s7x/Kconfig b/arch/arm/mach-mb86s7x/Kconfig
> >> >> new file mode 100644
> >> >> index 0000000..44f5b0c
> >> >> --- /dev/null
> >> >> +++ b/arch/arm/mach-mb86s7x/Kconfig
> >> >> @@ -0,0 +1,18 @@
> >> >> +config ARCH_MB86S7X
> >> >> +     bool "Fujitsu MB86S7x platforms" if (ARCH_MULTI_V7 && ARM_LPAE)
> >> >> +     select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
> >> >
> >> > Why the LPAE dependency? Is none of the RAM reachable by regular
> >> > kernels?
> >> >
> >> Some devices like PCI, LLI need it and the S70-evb has half of its ram
> >> above 4GB.
> >> Maybe ARM_LPAE should be selected by inclusion of support for those?
> >
> > No, you can't select ARM_LPAE because that would break machines that
> > do not support it in the same configuration.
> >
> To be clear, I meant selecting LPAE from config options specific to
> S70-evb and PCI on S7x.

I understood that.

> > Losing half the RAM or PCI should not be a problem, you'd just run
> > with reduced functionality. You wouldn't want to do that in practice,
> > but it's different from a hard dependency.
> >
> Sorry I am not sure what you mean. Is it ok as such?

What I mean is that it should be ok to drop the dependency, but you
can't add a 'select ARM_LPAE'. The memory should be handled correctly
already (you will just not see the upper 2GB), while the PCI host
driver should probably be checked for its error handling so it
prints a meaningful error message when it can't reach its MMIO space.


> >> >> +static void got_data(u32 code)
> >> >> +{
> >> >> +     struct completion *c = NULL;
> >> >> +     mhu_handler_t hndlr = NULL;
> >> >> +     unsigned long flags;
> >> >> +     int ev;
> >> >> +
> >> >> +     if (code & RESP_BIT)
> >> >> +             ev = EV_RR;
> >> >> +     else
> >> >> +             ev = EV_RC;
> >> >> +
> >> >> +     spin_lock_irqsave(&fsm_lock, flags);
> >> >> +
> >> >> +     if (mhu_fsm[fsm_state][ev] == MHU_INVLD) {
> >> >> +             spin_unlock_irqrestore(&fsm_lock, flags);
> >> >> +             pr_err("State-%d EV-%d FSM Broken!\n", fsm_state, ev);
> >> >> +             return;
> >> >> +     }
> >> >> +     fsm_state = mhu_fsm[fsm_state][ev];
> >> >> +
> >> >> +     if (code & RESP_BIT) {
> >> >> +             c = ax->c;
> >> >> +             memcpy_fromio(ax->buf, rsp_from_scb, ax->len);
> >> >> +             list_move(&ax->node, &free_xfers);
> >> >> +             ax = NULL;
> >> >> +     } else {
> >> >> +             /* Find and dispatch relevant registered handler */
> >> >> +             if (code < MHU_NUM_CMDS)
> >> >> +                     hndlr = handler[code];
> >> >> +             if (!hndlr)
> >> >> +                     pr_err("No handler for CMD_%u\n", code);
> >> >> +     }
> >> >> +
> >> >> +     spin_unlock_irqrestore(&fsm_lock, flags);
> >> >> +
> >> >> +     if (hndlr)
> >> >> +             hndlr(code, cmd_from_scb);
> >> >> +     if (c)
> >> >> +             complete(c);
> >> >> +}
> >> >> +
> >> >> +static void mhu_recv(struct mbox_client *cl, void *data)
> >> >> +{
> >> >> +     got_data((u32)data);
> >> >> +     schedule_work(&scb_work);
> >> >> +}
> >> >
> >> > Why the cast between integer and pointer?
> >> >
> >> The common mailbox framework passes around pointers to data packets.
> >> Its completely between controller and client drivers to decide the
> >> format of the packet. In my case the packet is a simple u32 value.
> >
> > I don't think the mailbox framework should allow that much
> > flexibility, because that would break portable drivers that
> > rely on a particular behavior from the mailbox provider.
> >
> > I understand that your driver is not portable to another mailbox
> > provider, but it still seems like a mistake in the API that should
> > better be fixed sooner than later.
> >
> Here is what I remember of many discussions on the point over the last year :)
> o  We want to support zero-copy receives, which implies the mailbox
> framework must simply forward the pointer to "data packet" from
> controller to client driver.
> o  We could not think of a generic enough structure for 'data packet'
> that could fit all protocols. So we assume the data packet format is
> an explicit understanding between the controller(+remote) and the
> client driver.
> 
> Or did I miss your point?

Forwarding a pointer is ok, but then I think you should not overload
the 'void *data' argument. In the case above, you don't actually use
a pointer at all, but instead you use a 'code' that is taken as
an index into an array or a flag.

This is particularly broken when you think about 64-bit machines
on which you cannot cast a pointer to an u32.

What I think you should do is define your own data type for the
mailbox, which would be specific to your mailbox client and change
the code above to

struct mhu_mbox_message {
	u32 code; /* another client could store a pointer here */
};

static void mhu_recv(struct mbox_client *cl, void *data)
{
	struct mhu_mbox_message *msg = data;

	got_data(msg->code);
	schedule_work(&scp_work);
}

You get the cost of another register load here, but that should
be almost free.

There should probably also be some way to ensure that the amount
of data passed in the structure matches between mbox provider
and client.

> >> >> +                     do {
> >> >> +retry:
> >> >> +                             /* Wait until we get reply */
> >> >> +                             count = 0x1000000;
> >> >> +                             do {
> >> >> +                                     cpu_relax();
> >> >> +                                     val = readl_relaxed(
> >> >> +                                             rx_reg + INTR_STAT_OFS);
> >> >> +                             } while (--count && !val);
> >> >> +
> >> >> +                             if (!val) {
> >> >> +                                     pr_err("%s:%d SCB didn't reply\n",
> >> >> +                                            __func__, __LINE__);
> >> >> +                                     goto retry;
> >> >
> >> > It seems like this loop is unbounded and will just print an error every
> >> > 16M loops but never give up or re-enable interrupts if called with
> >> > interrupts disabled.
> >> >
> >> > It should probably be changed to either enforce being called with interrupts
> >> > enabled so you can call msleep() inbetween, or you should add error-handling
> >> > in case the remote side does not reply.
> >> >
> >> We can do that for completeness but otherwise my platform is as good
> >> as dead if the remote doesn't reply for some reason. And there is no
> >> fool-proof way to recover the state-machine from a failed
> >> communication.
> >
> > Do you know how long it takes normally? If you can prove that the
> > reply normally comes within a few microseconds, you can instead call
> > WARN_ON() once after too much time passes, and then continue polling.
> >
> > The case to avoid here is just accidentally polling for multiple
> > milliseconds with interrupts disabled, which would cause a lot of
> > problems.
> >
> From a few hundred micro-sec for CPU reset, to potentially tens of
> milli-sec for some I2C transaction ... yes we do have for I2C over
> mailbox! ;)
> 
> Probably bailing out of the loop and returning -ETIMEOUT to the
> caller, before a WARN(), is the simplest way to die.

If you can have multiple miliseconds here, I think the code should
be changed to run in non-atomic context and use msleep(1) or
usleep_range() as a back-off. Is that possible?

> >> >> +struct mb86s7x_peri_clk {
> >> >> +     u32 payload_size;
> >> >> +     u32 cntrlr;
> >> >> +     u32 domain;
> >> >> +     u32 port;
> >> >> +     u32 en;
> >> >> +     u64 freqency;
> >> >> +} __packed;
> >> >
> >> > Just mark the last member by itself __packed. I assume you didn't
> >> > actually mean to change the alignment of the data structure to one
> >> > byte, but just want to say that the last one is misaligned.
> >> >
> >> This and others, are data packets that are passed between local and
> >> remote via SharedMemory. __packed is only meant to specify that these
> >> data structures have no holes in them.
> >
> > That would be '__packed __attribute__((aligned(4)))'. A struct of 'u32'
> > already has no padding on any architecture that is supported by Linux.
> > The only reason you need the packing here is because the u64 member is
> > unaligned. Note that marking the entire structure as packed means that
> > accesses are no longer atomic because the compiler may prefer to do them
> > one byte at a time, which can break the protocol on the shared memory
> > area.
> >
> We are not worried about the atomic access because the side sending
> the data doesn't touch it until the other side indicates it has
> consumed it.

It's still wrong though ;-)
	Arnd
