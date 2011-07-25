From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 11:33:23 +0100
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <4E2D418D.4000800@st.com>
References: <cover.1310544641.git.wolfgang.betz@st.com>
	<a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
	<20110714100254.GA20903@e102144-lin.cambridge.arm.com>
	<4E1ECDD4.1020800@st.com>
	<20110714113625.GB20903@e102144-lin.cambridge.arm.com>
	<4E241E60.7040403@st.com>
	<20110718125719.GA7410@e102144-lin.cambridge.arm.com>
	<20110719102317.GC26574@n2100.arm.linux.org.uk>
	<4E2D418D.4000800@st.com>
Message-ID: <20110725103323.GE9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 12:12:29PM +0200, Wolfgang BETZ wrote:
> Hi Russell,
> 
> On 07/19/2011 12:23 PM, Russell King - ARM Linux wrote:
> 
> 
> One of the reasons that there'll be a struggle is the abuse that's in the
> patch.
> 
> If Wolfgang wants to pass something into a function which isn't already
> being passed, then the prototype needs to be changed - and all
> implementations and users need to be fixed up for that change.  Fudging
> it with casts to an existing arguments type so something else can be
> passed is just not on.
> 
> How does Wolfgang know that he's fixed up everywhere which calls
> cpu_switch_mm() to ensure that it now passes the context ID value in r1
> rather than the struct mm_struct pointer?  Or more to the point, how do
> we know that there isn't a new call to cpu_switch_mm() which hasn't been
> fixed up.  There is no way for the compiler to tell us because the
> information is hidden from the compiler by those casts.
> 
> Please note, that only for ARM v6 and v7 the context ID value will be passed in r1 at the place of the struct mm_struct pointer. For other platforms/architecture nothing has changed!
> So the compiler will (continue to) throw out a warning, in case you pass something else which is not a pointer to mm_struct.
> 
> 
> 
> 
> C is a typed language for a reason.  Don't destroy it with casts.
> 
> So, the _minimum_ that needs to change in this patch is for those casts
> to go, and cpu_switch_mm() needs to be fixed to take the context ID
> value, rather a context ID value casted to a mm_struct.
> 
> Well, this is exactly what the patch is doing right now.
> I have intentionally avoided to centralize this cast into cpu_switch_mm() in order to be sure to not miss any call to it, accidentally. As said above, the compiler will warn about something like this.
> Maybe you could take a closer look at v3 of the patch, which I will send out within today.

You've completely missed my point.  What's the really scary thing here
is that you can't see that you're doing something very very wrong.

Think about this case:

	static inline struct mm_struct *some_function(struct mm_struct *mm)
	{
		return (struct mm_struct *)mm->context.id;
	}

	cpu_switch_mm(pgd, some_function(mm));

and somewhere else there's another call to:

	cpu_switch_mm(pgd, mm);

You've destroyed the ability of the compiler to spot that error because
of your insistance to use idiotic casts and avoid doing the job properly.
Had you changed the second argument to 'unsigned long' or 'u32' or
something like that - or even added that - the compiler would be able to
spot the calls which hadn't been fixed up.

So, here's what I want you to do:

1. Change the cpu_switch_mm() prototype.
2. Get rid of the madness of sometimes passing a real mm_struct and
   sometimes passing the context ID value depending on configuration.

Here's some examples:

	cpu_switch_mm(pgd, mm);

where mm is a real mm_struct => good.

	cpu_switch_mm(pgd, some_function(mm));

	#ifdef CONFIG_I_WANTING_TO_BE_RANTED_AT
	static inline struct mm_struct *some_function(struct mm_struct *mm)
	{
		return (struct mm_struct *)mm->context.id;
	}
	#else
	static inline struct mm_struct *some_function(struct mm_struct *mm)
	{
		return mm;
	}
	#endif

unacceptable, potentially buggy, violates the principles of C's type
checking etc.

	cpu_switch_mm(pgd, mm, context_id(mm));

better.

	cpu_switch_mm(pgd, context_id(mm));

even better if 'mm' becomes unused by _all_ implementations of
cpu_switch_mm().
