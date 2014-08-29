From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 29 Aug 2014 09:47:22 +0100
Subject: [PATCH v5 1/3] ARM: probes: check stack operation when decoding
In-Reply-To: <20140828102406.GH22580@arm.com>
References: <1409144552-12751-1-git-send-email-wangnan0@huawei.com>
 <1409144552-12751-2-git-send-email-wangnan0@huawei.com>
 <53FEFB93.2010009@hitachi.com>
 <20140828102021.GC30401@n2100.arm.linux.org.uk>
 <20140828102406.GH22580@arm.com>
Message-ID: <1409302042.1247.27.camel@computer5.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-08-28 at 11:24 +0100, Will Deacon wrote:
> On Thu, Aug 28, 2014 at 11:20:21AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Aug 28, 2014 at 06:51:15PM +0900, Masami Hiramatsu wrote:
> > > (2014/08/27 22:02), Wang Nan wrote:
> > > > This patch improves arm instruction decoder, allows it check whether an
> > > > instruction is a stack store operation. This information is important
> > > > for kprobe optimization.
> > > > 
> > > > For normal str instruction, this patch add a series of _SP_STACK
> > > > register indicator in the decoder to test the base and offset register
> > > > in ldr <Rt>, [<Rn>, <Rm>] against sp.
> > > > 
> > > > For stm instruction, it check sp register in instruction specific
> > > > decoder.
> > > 
> > > OK, reviewed. but since I'm not so sure about arm32 ISA,
> > > I need help from ARM32 maintainer to ack this.
> > 
> > What you actually need is an ack from the ARM kprobes people who
> > understand this code.  That would be much more meaningful than my
> > ack.  They're already on the Cc list.
> 
> Tixy, can you take a look please?

I'll take an in depth look on Monday as I'm currently on holiday, so for
now just some brief and possibly not well thought out comments...

- If the intent is to not optimise stack push operations, then this
actually excludes the main use of kprobes which I believe is to insert
probes at the start of functions (there's even a specific jprobes API
for that) this is because functions usually start by saving registers on
the stack.

- Crowbarring in special case testing for stack operations looks a bit
inelegant and not a sustainable way of doing this, what about the next
special case we need? However, stack push operations _are_ a general
special cases for instruction emulation so perhaps that's OK, and leads
me to...

- The current 'unoptimised' kprobes implementation allows for pushing on
the stack (see __und_svc and the unused (?) jprobe_return) but this is
just aimed at stm instructions, not things like "str r0, [sp, -imm]!"
that might be used to simultaneously save a register and reserve an
arbitrary amount of stack space. Probing such instructions could lead to
the kprobes code trashing the kernel stack.

-- 
Tixy
