From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Oct 2015 14:26:27 -0700
Subject: [GIT PULL] qcom SoC changes for 4.4 *RESEND*
In-Reply-To: <4138617.YyHIgKfeHJ@wuerfel>
References: <1444860627-8258-1-git-send-email-agross@codeaurora.org>
 <6622700.vqj78zoFs4@wuerfel>
 <20151016200417.GC16437@codeaurora.org>
 <4138617.YyHIgKfeHJ@wuerfel>
Message-ID: <20151016212626.GD16437@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16, Arnd Bergmann wrote:
> On Friday 16 October 2015 13:04:17 Stephen Boyd wrote:
> > On 10/16, Arnd Bergmann wrote:
> > > On Friday 16 October 2015 09:56:30 Stephen Boyd wrote:
> > > > 
> > > > Can you share your .config? It looks like there are stubs for these, so
> > > > I'm lost how we got undefined references.
> > > > 
> > > http://pastebin.com/HtrC510p
> > > 
> > > The problem is CONFIG_HWSPINLOCK=m && CONFIG_QCOM_SMEM=y. Sorry for sending
> > > an incomplete patch description, I had not noticed those wrapper functions.
> > > 
> > > My patch fixes the issue, but does not allow you to build QCOM_SMEM without
> > > HWSPINLOCK. If we want that configuration to be valid, we need one of
> > > the two changes below:
> > > 
> > > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > > index eec76141d9b9..cae0ffa19bca 100644
> > > --- a/drivers/soc/qcom/Kconfig
> > > +++ b/drivers/soc/qcom/Kconfig
> > > @@ -22,7 +22,7 @@ config QCOM_PM
> > >  config QCOM_SMEM
> > >  	tristate "Qualcomm Shared Memory Manager (SMEM)"
> > >  	depends on ARCH_QCOM
> > > -	depends on HWSPINLOCK
> > > +	depends on HWSPINLOCK && !HWSPINLOCK
> > 
> > What does this mean?
> 
> This is the magic way in Kconfig to express what we want ;-)
> 
> It says it depends on either HWSPINLOCK being disabled (!HWSPINLOCK),
> or it depends on HWSPINLOCK. The latter implies that QCOM_SMEM cannot
> be built-in when HWSPINLOCK=m, but they are allowed to both be built-in.
> 

I think you mean OR then?

	depends on HWSPINLOCK || !HWSPINLOCK

If I have HWSPINLOCK=y and try menuconfig with your patch, the
smem config isn't selectable. But if HWSPINLOCK=m then the smem
config is visible and smem can only be a module.

> 
> > >  	help
> > >  	  Say y here to enable support for the Qualcomm Shared Memory Manager.
> > >  	  The driver provides an interface to items in a heap shared among all
> > > diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
> > > index 859d673d98c8..cdfd9fd2ba11 100644
> > > --- a/include/linux/hwspinlock.h
> > > +++ b/include/linux/hwspinlock.h
> > > @@ -59,7 +59,7 @@ struct hwspinlock_pdata {
> > >  	int base_id;
> > >  };
> > >  
> > > -#if defined(CONFIG_HWSPINLOCK) || defined(CONFIG_HWSPINLOCK_MODULE)
> > > +#if IS_REACHABLE(CONFIG_HWSPINLOCK)
> > >  
> > >  int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
> > >  		const struct hwspinlock_ops *ops, int base_id, int num_locks);
> > > 
> > 
> > I'd prefer this patch. Is there some way to capture that
> > QCOM_SMEM must be a module if HWSPINLOCK is a module unless we're
> > doing a compile test, in which case we don't care?
> 
> The problem here is that while we avoid the build error, we get the
> counterintuitive behavior that you can have the HWSPINLOCK module
> loaded but the built-in QCOM_SMEM module does not use it because
> it wasn't reachable at compile time.
> 

Agreed, which is why I suggested depends on HWSPINLOCK ||
COMPILE_TEST + the IS_REACHABLE patch. That way if hwspinlock=y,
smem can be y or m, if hwspinlock=m, smem can only be m, and if
hwspinlock=n then smem can only be y or m if it has
COMPILE_TEST=y. In the last case the IS_REACHABLE ifdef will "do
the right thing" and make it so that HWSPINLOCK symbols are
stubbed out if hwspinlock=m and smem=y or hwspinlock=n and
smem=y/m.

I don't think we ever care about a kernel that actually runs when
COMPILE_TEST=y, so this seems to be ok.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
