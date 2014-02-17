From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 18:57:27 +0900
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <20140217091237.GC2633@katana>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
 <20140217091237.GC2633@katana>
Message-ID: <CANqRtoT50=Wb8G=qsWfo2hcKmszeKuRNm5mAqosGMV6e2MgDGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 6:12 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > Why is that? From my knowledge, you start with the exact compatible
>> > property and hardware compatible entries may follow.
>>
>> I think this boils down to if they really are compatible or not. If
>> for instance a 16550 port would be compatible with 8250 on a hardware
>> level then using them in the order of "16550", "8250" makes sense. In
>> this case the r8a7791 i2c is not really strictly based on r8a7790 i2c,
>> it is just that r8a7790 has support in the driver. So it's a short cut
>> instead of actual hardware compatibility.
>
> I don't get this point. The legacy board code for koelsch and lager both
> create a platform_device with "i2c-rcar_gen2", so the cores surely must
> be compatible? Maybe the cores are not strictly based on each other, but
> compatible, yes, I'd say.

The devices may be compatible seen from the limited use case coming
from the current version of the device driver. But that does not
necessarily mean they are compatible from a hardware point of view. My
view is that the hardware should not be seen compatible unless it is
explicitly documented to be so.

For platform devices we make use of "unstable ids" or feature flags to
describe a certain part of hardware as we know it at the time of
writing the code. Then we can update the features in the driver and
make sure all in-tree boards/socs using the "unstable id" keeps on
working by for instance adjusting platform data or adding resources. I
think this is a fine model for platform devices.

In my mind the above model is quite different from how I think we
should describe devices via DT. In the DT case I think it is wrong to
rely on software defined "unstable ids" like for instance
"i2c-rcar-gen2" because they are built on our perhaps limited
interpretation of the hardware. Of course, if the hardware
documentation would be correct and we have hardware ids described in
the documentation then we can start using those as compatible strings.
Until then I feel it is safe to use the SoC name in the compatible
string.

Cheers,

/ magnus
