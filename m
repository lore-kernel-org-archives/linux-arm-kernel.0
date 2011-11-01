From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2011 13:01:54 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111101124013.GA15232@mudshark.cambridge.arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031141322.GK19187@n2100.arm.linux.org.uk>
	<20111031143744.GE29349@mudshark.cambridge.arm.com>
	<20111031221513.GB10576@n2100.arm.linux.org.uk>
	<20111101124013.GA15232@mudshark.cambridge.arm.com>
Message-ID: <20111101130154.GO19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2011 at 12:40:13PM +0000, Will Deacon wrote:
> On Mon, Oct 31, 2011 at 10:15:13PM +0000, Russell King - ARM Linux wrote:
> > I've spent the rest of today trying to get it to do another trivial task -
> > adding setup_reboot(mode) to the start of the arch_reset() functions, and
> > failed to get it to place the call after local variable declarations.
> 
> That sounds difficult. What pattern did you use to skip the declarations?

I've tried many different attempts, eventually the one which worked was:

@ rd3 @ identifier m, c, a; type t; @@
void arch_reset(char m, const char *c)
{
 t a;
+setup_restart();
...
}

@ depends on !rd3 @ identifier m, c; @@
void arch_reset(char m, const char *c)
{
+setup_restart();
...
}

> > I really don't like the way I seem to have to create a rule for each
> > possible perturbation of arch_reset (as a function pointer, as a
> > function, with local variables, without local variables.)
> 
> I was wondering if there was a way to avoid it, but I can't figure it out.

Having had a response from Julia this morning, it seems that there's no
way to consolidate the rules down - you have to list them separately.
It sucks still more when you realise that there's three different
perturbations.  (see omap, at91 and everything else.)

I've also ended up with three rules per perturbation as well, so I'm now
at nine rules to do the transformations I want, plus several rules to try
and detect each perturbation (and it still doesn't work.)

> > So far, my experiments with it have just resulted in frustration with
> > virtually zero productivity (just one commit to be precise).
> 
> I guess the tool is good in cases where you're performing a mindless rename,
> but as you pointed out, grep and sed are good for that as well.

I'm not even sure about that.  It doesn't seem to be capable of even the
most trivial transformation a developer might want to make.  For instance,
lets try and delete the argument to setup_mm_for_reboot() because it's
not used:

@@ expression e; @@
 setup_mm_for_reboot(
-e
 )

That does the call sites just fine (great).  However, what about the function
declaration and definition.  You'd have thought that:

@@ expression e; @@
 setup_mm_for_reboot(
-char e
 )

would have done it, but it causes coccinelle to spit out its cryptic and
plain "parse error" without explaining exactly _what_ is wrong with that:

Fatal error: exception Failure("minus: parse error:
 = File "arch_reset-1.5.cocci", line 3, column 6,  charpos = 48
    around = 'e', whole content = -char e
")

For this particular problem I just resorted to grep and a text editor,
which had I done so in the first instance, would've been far quicker than
my fruitless attempts with coccinelle.

Someone said to me yesterday: "The way to use coccinelle is to mail Julia
and describe the problem to her".  My experience so far corroborates that.
