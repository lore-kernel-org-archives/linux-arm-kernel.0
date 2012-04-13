From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 13 Apr 2012 15:32:43 +0530
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120413093606.GI24211@n2100.arm.linux.org.uk>
References: <20120411094704.GY24211@n2100.arm.linux.org.uk>
 <4F879E9D.2090502@st.com>
 <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
 <4F87B443.6090405@st.com>
 <CAAQ0ZWR3-TvFjV3CX5oW+bUN6aW7ip5NphuKycq3twks2RrpMg@mail.gmail.com>
 <20120413085901.GG3168@opensource.wolfsonmicro.com> <4F87ED74.8020308@st.com>
 <20120413091712.GE27730@b20223-02.ap.freescale.net>
 <20120413092615.GH24211@n2100.arm.linux.org.uk> <4F87F188.60603@st.com>
 <20120413093606.GI24211@n2100.arm.linux.org.uk>
Message-ID: <4F87F9C3.2010802@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2012 3:06 PM, Russell King - ARM Linux wrote:
> You're not convincing me that you're approach here is correct, and

:(

> I really doubt that this will have any effect at saving lines of code -
> your argument list is soo long that you'll have to wrap it onto several
> lines.

There are two ways here:
1. Leave clk_register() untouched and create lookups in machine code.
2. change clk_register():
	A. pass all arguments as i mentioned in my patch
	B. pass structure instead of all so many args.

Option 2 will have much lesser code than option 1, with both option A & B.
In option 2.A.: we can create separate registration routines to save extra
arguments passed, like:

 struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
		u8 clk_gate_flags, spinlock_t *lock, struct clk_lookup **cl,
		const char *dev_id, const char *con_id);

static inline struct clk *clk_register_gate_nolookup(struct device *dev,
		const char *name, const char *parent_name, unsigned long flags,
		void __iomem *reg, u8 bit_idx, u8 clk_gate_flags,
		spinlock_t *lock);

Nodes, that don't need lookup stuff, can go ahead as earlier, just need
to add _nolookup in existing routine name.

-- 
viresh
