From: tixy@yxit.co.uk (Tixy)
Date: Thu, 01 Sep 2011 08:15:46 +0100
Subject: [PATCH 01/10] ARM: kprobes: Add config option for selecting
	the ARM kprobes tests
In-Reply-To: <alpine.LFD.2.00.1108311836240.20358@xanadu.home>
References: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
	<1314621249-958-2-git-send-email-tixy@yxit.co.uk>
	<alpine.LFD.2.00.1108291431300.20358@xanadu.home>
	<1314688610.2371.12.camel@computer2>
	<alpine.LFD.2.00.1108311836240.20358@xanadu.home>
Message-ID: <1314861346.20321.40.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-31 at 18:47 -0400, Nicolas Pitre wrote:
> On Tue, 30 Aug 2011, Tixy wrote:
[...]
> > When ARM_KPROBES_TEST_MODULE is configured for a stand-alone module,
> > rather than built-in, then
> > 
> > #ifdef CONFIG_ARM_KPROBES_TEST_MODULE
> > 
> > is false.
> 
> OK... It seems that, when you have a tristate config symbol FOOBAR, if 
> CONFIG_FOOBAR=y then the CONFIG_FOOBAR preprocessor symbol is defined.  
> If you have CONFIG_FOOBAR=m then the CONFIG_FOOBAR_MODULE preprocessor 
> symbol is defined.

That's useful to know.

> In your example above you would end up with 
> CONFIG_ARM_KPROBES_TEST_MODULE_MODULE being defined.
> 
> > I found other examples where people seemed to have gotten around this 
> > by selecting a second config symbol and copied that. E.g. 
> > FTRACE_STARTUP_TEST selects FTRACE_SELFTEST which is then used in 
> > #ifdef statements.
> > 
> > Is there a better way? If not, I should explain this anyway in the
> > changelog.
> 
> What I'd suggest is that you have:
> 
> config ARM_KPROBES_TEST
> 	tristate ...
> 
> And then you may use this in the code:
> 
> #ifdef CONFIG_ARM_KPROBES_TEST_MODULE
> EXPORT_SYMBOL_GPL(...);
> #endif
> 
> so those symbols are only exported when necessary.

Yep, that works and is a lot cleaner, thanks.

I've also made the extern declarations for these exported symbols
unconditional in kprobes-test.h. It didn't seem worth trying to #ifdef
them to only exist when the test code is configured (like I was trying
to do in "[PATCH 06/10] ARM: kprobes: Add exports for test code").

-- 
Tixy
