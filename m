From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 15 Aug 2013 22:49:05 +0100
Subject: [Qemu-devel] SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <20130815205044.GA21599@roeck-us.net>
References: <5207B3C3.9080508@roeck-us.net>
 <20130811220450.GY23006@n2100.arm.linux.org.uk>
 <52082EF8.10005@roeck-us.net>
 <CAFEAcA94ygwRPSsfxs3DvOcTZbdafLiEHys94FG4aXUx+A1t=A@mail.gmail.com>
 <20130813034054.GA18218@roeck-us.net>
 <CAFEAcA_-S8z6ZMr8TMPvkcTyyCSMOj1DExVsY4JDQjRXDU5WGw@mail.gmail.com>
 <20130815175428.GA18580@roeck-us.net>
 <CAFEAcA_MyJPwo6Gd_dxeWM5q5-7MYqR6-rrePusFzYaGGckWJQ@mail.gmail.com>
 <20130815205044.GA21599@roeck-us.net>
Message-ID: <CAFEAcA-ALD+dDWAB+Rd1V+TXQLYGe-qRKC0uFUP0Bt2SGfKDRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2013 21:50, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Aug 15, 2013 at 07:05:22PM +0100, Peter Maydell wrote:
>> It needs to go in the same patch, because a kernel with the fixed
>> irq remapping must also tell QEMU it is fixed; if you split the
>> two then at the point between the two patches the kernel is
>> broken for bisection purposes.
>>
> Thinking about it - is that really true ? My image with the
> patch applied works just fine under qemu 1.5.2, and unless
> I am missing something it won't work with qemu 1.4 anyway.
> So what exactly is broken ?

You're OK unless the kernel happens to pick the same interrupt
number to write to PCI_INTERRUPT_LINE as one of the previous
broken kernel versions did (in which case QEMU will incorrectly
assume you're a broken kernel). This can't happen with the way
the kernel is currently picking interrupt numbers (ie with a
straightforward relationship between h/w irqs and values written),
but as I understand from Arnd there is a plan to move to a
different approach ("sparse irqs") at which point this won't hold:
http://lists.gnu.org/archive/html/qemu-devel/2013-03/msg04579.html
So it's better for the kernel to make sure it gets the
behaviour it wants rather than getting unpleasant surprises
later.

-- PMM
