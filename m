From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 13 Apr 2012 16:19:18 -0700
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120413102036.GJ24211@n2100.arm.linux.org.uk>
References: <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
 <4F87B443.6090405@st.com>
 <CAAQ0ZWR3-TvFjV3CX5oW+bUN6aW7ip5NphuKycq3twks2RrpMg@mail.gmail.com>
 <20120413085901.GG3168@opensource.wolfsonmicro.com> <4F87ED74.8020308@st.com>
 <20120413091712.GE27730@b20223-02.ap.freescale.net>
 <20120413092615.GH24211@n2100.arm.linux.org.uk>
 <4F87F188.60603@st.com> <20120413093606.GI24211@n2100.arm.linux.org.uk>
 <4F87F9C3.2010802@st.com> <20120413102036.GJ24211@n2100.arm.linux.org.uk>
Message-ID: <CAJOA=zOaZ7gsM=uJ2ik3x6cathsizfRiGUmQbsruyqzXeDqQLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 3:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 13, 2012 at 03:32:43PM +0530, Viresh Kumar wrote:
>> On 4/13/2012 3:06 PM, Russell King - ARM Linux wrote:
>> > You're not convincing me that you're approach here is correct, and
>>
>> :(
>>
>> > I really doubt that this will have any effect at saving lines of code -
>> > your argument list is soo long that you'll have to wrap it onto several
>> > lines.
>>
>> There are two ways here:
>> 1. Leave clk_register() untouched and create lookups in machine code.
>> 2. change clk_register():
>> ? ? ? A. pass all arguments as i mentioned in my patch
>> ? ? ? B. pass structure instead of all so many args.
>>
>> Option 2 will have much lesser code than option 1, with both option A & B.
>> In option 2.A.: we can create separate registration routines to save extra
>> arguments passed, like:
>>
>> ?struct clk *clk_register_gate(struct device *dev, const char *name,
>> ? ? ? ? ? ? ? const char *parent_name, unsigned long flags,
>> ? ? ? ? ? ? ? void __iomem *reg, u8 bit_idx,
>> ? ? ? ? ? ? ? u8 clk_gate_flags, spinlock_t *lock, struct clk_lookup **cl,
>> ? ? ? ? ? ? ? const char *dev_id, const char *con_id);
>
> So you're going to have something around 4-5 lines of arguments per
> function call to use this function. ?That's not elegant, that's not
> easy to use, that's not nice. ?And I doubt that it really solves any
> code space concern because the compiler will have to store pointers
> and values somewhere, and shuffle those into registers and onto the
> stack for every function call using additional code to do that.
>
> I really don't get why you think this is an improvement.

My hope is that forthcoming struct clk_hw/static initializer patch
will reduce the number of arguments to clk_register considerably.
These interfaces are not frozen and everyone concerned with using the
common framework is still figuring out exactly how this stuff should
look.

http://article.gmane.org/gmane.linux.ports.arm.msm/2587

Regards,
Mike
