From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 23 Aug 2016 10:07:54 +0100
Subject: [PATCH 1/2] arm64: kernel: Add SMC Session ID to results
In-Reply-To: <20160823003831.GN6502@codeaurora.org>
References: <1471672274-19317-1-git-send-email-andy.gross@linaro.org>
 <1471672274-19317-2-git-send-email-andy.gross@linaro.org>
 <20160822134313.GJ14680@arm.com>
 <20160822140246.GA30923@hector.attlocal.net>
 <20160822145326.GK14680@arm.com>
 <20160823003831.GN6502@codeaurora.org>
Message-ID: <20160823090754.GB8724@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 05:38:31PM -0700, Stephen Boyd wrote:
> On 08/22, Will Deacon wrote:
> > On Mon, Aug 22, 2016 at 09:02:46AM -0500, Andy Gross wrote:
> > > On Mon, Aug 22, 2016 at 02:43:14PM +0100, Will Deacon wrote:
> > > > On Sat, Aug 20, 2016 at 12:51:13AM -0500, Andy Gross wrote:
> > > > >  
> > > > >  /**
> > > > >   * arm_smccc_smc() - make SMC calls
> > > > >   * @a0-a7: arguments passed in registers 0 to 7
> > > > > - * @res: result values from registers 0 to 3
> > > > > + * @res: result values from registers 0 to 3 and optional register 6
> > > > 
> > > > AFAICT from reading the SMCCC spec, parameter register 6 is "Unpredictable,
> > > > Scratch registers" in return state, so I don't think this is correct.
> > > > 
> > > > What am I missing?
> > > 
> > > In the case of Qualcomm's implementation, they return a value in register 6 that
> > > may or may not be used in subsequent calls.  If I want to leverage the arm_smccc
> > > functions, then I need to extend them to include the optional return value.  The
> > > downside to this is that everyone who uses this is exposed to it.
> > 
> > Yes, I'm not keen on forcing this behaviour for everybody, as you never
> > know what other firmware might do with unexpected a6 values. Could we
> > perhaps quirk it, along the lines of the completely untested patch below?
> > 
> 
> How would the firmware know about the a6 values? It isn't passed
> to the firmware unless the caller of arm_smccc_smc() uses it. Is
> the concern that we would be exposing x6 as a return register for
> all users of arm_smccc_smc()? Presumably callers of
> arm_smccc_smc() would know if they want to use that extra
> register or not, so doing all the quirk stuff seems like more
> instructions over always saving away x6 on the return path, but
> maybe there's some reasoning I missed.

It is a concern of exposing a return register that is not a
return register according to the SMCCC.

> This all comes about because the firmware generates a session id
> for the SMC call and jams it in x6. The assembly on the
> non-secure side is written with a tight loop around the smc
> instruction so that when the return value indicates
> "interrupted", x6 is kept intact and the non-secure OS can jump
> back to the secure OS without register reloading. Perhaps
> referring to x6 as result value is not correct because it's
> really a session id that's irrelevant once the smc call
> completes.

And by using the quirk we need to reload x6 from the stack anyway
which defeats the purpose of what you want to achieve (if we have
to stash it we can do it in the caller stack and reload it before
re-issuing the SMC without touching the SMCC code at all, am I
missing something here ?).

Lorenzo
