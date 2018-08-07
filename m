From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 7 Aug 2018 16:40:39 +0200
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808071010240.11209@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
 <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com>
 <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu87YqLM=FFZ6V8rHhuhskDdsBUuXFpqNKVbXWqdnuNEyA@mail.gmail.com>
 <alpine.LRH.2.02.1808060639200.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8HyHX8qjg1qHV2M9Re+RGQJigjdAFVC_yR4niGkk2ikA@mail.gmail.com>
 <alpine.LRH.2.02.1808060700070.10220@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8384LZwL898wJ8BKjmJNzvd+-cSFUp4X4OpfmRDCP4Ng@mail.gmail.com>
 <alpine.LRH.2.02.1808071010240.11209@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <CAKv+Gu_h6DDW4tvECrj3rGUaii4-2audYpYYiJQXfbEMch2pDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 August 2018 at 16:14, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Mon, 6 Aug 2018, Ard Biesheuvel wrote:
>
>> No that works fine for me. VDPAU acceleration works as well, but it
>> depends on your chromium build whether it can actually use it, I
>> think? In any case, mplayer can use vdpau to play 1080p h264 without
>> breaking a sweat on this system.
>>
>> Note that the VDPAU driver also relies on memory semantics, i.e., it
>> may use DC ZVA (zero cacheline) instructions which are not permitted
>> on device mappings. This is probably just glibc's memset() being
>> invoked, but I remember hitting this on another PCIe-impaired arm64
>> system with Synopsys PCIe IP
>
> DC ZVA can be disabled with the SCTRL_EL1.DZE bit, so that neither kernel
> nor userspace will use it.

Of course, but only the OS can do that, and only system wide unless
we're eager to create infrastructure for managing this per process.

But it is also beside the point: I mentioned it to illustrate that
even use cases like libvdpau that don't operate on the 'framebuffer'
abstraction make assumptions about VRAM having true memory semantics.

> If the mapping didn't support unaligned writes,
> it would be worse.
>
> Mikulas
