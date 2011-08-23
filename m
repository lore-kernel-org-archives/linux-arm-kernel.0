From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Aug 2011 22:12:55 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.57876.785018.498967@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
	<20051.57876.785018.498967@mariner.uk.xensource.com>
Message-ID: <CAHkRjk5os4-ZBazTwtntY4aL6zBDwtbiB_u+tYCFRNBtqG8xQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 August 2011 18:23, Ian Jackson <Ian.Jackson@eu.citrix.com> wrote:
> Catalin Marinas writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
>> We had some discussions both with ARM partners and Christoffer and it
>> is not clear how we go about initialising the Hyp mode. Most SoC
>> vendors would probably just run Linux in non-secure SVC mode and would
>> not touch the Hyp mode at all. Linux would issue an SMC to set the
>> HVBAR (could do HVC but I expect that there is no secure monitor
>> code). Once this is set, assuming that the Hyp MMU is disabled, Linux
>> can invoke an HVC and initialise the Hyp mode.
>
> Well, yes. ?Do SoC vendors all expect to own the secure state ?

Maybe some parts of it, that's why it's hard to standardise some kind
of API. Since the platform boots in secure mode, they need at least
some code which they own, in addition to other stuff like secure
transactions.

> If so then the answer is perhaps simply that they should boot Linux in
> Hyp mode (and expect Linux to drop to ordinary svc mode).

That would be a solution as it is relatively simple for Linux to check
the mode and switch to SVC. The issue I see is that Linux is not the
first non-secure code to run but you usually get some boot loader like
U-Boot. You would have to make the latter aware of the Hyp mode as
well and many SoC vendors may not be willing to put the effort in (we
can help by providing boot loader fixes but the boot loader may not
always be open source).

(I may get back online towards the weekend)

-- 
Catalin
