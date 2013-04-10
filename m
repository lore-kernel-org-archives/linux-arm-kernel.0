From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 10 Apr 2013 12:10:12 +0100
Subject: Anyone implement Cortex A9 FIQ
In-Reply-To: <CAHrpEqR35v76qif0wP=1SNOThLvmzpmEHcbehSNoY7-CO0CRqQ@mail.gmail.com>
References: <CAHrpEqSQ1n_WUfxoraKZFS2A8NjdP_MCcWmJdCjcon_QwgX4Hw@mail.gmail.com>
 <5142FBF5.3010307@arm.com>
 <CAHrpEqSO89Lx=EGTJJ_XOFwkHqL=heoOUQCtJUzm6D7mEAbWiw@mail.gmail.com>
 <514764E2.6040101@arm.com>
 <CAHrpEqT9SSbHYK62i0ZteEd4SfZaa_nw+T0SHunP2W+MUEqmrg@mail.gmail.com>
 <20130408162844.GB2176@linaro.org>
 <CAHrpEqR35v76qif0wP=1SNOThLvmzpmEHcbehSNoY7-CO0CRqQ@mail.gmail.com>
Message-ID: <20130410111012.GA2235@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 01:45:05PM +0800, Frank Li wrote:
> We already implement FIQ in our platform.
> We want to use it simulate a hardware behavior.  

OK.  If FIQ is available to you, then it should be possible to use it,
but you should avoid relying on it in production code if possible.

There is not much code in the kernel using FIQ today.  You could take
a look at soemthing like drivers/spi/spi-s3c24xx.c, for an example
of how to set up an FIQ handler.

How to route an actual hardware interrupt to FIQ is a separate question.
Depending on what is in your hardware, this may require some interrupt
controller configuration in the GIC and/or elsewhere.

I don't think the GIC support in the kernel has any support for doing
this, but I could be wrong.

Cheers
---Dave

> 
> 
> 2013/4/9 Dave Martin <dave.martin@linaro.org>
> 
>     On Tue, Mar 19, 2013 at 03:49:50PM +0800, Frank Li wrote:
>     > >
>     > > Whether this is feasible will really depend on what platform you're on
>     - if
>     > > there's a secure monitor then FIQs are out of the question anyway. Can
>     you
>     > > tell us more about the system?
>     >
>     > Freescale MX6Q.
>     >
>     > >
>     > > If your average interrupt latency is low then you should just be able
>     to do
>     > > this with normal IRQs (have you got threaded interrupt handlers?)
>     >
>     > Not all drivers use threaded interrupt handler.
>     >
>     > >
>     > > What is it about the situation that leads you to believe that you
>     *need*
>     > > FIQ?
>     >
>     > FIQ can be executed even in spin_lock_saveirq.
>     > We want do very small hardware set at related precision period (every
>     125us).
> 
>     Why is the latency requirement so tight for this one interrupt?
> 
>     Cheers
>     ---Dave
> 
> 
