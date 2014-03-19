From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 19 Mar 2014 13:18:52 +0200
Subject: [linux-next][regression] [PATCH] percpu: add preemption checks
 to __this_cpu ops
In-Reply-To: <20140318143759.04a892434d84a9fd3aa94262@linux-foundation.org>
References: <53285FE7.5010203@ti.com>	<alpine.DEB.2.10.1403180922050.17965@nuc>	<53286ABF.3040408@ti.com>	<alpine.DEB.2.10.1403181053110.23935@nuc>
 <20140318143759.04a892434d84a9fd3aa94262@linux-foundation.org>
Message-ID: <53297D1C.3000100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2014 11:37 PM, Andrew Morton wrote:> On Tue, 18 Mar 2014 10:54:06 -0500 (CDT) Christoph Lameter <cl@linux.com> wrote:
> 
>> On Tue, 18 Mar 2014, Grygorii Strashko wrote:
>>
>>> Any way, I can boot and console works fine with your change :)
>>> Thanks.
>>
>> Ok here is the properly formatted patch:
>>
>>
>> Subject: preemption_checks: Avoid snprintf before checking error conditions
>>
>> snprintf can cause hangs.
> 
> This is weird.  How the heck can snprintf() fail if called too early?
> All it does is shuffle chars around in memory.  The only external
> dependency I'm seeing is a WARN_ON() which presumably didn't trigger
> anyway.
> 
> I'm suspecting a misdiagnosis here.  Otherwise, we seriously need to
> fix snprintf(), not work around it!

Not sure I can run debugger fast :(, but I'll try.

> 
> Also, what does "before checking error conditions" refer to?  Does this
> mean you know why snprintf() failed??

Just an assumption, May be the problem here not in snprintf, but in stack.
Looks like if I reduce stack usage the issue is gone:
char text[10];

> 
>> Move the string processing into the function
>> so that the string operations only occur when necessary after the
>> conditions have been checked.
>>
>> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Grygorii, thanks for testing linux-next on unusual machines - it's most
> helpful.
> 

Regards,
-grygorii
