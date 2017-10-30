From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Oct 2017 10:19:40 +0000
Subject: [PATCH v2 2/3] mailbox: Add support for Hi3660 mailbox
In-Reply-To: <20171030044506.GE31478@leoy-ThinkPad-T440>
References: <1509084904-2505-1-git-send-email-zhongkaihua@huawei.com>
 <1509084904-2505-3-git-send-email-zhongkaihua@huawei.com>
 <20171027104559.em5n5ogro46ethmq@salmiak>
 <20171030044506.GE31478@leoy-ThinkPad-T440>
Message-ID: <20171030101940.dtf6rw7alhkn6irf@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 30, 2017 at 12:45:06PM +0800, Leo Yan wrote:
> On Fri, Oct 27, 2017 at 11:46:00AM +0100, Mark Rutland wrote:
> > On Fri, Oct 27, 2017 at 02:15:03PM +0800, Kaihua Zhong wrote:
> > > +static int hi3660_mbox_check_state(struct mbox_chan *chan)
> > > +{

> > > +	/* Ensure channel is released */
> > > +	writel_relaxed(0xffffffff, base + MBOX_IMASK_REG);
> > > +	writel_relaxed(BIT(mdev->ack_irq), base + MBOX_SRC_REG);
> > > +	__asm__ volatile ("sev");
> > > +	return 0;
> > > +}
> > 
> > Drivers really shouldn't be using SEV directly (even if via the
> > sev() macro)...
> > 
> > This SEV isn't ordered w.r.t. anything, and it's unclear what
> > ordering you need, so this simply does not work.
> 
> I will leave your questions for Hisilicon colleagues, essentially your
> questions are related with mailbox mechanism.
> 
> But I'd like to firstly get clear your question for "This SEV isn't
> ordered w.r.t. anything". From my understanding, ARMv8 architecture
> natually adds DMB before SEV so all previous register writing
> opreations should be ensured to endpoint before SEV?

This is not the case; SEV does not add any implicit memory barrier, and
is not ordered w.r.t. memory accesses.

See ARM DDI 0487B.b, page D1-1905, "The Send Event instructions":

    The PE is not required to guarantee the ordering of this event with
    respect to the completion of memory accesses by instructions before
    the SEV instruction. Therefore, ARM recommends that software
    includes a DSB instruction before any SEV instruction.

Note that a DMB is not sufficient, as SEV is not a memory access.

Thanks,
Mark.
