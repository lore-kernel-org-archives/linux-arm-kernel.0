From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 21 Jan 2013 10:52:10 +0100
Subject: [PATCH 3/7] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets
 to System Reset Controller (SRC)
In-Reply-To: <CAKGA1bmjKQcX3RzSjbnuYqoJqbzXYGa_Whv7QQkNyAhBDzZWdw@mail.gmail.com>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-4-git-send-email-p.zabel@pengutronix.de>
 <CAKGA1bmjKQcX3RzSjbnuYqoJqbzXYGa_Whv7QQkNyAhBDzZWdw@mail.gmail.com>
Message-ID: <1358761930.2522.54.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

thank you for your comments.

Am Freitag, den 18.01.2013, 13:57 -0600 schrieb Matt Sealey:
> On Wed, Jan 16, 2013 at 10:13 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > The SRC has auto-deasserting reset bits that control reset lines to
> > the GPU, VPU, IPU, and OpenVG IP modules. This patch adds a reset
> > controller that can be controlled by those devices using the
> > reset controller API.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Hi Philipp,
> 
> I'm so glad someone actually sat down and coded this :)
> 
> +
> +static int imx_src_reset(unsigned long sw_reset_idx)
> +{
> 
> Having a name like imx_src_reset seems needlessly generic and
> confusing. Surely we are performing a reset on an SoC unit and not
> having the SRC itself reset, even if it is clearer when we look at the
> argument?

imx_src_reset_module, then? Also, I'll add the struct
reset_controller_dev pointer as an argument next time:

static int imx_src_reset_module(struct reset_controller_dev *rcdev,
                unsigned long sw_reset_idx)

> +       timeout = jiffies + msecs_to_jiffies(1000);
> +       while (readl(src_base + SRC_SCR) & bit) {
> +               if (time_after(jiffies, timeout))
> +                       return -ETIME;
> +               cpu_relax();
> 
> ... I do wonder though, all versions of the very-similar i.MX SRC
> (i.MX51, i.MX53, i.MX6) implementing these bits actually have an
> interrupt (with the same status-bit positions as the reset-enable
> register) which fires when the unit actually resets.
> 
> Rather than poll with a timeout shouldn't we be waiting for the
> interrupt and doing some completion event? It seems a little overly
> involved to me to poll and cpu_relax() when we can just let the kernel
> do whatever it likes while the hardware does the job.
> 
> It is technically impossible for the unit to "never reset" without
> there being something hideously wrong elsewhere (i.e. if you ask the
> VPU to reset, and it never fires the interrupt, you have far, far more
> problems than just a locked VPU), but we actually should have no idea
> without some empirical data (under every scenario at least) how long
> it would actually take so having a timeout seems rather odd. Having a
> timeout of a full second also *seems* to be far too long under the
> same circumstances but I don't think anyone can predict what the real
> values might be.
> 
> I looked at writing this exact same kind of code a long while back
> including support for i.MX51 and i.MX53 as a cleanup for the older
> version of Sascha's IPU driver, and simply never got it nice enough to
> submit upstream (it is currently stuffed away in a huge backup disk
> and I have no idea where the kernel tree is), but the way I handled it
> was something like registering a real interrupt handler in the src
> initialization function and then simply setting the bit and letting
> the completion event do the work. I also did have a timeout for 5000ms
> which basically would still capture any reset oddities - if we passed
> 5 seconds, and the unit did not reset, to start executing WARN_ON or
> something to give the kernel developer (or user) a real indication
> that something is *actually* hideously wrong with their board
> implementation or the stability of their SoC, power rails, heatsink
> etc.. or million other possibilities (any warning is at least better
> than none).
> 
> I could never get the warning code to ever execute except in a
> contrived test scenario (I set a reserved bit and faked that it never
> fired an interrupt) but in my opinion, ANY warning on this kind of
> failure to reset is better than just returning -ETIME to the reset
> consumer and hoping the consumer reports a reasonable error to the
> kernel log - if the SRC fails to reset a unit then this is not an
> error condition so low in seriousness that telling the consumer
> something timed out is adequate (based on the intended and functional
> implementation of the SRC controller itself). As I said, what I
> decided on was that I would return -ETIMEDOUT (the wrong code, but
> bear with me, I was hacking) but before return, pr_err the problem
> unit, and then WARN_ON inside the SRC driver itself, so that
> everything would carry on (no system lockups or panics), but the
> driver was not responsible for reporting the problem and the
> seriousness was implicated in something a little more noticable than a
> single line in a log.
> 
> I understand that waiting on an interrupt or completion event is not
> available infrastructure in the current reset-controller code... but
> maybe it should be a little more advanced than polling implementation
> :D

Yes, maybe the module reset part of the SRC should be implemented as a
proper device driver in drivers/reset. Then we could use the interrupt
functionality and WARN_ON(timeout), as you suggest.

> I am not not-acking the code, and I would be overjoyed for it to go in
> as-is (maybe with a function rename as above), but I would appreciate
> the consideration that a reset-controller with some way of reporting a
> successful reset other than polling is something that might come in
> handy for other people (and i.MX SRC would be a highly desirable use
> case) and at the very least in the case of the i.MX SRC, "this unit
> did not reset after [possibly more than] a whole second of waiting" is
> not encompassed within if (ret) pr_err("unit did not reset") in the
> driver.. nor would this be an immediate and serious indication to the
> driver or end-user.

regards
Philipp
