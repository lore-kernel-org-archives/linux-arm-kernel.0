From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 11 Dec 2015 12:13:52 +0000
Subject: [RFC] kprobe'ing conditionally executed instructions
In-Reply-To: <20151211103459.GS8644@n2100.arm.linux.org.uk>
References: <566A5997.9020908@linaro.org> <1449829633.2815.27.camel@linaro.org>
 <20151211103459.GS8644@n2100.arm.linux.org.uk>
Message-ID: <1449836032.2815.39.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-12-11 at 10:34 +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 11, 2015 at 10:27:13AM +0000, Jon Medhurst (Tixy) wrote:
> > On Fri, 2015-12-11 at 00:05 -0500, David Long wrote:
> > > There is a moderate amount of code already in kprobes on ARM and the 
> > > current ARMv8 patch to deal with conditional execution of instructions. 
> > > One aspect of how this is handled is that instructions that fail their 
> > > predicate and are not (technically) executed are also not treated as a 
> > > hit kprobe. Steve Capper has suggested that the probe handling should 
> > > still take place because we stepped through the instruction even if it 
> > > was effectively a nop.  This would be a significant change in how it 
> > > currently works on 32-bit ARM
> > 
> > 32-bit ARM uses undefined instructions for kprobe 'breakpoints' and the
> > ARM ARM says it's implementation defined behaviour whether these
> > generate exceptions or not, i.e. whether the kprobe handler will be
> > called.
> 
> There are two classes of undefined instructions.  There are those which
> fall into the above category, and there are those which are guaranteed
> to raise an exception.  We should always be using the guaranteed ones,
> not the other set.

I wonder if I'm going senile or have been subject to having the ARM ARM
evolve under me. I could swear we used instructions that were defined as
undefined (so to speak) and that conditional versions of undefined
instructions were UNPREDICTABLE. However, checking the ARM ARM again I
see those instruction encodings are for the BKPT instruction which says:

  Breakpoint causes a software breakpoint to occur.
  Breakpoint is always unconditional, even when inside an IT block.

So, my previous statements about not being able to implement the
proposed kprobe changes consistently aren't true.

-- 
Tixy
