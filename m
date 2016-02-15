From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 15 Feb 2016 09:58:25 -0800
Subject: Writes, smp_wmb(), and transitivity?
Message-ID: <20160215175825.GA15878@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Some architectures provide local transitivity for a chain of threads doing
writes separated by smp_wmb(), as exemplified by the litmus tests below.
The pattern is that each thread writes to a its own variable, does an
smp_wmb(), then writes a different value to the next thread's variable.

I don't know of a use of this, but if everyone supports it, it might
be good to mandate it.  Status quo is that smp_wmb() is non-transitive,
so it currently isn't supported.

Anyone know of any architectures that do -not- support this?

Assuming all architectures -do- support this, any arguments -against-
officially supporting it in Linux?

							Thanx, Paul

------------------------------------------------------------------------

Two threads:

	int a, b;

	void thread0(void)
	{
		WRITE_ONCE(a, 1);
		smp_wmb();
		WRITE_ONCE(b, 2);
	}

	void thread1(void)
	{
		WRITE_ONCE(b, 1);
		smp_wmb();
		WRITE_ONCE(a, 2);
	}

	/* After all threads have completed and the dust has settled... */

	BUG_ON(a == 1 && b == 1);

Three threads:

	int a, b, c;

	void thread0(void)
	{
		WRITE_ONCE(a, 1);
		smp_wmb();
		WRITE_ONCE(b, 2);
	}

	void thread1(void)
	{
		WRITE_ONCE(b, 1);
		smp_wmb();
		WRITE_ONCE(c, 2);
	}

	void thread2(void)
	{
		WRITE_ONCE(c, 1);
		smp_wmb();
		WRITE_ONCE(a, 2);
	}

	/* After all threads have completed and the dust has settled... */

	BUG_ON(a == 1 && b == 1 && c == 1);

Four threads:

	int a, b, c, d;

	void thread0(void)
	{
		WRITE_ONCE(a, 1);
		smp_wmb();
		WRITE_ONCE(b, 2);
	}

	void thread1(void)
	{
		WRITE_ONCE(b, 1);
		smp_wmb();
		WRITE_ONCE(c, 2);
	}

	void thread2(void)
	{
		WRITE_ONCE(c, 1);
		smp_wmb();
		WRITE_ONCE(d, 2);
	}

	void thread3(void)
	{
		WRITE_ONCE(d, 1);
		smp_wmb();
		WRITE_ONCE(a, 2);
	}

	/* After all threads have completed and the dust has settled... */

	BUG_ON(a == 1 && b == 1 && c == 1 && d == 1);

And so on...
