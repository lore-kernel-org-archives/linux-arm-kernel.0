From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 7 Jul 2011 10:28:25 +0100
Subject: [PATCH v4] ARM: Use generic BUG() handler
In-Reply-To: <20110706200607.GS8286@n2100.arm.linux.org.uk>
References: <1302822031-6752-1-git-send-email-sjg@chromium.org>
	<4DA7A914.5020804@codeaurora.org>
	<BANLkTikcY-xzjd0W77UfWWoO8ibjKNXQGg@mail.gmail.com>
	<BANLkTin_TpzdQS96SPKUNye6vb2b55Qc4A@mail.gmail.com>
	<143ea9b1bb96e613d534caa7cb3a1e2d.squirrel@www.codeaurora.org>
	<20110426014741.GB28721@quad.lixom.net>
	<BANLkTikHT2E=76jMLbzmQm_CiUw8rA3cCA@mail.gmail.com>
	<20110706200607.GS8286@n2100.arm.linux.org.uk>
Message-ID: <20110707092802.GA2486@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 09:06:07PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 19, 2011 at 10:24:31PM -0700, Simon Glass wrote:
> > On Mon, Apr 25, 2011 at 6:47 PM, Olof Johansson <olof@lixom.net> wrote:
> > > On Wed, Apr 20, 2011 at 11:01:59AM -0700, Stephen Boyd wrote:
> > >
> > >> It's here:
> > >> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6885/1
> > >>
> > >> I imagine it will be added when/if Russell picks it up. Sadly it
> > >> increases the LOC in ARM so Simon might need to really
> > >> sell it to get it merged.
> > >
> > > It's core code though, and the concern today is not with ARM core code
> > > as much as with the various platforms that are growing seemingly without
> > > upper bounds.
> > 
> > Hi,
> > 
> > Can anyone advise please what happens next with this patch? So far I
> > have posted it to the list, it has been reviewed on the list and I
> > have put it into the patch system. What is the next step please to get
> > this into the kernel?
> 
> Sorry, I've finally got back to looking at this.
> 
> +               ".pushsection .rodata.str, \"aMS\", 1\n"        \
> 
> According to my gas manual:
> 
> | 7.88 `.pushsection NAME [, SUBSECTION] [, "FLAGS"[, @TYPE[,ARGUMENTS]]]'
> | ...
> |    This directive pushes the current section (and subsection) onto the
> | top of the section stack, and then replaces the current section and
> | subsection with `name' and `subsection'. The optional `flags', `type'
> | and `arguments' are treated the same as in the `.section' (*note
> | Section::) directive.
> | 
> | 7.94 `.section NAME'
> | ...
> | ELF Version
> | ...
> |    Note on targets where the `@' character is the start of a comment (eg
> | ARM) then another character is used instead.  For example the ARM port
> | uses the `%' character.
> | 
> |    If FLAGS contains the `M' symbol then the TYPE argument must be
> | specified as well as an extra argument--ENTSIZE--like this:
> | 
> |      .section NAME , "FLAGS"M, @TYPE, ENTSIZE
> | 
> |    Sections with the `M' flag but not `S' flag must contain fixed size
> | constants, each ENTSIZE octets long. Sections with both `M' and `S'
> | must contain zero terminated strings where each character is ENTSIZE
> | bytes long. The linker may remove duplicates within sections with the
> | same name, same entity size and same flags.  ENTSIZE must be an
> | absolute expression.
> 
> It appears that the TYPE argument is missing.  As the GAS manual says
> its required, then I think it really ought to be there.  Any comment?

I guess type should be %progbits.  That's what the compiler generates for
the assembler input in similar situations.

Interestingly, gas does not require this argument and seems to default to
progbits anyway ... but it seems best to do what the manual says.

Cheers
---Dave
