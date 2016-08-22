From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 22 Aug 2016 09:02:46 -0500
Subject: [PATCH 1/2] arm64: kernel: Add SMC Session ID to results
In-Reply-To: <20160822134313.GJ14680@arm.com>
References: <1471672274-19317-1-git-send-email-andy.gross@linaro.org>
 <1471672274-19317-2-git-send-email-andy.gross@linaro.org>
 <20160822134313.GJ14680@arm.com>
Message-ID: <20160822140246.GA30923@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 02:43:14PM +0100, Will Deacon wrote:
> On Sat, Aug 20, 2016 at 12:51:13AM -0500, Andy Gross wrote:
> > This patch adds the SMC Session ID to the results passed back from SMC
> > calls.  The Qualcomm SMC implementation provides for interrupted SMC
> > functions.  When this occurs, the SMC call will return a session ID that
> > is required to be used when resuming the interrupted SMC call.
> > 
> > Signed-off-by: Andy Gross <andy.gross@linaro.org>
> > ---
> >  arch/arm64/kernel/asm-offsets.c | 1 +
> >  arch/arm64/kernel/smccc-call.S  | 1 +
> >  include/linux/arm-smccc.h       | 4 +++-
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> [...]
> 
> > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > index b5abfda..82d919f 100644
> > --- a/include/linux/arm-smccc.h
> > +++ b/include/linux/arm-smccc.h
> > @@ -63,18 +63,20 @@
> >  /**
> >   * struct arm_smccc_res - Result from SMC/HVC call
> >   * @a0-a3 result values from registers 0 to 3
> > + * @a6 Session ID register (optional)
> >   */
> >  struct arm_smccc_res {
> >  	unsigned long a0;
> >  	unsigned long a1;
> >  	unsigned long a2;
> >  	unsigned long a3;
> > +	unsigned long a6;
> >  };
> >  
> >  /**
> >   * arm_smccc_smc() - make SMC calls
> >   * @a0-a7: arguments passed in registers 0 to 7
> > - * @res: result values from registers 0 to 3
> > + * @res: result values from registers 0 to 3 and optional register 6
> 
> AFAICT from reading the SMCCC spec, parameter register 6 is "Unpredictable,
> Scratch registers" in return state, so I don't think this is correct.
> 
> What am I missing?

In the case of Qualcomm's implementation, they return a value in register 6 that
may or may not be used in subsequent calls.  If I want to leverage the arm_smccc
functions, then I need to extend them to include the optional return value.  The
downside to this is that everyone who uses this is exposed to it.

Regards,

Andy
