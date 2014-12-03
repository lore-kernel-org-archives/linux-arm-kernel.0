From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 3 Dec 2014 15:37:39 -0500 (EST)
Subject: [PATCH] optimize ktime_divns for constant divisors
In-Reply-To: <87zjb4zdyc.fsf@free.fr>
References: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
 <87zjb4zdyc.fsf@free.fr>
Message-ID: <alpine.LFD.2.11.1412031525320.470@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Dec 2014, Robert Jarzmik wrote:

> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
> 
> > Let ktime_divns() use do_div() inline whenever the divisor is constant
> > and small enough.  This will make things like ktime_to_us() and 
> > ktime_to_ms() much faster.
> 
> Hi Nicolas,
> 
> I suppose the "small enough" is linked to the "!(div >> 32)" in your patch.  Can
> I have the rationale which brought up this value, and if that value is universal
> across architectures (ie. x86/ppc/arm/...) ?

Yes.  The do_div() function is defined to accept a 32-bit divisor only.  
The out-of-line ktime_divns code does scale down both the dividend and 
the divisor until the divisor is within 32 bits of magnitude before 
calling do_div().  However the constness of the divisor is lost and the 
optimised do_div (on ARM at least) doesn't get involved.

> And when you say "much faster", do you have figures to add to your commit
> message ?

No actual figure.  But a wild guess would be around an order of 
magnitude.  See commit fa4adc6149 for an example of generated code.


Nicolas
