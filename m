From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 23 Nov 2018 11:57:31 +0000
Subject: Sleeping in user_access section
In-Reply-To: <20181123105034.GQ30658@n2100.armlinux.org.uk>
References: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
 <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
 <20181123105034.GQ30658@n2100.armlinux.org.uk>
Message-ID: <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/11/18 10:50, Russell King - ARM Linux wrote:
> On Fri, Nov 23, 2018 at 01:57:12AM -0800, hpa at zytor.com wrote:
>> You should never call a sleeping function from a user_access section.
>> It is intended for very limited regions.
> 
> So, what happens if the "unsafe" user access causes a page fault that
> ends up sleeping?
> 

Thanks for pointing that out.

On the arm64 side, PAN state is saved in spsr and (if PAN feature is 
enabled in SCTLR) PAN bit gets set (disabling the user accesses). For 
software PAN we follow the same behaviour on exception entry. So upon 
exception we implicitly exit user_access mode and then re-enter it when 
returning from the exception.

On x86, the EFLAGS.AC bit is also saved upon exception and I think it is 
cleared upon exception entry so there is implicit exit from the 
user_access mode when taking exception/interrupt.

This however is just how those two architectures happen to behave and 
doesn't seem to be specified as part of the user_access API...

Which is why I'd like to clarify the semantics of user_access region wrt 
sleeping functions.

Thanks,

-- 
Julien Thierry
