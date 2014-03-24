From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 24 Mar 2014 16:49:05 +0000
Subject: [PATCH 1/3] ARM: kprobes: Prevent known test failures stopping
 other tests running
In-Reply-To: <53304CB3.6040409@linaro.org>
References: <1394556894-18592-1-git-send-email-tixy@linaro.org>
 <1394556894-18592-2-git-send-email-tixy@linaro.org>
 <53304CB3.6040409@linaro.org>
Message-ID: <1395679745.3465.41.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-24 at 11:18 -0400, David Long wrote:
> On 03/11/14 12:54, Jon Medhurst wrote:
> > Due to a long-standing issue with Thumb symbol lookup [1] the jprobes
> > tests fail when built into a kernel compiled as Thumb mode. (They work
> > fine for ARM mode kernels or for Thumb when built as a loadable module.)
> >
> > Rather than have this problem terminate testing prematurely lets instead
> > emit an error message and carry on with the main kprobes tests, delaying
> > the final failure report until the end.
> >
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/063026.html
> >
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > ---
> >   arch/arm/kernel/kprobes-test.c |   10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
> > index c2fd06b..6de5e94 100644
> > --- a/arch/arm/kernel/kprobes-test.c
> > +++ b/arch/arm/kernel/kprobes-test.c
> > @@ -225,6 +225,7 @@ static int pre_handler_called;
> >   static int post_handler_called;
> >   static int jprobe_func_called;
> >   static int kretprobe_handler_called;
> > +static int tests_failed;
> >
> >   #define FUNC_ARG1 0x12345678
> >   #define FUNC_ARG2 0xabcdef
> > @@ -461,6 +462,13 @@ static int run_api_tests(long (*func)(long, long))
> >
> >   	pr_info("    jprobe\n");
> >   	ret = test_jprobe(func);
> > +#if defined(CONFIG_THUMB2_KERNEL) && !defined(MODULE)
> > +	if (ret == -EINVAL) {
> > +		pr_err("FAIL: Known longtime bug with jprobe on Thumb kernels\n");
> > +		tests_failed = ret;
> > +		ret = 0;
> > +	}
> > +#endif
> >   	if (ret < 0)
> >   		return ret;
> >
> > @@ -1671,6 +1679,8 @@ static int __init run_all_tests(void)
> >
> >   out:
> >   	if (ret == 0)
> > +		ret = tests_failed;
> > +	if (ret == 0)
> >   		pr_info("Finished kprobe tests OK\n");
> >   	else
> >   		pr_err("kprobe tests failed\n");
> >
[...]
> Because this (correctly) was marked as having no interdependencies it 
> got marked as "applied" in the patch-tracker.  That is why I omitted it 
> from my v7 patches.

Yes, I now see this in Russell's patch tracker (with a less verbose
commit message) as patch 7978, and it's marked as "Applied to git-curr
(uprobes branch)". Perhaps it got dropped along with the rest of the
uprobes branch when the config problems were discovered, Russell?

I have two other kprobes test fixes in this patches series, and was
planning on sending a pull request, or submitting to the patch tracker,
after the merge window has closed, so they can head into 3.16. (I posted
these a bit late for 3.15 and as the bugs they fix have been there since
day one I didn't think it warranted expediting).

-- 
Tixy
