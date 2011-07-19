From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jul 2011 11:23:17 +0100
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <20110718125719.GA7410@e102144-lin.cambridge.arm.com>
References: <cover.1310544641.git.wolfgang.betz@st.com>
	<a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
	<20110714100254.GA20903@e102144-lin.cambridge.arm.com>
	<4E1ECDD4.1020800@st.com>
	<20110714113625.GB20903@e102144-lin.cambridge.arm.com>
	<4E241E60.7040403@st.com>
	<20110718125719.GA7410@e102144-lin.cambridge.arm.com>
Message-ID: <20110719102317.GC26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 01:57:19PM +0100, Will Deacon wrote:
> I still maintain that you will struggle to get this code past Russell (based
> on his previous comments) so keeping the changes to a minimum is in your
> best interest if you want to convince him to merge it.

One of the reasons that there'll be a struggle is the abuse that's in the
patch.

If Wolfgang wants to pass something into a function which isn't already
being passed, then the prototype needs to be changed - and all
implementations and users need to be fixed up for that change.  Fudging
it with casts to an existing arguments type so something else can be
passed is just not on.

How does Wolfgang know that he's fixed up everywhere which calls
cpu_switch_mm() to ensure that it now passes the context ID value in r1
rather than the struct mm_struct pointer?  Or more to the point, how do
we know that there isn't a new call to cpu_switch_mm() which hasn't been
fixed up.  There is no way for the compiler to tell us because the
information is hidden from the compiler by those casts.

C is a typed language for a reason.  Don't destroy it with casts.

So, the _minimum_ that needs to change in this patch is for those casts
to go, and cpu_switch_mm() needs to be fixed to take the context ID
value, rather a context ID value casted to a mm_struct.  If that results
in the mm_struct argument not being used by any implementation, that
argument can then be removed.
