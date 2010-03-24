From: matthltc@us.ibm.com (Matt Helsley)
Date: Tue, 23 Mar 2010 18:53:13 -0700
Subject: [C/R ARM][PATCH 3/3] c/r: ARM implementation of checkpoint/restart
In-Reply-To: <20100323211843.GC19572@n2100.arm.linux.org.uk>
References: <1269219965-23923-1-git-send-email-christofferdall@christofferdall.dk>
	<1269219965-23923-4-git-send-email-christofferdall@christofferdall.dk>
	<20100323211843.GC19572@n2100.arm.linux.org.uk>
Message-ID: <20100324015313.GA5704@count0.beaverton.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 23, 2010 at 09:18:43PM +0000, Russell King - ARM Linux wrote:

<snip> (sorry -- I'm not familiar with ARM so I can't respond to those)

> > +/* dump the thread_struct of a given task */
> > +int checkpoint_thread(struct ckpt_ctx *ctx, struct task_struct *t)
> > +{
> > +	int ret;
> > +	struct ckpt_hdr_thread *h;
> > +	struct thread_info *ti = task_thread_info(t);
> > +
> > +	h = ckpt_hdr_get_type(ctx, sizeof(*h), CKPT_HDR_THREAD);
> > +	if (!h)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Store the syscall information about the checkpointed process
> > +	 * as we need to know if the process was doing a syscall (and which)
> > +	 * during restart.
> > +	 */
> > +	h->syscall = ti->syscall;
> > +
> > +	/*
> > +	 * Store remaining thread-specific info.
> > +	 */
> > +	h->tp_value = ti->tp_value;
> 
> How do you safely obtain consistent information from a thread?  Do you
> temporarily stop it?

It must be frozen with the cgroup freezer (which reuses the suspend freezer).
sys_checkpoint moves the cgroup freezer into the CHECKPOINTING state which
prevents tasks in that group from being thawed until just before checkpoint
returns.

Cheers,
	-Matt Helsley
