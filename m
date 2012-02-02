From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Feb 2012 14:32:03 +0000
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
In-Reply-To: <alpine.LFD.2.02.1201311253460.2759@xanadu.home>
References: <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
 <4F277A6E.9070107@ti.com>
 <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com>
 <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
 <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com>
 <alpine.LFD.2.02.1201311253460.2759@xanadu.home>
Message-ID: <CAHkRjk690R951NUDC_erNsBtbmtrM-nPjY2gR=Tf-sW4qXX7ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(sorry, I'm slow at replying, attending some internal ARM conference)

On 31 January 2012 18:09, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 31 Jan 2012, Catalin Marinas wrote:
>> Maybe we could factor out the CPU-specific settings from proc-v*.S
>> into a separate arch/arm/boot/preload directory. We keep proc-v*.S
>> entirely generic and the implementation-defined bits setting in the
>> preload code. You could have an option to link the preload with the
>> kernel but we could recommend that people run this code from
>> boot-loader before invoking the kernel. This code would be dependent
>> on platform and chosen at build-time. But the actual kernel image
>> would be generic.
>
> I'd recommend against that. ?Again, the reason is not technical but
> rather has to do with the tendency to laziness of human beings. ?So
> please let's not go there or it'll become the de facto standard.
...
> The whole idea behind having a generic kernel is all about
> distributions. ?If a generic kernel has to be distributed with a
> platform specific pre-kernel blob then we've gained nothing.

The problem we have with a generic kernel in this context (e.g. errata
bits) is that even though we use a read-check-write sequence for
setting various bits during __v*_setup, as long as the boot loader did
not set them the kernel will try a write access and fail. So with the
current scenario, there is no way for an OMAP platform to run a
generic kernel in non-secure mode (with all errata workarounds
enabled) without modifying the boot loader.

> Same goes
> for the DTB. ?Those platform specific blobs must be distributed _with_
> the hardware and _not_ with the software distribution. ?Having the dts
> files in the kernel right now is only a convenience for the transition
> to device tree.

We could do the same and move the bit enabling to separate repository :).

An alternative would be to also move those bits setting at a later
time in the kernel booting (and re-disabling/enabling the MMU) as we
don't have an easy way of figuring out whether the kernel is running
in secure or non-secure mode.

-- 
Catalin
