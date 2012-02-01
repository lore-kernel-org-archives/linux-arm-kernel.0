From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 1 Feb 2012 12:42:12 +0530
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
In-Reply-To: <alpine.LFD.2.02.1201311315420.2759@xanadu.home>
References: <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
 <4F277A6E.9070107@ti.com>
 <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com>
 <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
 <20120131095606.GA889@n2100.arm.linux.org.uk>
 <CAMQu2gwG_JwPMzV0v2hedvDz=HHq0SNbbH+Zapyd8fJt47kjGQ@mail.gmail.com>
 <alpine.LFD.2.02.1201311315420.2759@xanadu.home>
Message-ID: <CAMQu2gw1T_PR5fQAXvD2dxy7zY8WXcBaFAtqnRsZEYhNnFZung@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 11:57 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:

[...]

>> I also understand that patching early common code is going to be tricky
>> and of-course against the single zImage.
>>
>> So the option mentioned by Nicolas and Catalin about 1:1 mapping
>> and configuring the registers in platform specific code was looking
>> a way forward. So was asking more questions about whether this can
>> work in all cases. Specifically for A15.
>
> So far this is apparently your best option. ?And luckily the code to
> create a 1:1 mapping, turn off MMU, then turn MMU back on and tear down
> the 1:1 mapping already exists. ?All you need to do is to insert the
> cache workaround activation in the middle of that instead of shutting
> the CPU down.
>
thanks.

>> As per Catalin's email, it is best to handle those cases before MMU is
>> enabled with boot-monitor or pre-load code.
>
> These days bootloaders are turning the MMU on for themselves, so you'll
> need pre-load code for the bootloader already. ?Either that, or the
> issue is not necessarily _that_ critical in which case you can afford to
> enable your workaround a bit later during the kernel boot.
>
This is indeed a good point.
The mainline u-boot(denx) now a days have MMU support so we need to have
the necessary WA before that code anyways.

We will attempt the 1:1 mapping option as well but to be 100 % safe for
the previous 3 statges of MMU ON ( 1. Bootloader, 2. De-compressor
and 3. Kernel setup), looks like moving all of this security settings
before all 3 stages is most appropriate.

Thanks for the good discussion.

Regards
Santosh
