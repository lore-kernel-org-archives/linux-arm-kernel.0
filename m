From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 20 Aug 2013 07:31:47 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <CABb+yY3B+9ZyLbyTExPdK4ns_Asvzb2n=dGc-He+Qr+gSYaYCA@mail.gmail.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CAGsJ_4w2hOgsOB=ZYmWqm7tM+pL6=UMR1fG++A+rdAReJzFSjw@mail.gmail.com>
 <520CFBDE.4000408@wwwdotorg.org>
 <20130815174307.GA17245@localhost.localdomain>
 <CAGsJ_4yjZQ9a+VAXk-c5DGFpz-SpGrqm=p7zfYq2C=vTCz8X+w@mail.gmail.com>
 <CABb+yY3B+9ZyLbyTExPdK4ns_Asvzb2n=dGc-He+Qr+gSYaYCA@mail.gmail.com>
Message-ID: <CAGsJ_4wn1pL1eqfPeB2qO2DivP_AK+vvM=f7ZkCXMmccHvG9Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/16 Jassi Brar <jassisinghbrar@gmail.com>:
> On Fri, Aug 16, 2013 at 8:09 AM, Barry Song <21cnbao@gmail.com> wrote:
>>>> >>
>>>> >> Isn't that up to the hardware?  Nothing that Linux can do about that.
>>>> >
>>>> > right. but linux need to assign interrupts to right group in GIC
>>>> > hardware. now it doesn't care.
>>>>
>>>> I strongly hope that whatever is the secure OS is setting up these
>>>> routings, and the HW prevents the non-secure OS from modifying them and
>>>> hence never attempts to. Otherwise, the non-secure OS is able to affect
>>>> the functioning of the secure OS, which seems like a bad thing.
>>>
>>> Typically, the master controls are hard-wired for Secure-only access in
>>> hardware: so assigning GIC interrupts to groups is something the secure
>>> OS/firmware has to take care of.
>>>
>>> Of course, if Linux is acting as secure OS, it might have to understand
>>> what controls exist and to do some of that configuration itself.
>>
>> that is just what i want. linux need to realize whether it is running
>> in security or non-security.
>>
> TZ should be seen as two platforms tied together. "DTB" for each mode
> should reflect what's available in that mode (dtb for NS kernel
> shouldn't/can't specify any Secure asset and while that of Secure
> kernel should specify anything that is not accessible from NS mode).
> So ideally there should just be the control passing mechanism (like
> SMC command) to be told to the kernel running in NS mode.

we have implemented a prototype which run linux+linux together based
on TZ on mach-prima2.
in the prototype, we did give two different dtb to security-mode linux
and non-security-mode linux.

>
>> for example, if one irq is assigned to security, even though users
>> want to get it in non-security, linux should make it fail.
>> linux need security/non-security realization in GIC.
>>
> If there is an 'alias' for the secure asset in NS mode, it is better
> to leave it for NS kernel to manage it.
> If some asset is visible in Secure mode only, the NS kernel shouldn't
> be able to simply do an SMC call to have it manipulated. Otherwise we
> leave room for some rooted NS kernel to hack the TrustedOS.
>
> Point of the rant being, perhaps we don't need new kernel
> policies/designs to enforce TZ security. We just need properly
> partitioned h/w and s/w flow control routed from NS via SMC directly
> to SecureApps(not the Secure Kernel).

we don't need to implement a new kernel. we need to refine a few
drivers to have both security and non-security mode(like GIC and L2
cache), and implement high-level IPC for communication in the two
modes and stolen-time realization for scheduler.

all of above don't mean a new kernel, but mean some refine/cleanup,
TZ- based callbacks and middle-level source codes which can be shared
by all ARM SoC.

-barry
