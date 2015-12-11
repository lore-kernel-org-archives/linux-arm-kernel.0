From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 11 Dec 2015 10:27:13 +0000
Subject: [RFC] kprobe'ing conditionally executed instructions
In-Reply-To: <566A5997.9020908@linaro.org>
References: <566A5997.9020908@linaro.org>
Message-ID: <1449829633.2815.27.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-12-11 at 00:05 -0500, David Long wrote:
> There is a moderate amount of code already in kprobes on ARM and the 
> current ARMv8 patch to deal with conditional execution of instructions. 
> One aspect of how this is handled is that instructions that fail their 
> predicate and are not (technically) executed are also not treated as a 
> hit kprobe. Steve Capper has suggested that the probe handling should 
> still take place because we stepped through the instruction even if it 
> was effectively a nop.  This would be a significant change in how it 
> currently works on 32-bit ARM

32-bit ARM uses undefined instructions for kprobe 'breakpoints' and the
ARM ARM says it's implementation defined behaviour whether these
generate exceptions or not, i.e. whether the kprobe handler will be
called. You could say that we could always use unconditional
breakpoints, but this doesn't work with thumb where the instruction
could be in an IT block. So, the only way to have consistent behaviour
on all platforms is to not call kprobe handlers if condition check
fails. Which is the reason for the current implementation's design.

Also, if we change the current implementation as suggested, then looking
at things from a source code point of view...

if (test)
	foo()
else
	bar();

If you put a probe on the call to foo() and the compiler uses a branch
instruction for the test you're never going to hit the probe
fortest==false. But if it decides to use conditional instructions it
will (on some CPU implementations). And the choice between
branch/conditional instructions probably varies between GCC version and
kernel configs.

So again, IMO, the current kprobes implementation leads to consistency.

-- 
Tixy 
