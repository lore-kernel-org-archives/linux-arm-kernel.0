From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 9 Jun 2015 22:37:41 +0100
Subject: [PATCH v2 1/3] ARM: STi: Add code to release secondary cores
 from holding pen.
In-Reply-To: <20150609135935.GE7557@n2100.arm.linux.org.uk>
References: <1433856824-30689-1-git-send-email-peter.griffin@linaro.org>
 <1433856824-30689-2-git-send-email-peter.griffin@linaro.org>
 <20150609135935.GE7557@n2100.arm.linux.org.uk>
Message-ID: <20150609213741.GA25965@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, 09 Jun 2015, Russell King - ARM Linux wrote:
> On Tue, Jun 09, 2015 at 02:33:42PM +0100, Peter Griffin wrote:
> > Most upstream devs boot STi platform via JTAG which abuses the
> > boot process by setting the PC of secondary cores directly. As
> > a consquence, booting STi platforms via u-boot results in only
> > the primary core being brought up as the code to manage the
> > holding pen is not upstream.
> 
> Looking at the current mainline code:
> 
> static void sti_secondary_init(unsigned int cpu)
> {
>         trace_hardirqs_off();
> 
> Why is this necessary?

After having a dig around, the comment at the top of the file says
this implementation was originally cloned from arch/arm/mach-vexpress/platsmp.c.

After some googling I can see that you submitted this patch
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/033678.html
which consolidated this call back in December 2010 from the platform specific
secondary startup code into the common SMP code.

At this time, the STi implementation was being maintained 'out of tree', so
although I can't say for certain, I strongly suspect that this could be why
the call is there, and that when this implementation was submitted in 2013
it was missed during the review process.

> If things aren't correctly setup in generic code,
> please report a bug against the generic code rather than working around
> the problem in platform specific code.  This is the Linux kernel, not
> some closed source project.

100% agree. This is a good example of why upstreaming code is a good idea.

> What bug are you seeing which required the addition of that?

None that I'm aware of, however I'm not the original author or submitter of
the code. I just booted several times with this call removed and everything
appears to work OK.

As I suspect it is due to the implementation being 'out of tree' at the time
of your patch, I will submit another patch which removes this call.

regards,

Peter.
