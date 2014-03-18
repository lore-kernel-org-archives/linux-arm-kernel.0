From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 18 Mar 2014 14:37:59 -0700
Subject: [linux-next][regression] [PATCH] percpu: add preemption checks
 to __this_cpu ops
In-Reply-To: <alpine.DEB.2.10.1403181053110.23935@nuc>
References: <53285FE7.5010203@ti.com> <alpine.DEB.2.10.1403180922050.17965@nuc>
 <53286ABF.3040408@ti.com> <alpine.DEB.2.10.1403181053110.23935@nuc>
Message-ID: <20140318143759.04a892434d84a9fd3aa94262@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Mar 2014 10:54:06 -0500 (CDT) Christoph Lameter <cl@linux.com> wrote:

> On Tue, 18 Mar 2014, Grygorii Strashko wrote:
> 
> > Any way, I can boot and console works fine with your change :)
> > Thanks.
> 
> Ok here is the properly formatted patch:
> 
> 
> Subject: preemption_checks: Avoid snprintf before checking error conditions
> 
> snprintf can cause hangs.

This is weird.  How the heck can snprintf() fail if called too early? 
All it does is shuffle chars around in memory.  The only external
dependency I'm seeing is a WARN_ON() which presumably didn't trigger
anyway.

I'm suspecting a misdiagnosis here.  Otherwise, we seriously need to
fix snprintf(), not work around it!

Also, what does "before checking error conditions" refer to?  Does this
mean you know why snprintf() failed??

> Move the string processing into the function
> so that the string operations only occur when necessary after the
> conditions have been checked.
> 
> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>

Grygorii, thanks for testing linux-next on unusual machines - it's most
helpful.

> Signed-off-by: Christoph Lameter <cl@linux.com>
