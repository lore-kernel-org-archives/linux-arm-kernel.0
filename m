From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Feb 2016 18:58:32 +0000
Subject: Writes, smp_wmb(), and transitivity?
In-Reply-To: <20160215175825.GA15878@linux.vnet.ibm.com>
References: <20160215175825.GA15878@linux.vnet.ibm.com>
Message-ID: <20160215185832.GQ6298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 09:58:25AM -0800, Paul E. McKenney wrote:
> Hello!

Hi Paul,

> Some architectures provide local transitivity for a chain of threads doing
> writes separated by smp_wmb(), as exemplified by the litmus tests below.
> The pattern is that each thread writes to a its own variable, does an
> smp_wmb(), then writes a different value to the next thread's variable.
> 
> I don't know of a use of this, but if everyone supports it, it might
> be good to mandate it.  Status quo is that smp_wmb() is non-transitive,
> so it currently isn't supported.
> 
> Anyone know of any architectures that do -not- support this?
> 
> Assuming all architectures -do- support this, any arguments -against-
> officially supporting it in Linux?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> Two threads:
> 
> 	int a, b;
> 
> 	void thread0(void)
> 	{
> 		WRITE_ONCE(a, 1);
> 		smp_wmb();
> 		WRITE_ONCE(b, 2);
> 	}
> 
> 	void thread1(void)
> 	{
> 		WRITE_ONCE(b, 1);
> 		smp_wmb();
> 		WRITE_ONCE(a, 2);
> 	}
> 
> 	/* After all threads have completed and the dust has settled... */
> 
> 	BUG_ON(a == 1 && b == 1);

My understanding is that this test, and the generalisation to n threads,
is forbidden on ARM. However, the transitivity of DMB ST (used to
construct smp_wmb()) has been the subject of long debates, because we
allow the following test:


P0:
Wx = 1

P1:
Rx == 1
DMB ST
Wy = 1

P2:
Ry == 1
<addr dep>
Rx == 0


so I'd be uneasy about saying "it's all transitive".

Will
