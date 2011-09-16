From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 16 Sep 2011 17:25:07 +0100
Subject: [ltt-dev] LTTng 2.0 on ARM
In-Reply-To: <1316017628.2576.44.camel@linaro1>
References: <4E68559A.8080204@linaro.org>
	<BLU0-SMTP86E263003FB9999131E2A196000@phx.gbl>
	<4E6E4250.2000309@linaro.org>
	<BLU0-SMTP6FB53F86865C7F0175B0D96020@phx.gbl>
	<4E6F3B93.5050603@linaro.org>
	<BLU0-SMTP720ADD6D0D065018E5C97196050@phx.gbl>
	<CAH+eYFDrCav6sVzmapfN3YL8omYKc2NHorHuHMXh49dBbzw1Xg@mail.gmail.com>
	<20110914100931.GB2104@arm.com> <1316017628.2576.44.camel@linaro1>
Message-ID: <20110916162507.GB2100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 05:27:08PM +0100, Jon Medhurst (Tixy) wrote:
> On Wed, 2011-09-14 at 11:09 +0100, Dave Martin wrote:
> > On Tue, Sep 13, 2011 at 11:14:47PM +0530, Rabin Vincent wrote:
> [...]
> > > The problem is that the addresses returned by kallsyms_lookup_name()
> > > does not have the zero bit, which is what is expected for Thumb
> > > functions because the BLX instruction which is used to call them uses
> > > this bit to determines which mode to switch into.  Since it's cleared,
> > > you switch to ARM mode and attempt to execute Thumb-2 code, with obvious
> > > results.
> > > 
> > > A cursory look at the parties involved shows that nm doesn't show the
> > > zero bit (even though it's set in the vmlinux symbol table), and
> > > scripts/kallsyms builds the table by parsing nm's output.
> > 
> > It's not quite as simple as saying "the output of nm is wrong" though...
> > 
> > When getting the address of a function, there are actually two
> > separate answers:
> > 
> >  a) the pointer which can be used to call the function
> > 
> >  b) the address of the start of the function body
> > 
> > On many arches these they are identical, but on some they are different.
> > On ARM, they are identical for ARM code but different for Thumb code
> > (because the Thumb bit must be set in case (a) but not in case (b))
> > 
> > It may be worth looking at what is done in the kernel for ia64 and ppc64.
> > I believe that (a) and (b) are quite different for these because
> > functions are called through descriptors.  Don't quote me on that though:
> > I'm mostly ignorant about these arches.
> > 
> > For the Thumb-2 kernel case, we can probably hack around this: there
> > are various places in the kernel where we just force-set the Thumb bit
> > in addresses without really knowing what the target code is.  We get
> > away with this because the kernel is (very nearly) 100% Thumb code
> > for a Thumb-2 kernel.
> > 
> > However, if the kernel already has a correct approach for solving this
> > problem, we should probably be using it.
> 
> This is the same issue I found recently with kprobes [1]. There is also
> an inconsistency as function symbols in loadable module do have bit zero
> set, but if the module is built-in then bit zero is clear. 

Does that mean that some different infrastructure is used to get the module
symbols compared with kallsyms?  That feels nasty -- they should at least
be consistent...

---Dave
