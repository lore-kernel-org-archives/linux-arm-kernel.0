From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Dec 2011 12:47:40 +0000
Subject: [PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111228124054.GB1691@richard-laptop>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
 <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
 <20111228031409.GL15863@b20223-02.ap.freescale.net>
 <20111228033128.GM15863@b20223-02.ap.freescale.net>
 <20111228114237.GF24405@opensource.wolfsonmicro.com>
 <20111228120517.GA1691@richard-laptop>
 <20111228121403.GI24405@opensource.wolfsonmicro.com>
 <20111228124054.GB1691@richard-laptop>
Message-ID: <20111228124739.GK24405@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 08:40:56PM +0800, Richard Zhao wrote:
> On Wed, Dec 28, 2011 at 12:14:04PM +0000, Mark Brown wrote:
> > On Wed, Dec 28, 2011 at 08:05:20PM +0800, Richard Zhao wrote:
> > 
> > Looks like the problem with your mail client is that it's wrapping at
> > exactly 80 characters which is too little - you need to leave space for
> > being quoted.

> I'm using vim. any suggestion for auto-wrapping?

:set tw=72

It'd also be useful to leave blank lines

> > > > You can't usefully work with voltages without knowing what the actual
> > > > voltages are 

> if people don't enable REGULATOR, the stubs (if you mean the dummy func)
> are only be used to pass build. The code is optimized out by compiler.

No, this is not the case.  All the functions have return values which
still need to be handled gracefully by drivers using those functions.

> > - the only sensible stubs we could provide would return
> > > > errors but then any driver using the stubs would probably fail to do
> > > > whatever it was doing. 

> In this case, If regulator_get return NULL, I won't call other regulator
> functions at runtime.

That should be OK for your use case but it might not be sensible for
other cases.  Any stubs for this provided by the core need to work well
for any user.

> > >  - I saw linux/regulator/consumer.h has some dummy functions if !REGULATOR. I
> > >    tried to make clk-reg-cpufreq driver work even !REGULATOR. I think that's
> > >    why the dummy functions are there. If regulator_get return NULL, it'll avoid
> > >    calling other regulator functions. But regulator_is_supported_voltage and
> > >    regulator_set_voltage_time don't have such dummy ones. Undefined functions.

> > I can only repeat what I wrote above explaining why no stubs are
> > provided.

> One word. You mean I have to always depends on REGULATOR config, right?

Yes.
