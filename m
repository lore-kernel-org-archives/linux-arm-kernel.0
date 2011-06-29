From: wolfgang.betz@st.com (Wolfgang BETZ)
Date: Wed, 29 Jun 2011 15:05:42 +0200
Subject: [PATCH 1/1] Add Thread Support for the Context ID Register of
	ARM v6 & v7 Architectures
In-Reply-To: <20110628090004.GA16009@e102144-lin.cambridge.arm.com>
References: <cover.1309163073.git.wolfgang.betz@st.com>
	<3a6d2636489958d097cd013cad646fed012421dd.1309163073.git.wolfgang.betz@st.com>
	<20110627113707.GD16103@n2100.arm.linux.org.uk>
	<20110628090004.GA16009@e102144-lin.cambridge.arm.com>
Message-ID: <4E0B2326.8090808@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ciao Will,

thanks a lot for your statement regarding the ASID overflow issue.
In fact, we have never even tried to resolve this issue, not only 
because most likely there is no perfect solution to it in current 
implementations (i.e. v6 & v7 architectures), but also because it was 
out of our scope.
In STMicroelectronics we are simply customers of Lauterbach's TRACE32 
tool and are very interested in getting an as precise as possible 
insight in what goes on in our systems when running Linux based 
environments, with a particular focus on SMP. Together with Lauterbach 
we are currently working on improving their tool with respect to SMP in 
general and the tracing of context switches in particular. One result of 
this collaboration is the patch I have submitted to the ARM kernel 
mailing list this Monday.
Again, we do not aim in improving the handling of ASIDs, but are just 
caring about getting also the current process ID out of the trace logic. 
As the way to achieve this is not platform-specific, we thought it might 
be a good idea to implement it as an architectural feature and provide 
it through a kernel configuration variable (THREAD_CONTEXTID) for any 
platform supporting the CONTEXTIDR.
Furthermore, we thought it would be a good thing to mainline this 
modification and provide it to the open-source community. I do not know 
if you had the time to take a closer look to our patch, but for sure 
your feedback would be more than welcome.

Best regards,
Wolfgang


On 06/28/2011 11:00 AM, Will Deacon wrote:
> Hi Russell,
>
> On Mon, Jun 27, 2011 at 12:37:08PM +0100, Russell King - ARM Linux wrote:
>> On Mon, Jun 27, 2011 at 01:12:27PM +0200, Wolfgang BETZ wrote:
>>> The aim of this patch is to enable thread support in the context ID register
>>> (CONTEXTIDR) as it comes with ARM architectures v6&  v7.
>>>
>>>   On ARMv6&  v7, we have the following structure in the context ID:
>>>
>>>     31                         7          0
>>>     +-------------------------+-----------+
>>>     |      process ID         |   ASID    |
>>>     +-------------------------+-----------+
>>>     |              context ID             |
>>>     +-------------------------------------+
>>>
>>> - The ASID is used to tag entries in the CPU caches and TLBs.
>>> - The context ID is used by debuggers and trace logic, and
>>>    should be unique within all running processes.
>> When I added ARMv6 and v7 support to the kernel, I purposely ignored that
>> detail because it's silly.
> [...]
>
>> How are you working around this issue?
> I don't know how you could get around this with current implementations, but
> for Cortex-A15 w/ LPAE the ASID lives in the TTBR rather than the context
> ID register, so using the PID is straightforward in that case.
>
> Will
>
